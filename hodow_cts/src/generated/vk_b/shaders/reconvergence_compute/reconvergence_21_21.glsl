#version 450 core
#extension GL_KHR_shader_subgroup_ballot : enable
#extension GL_KHR_shader_subgroup_vote : enable
#extension GL_NV_shader_subgroup_partitioned : enable
#extension GL_EXT_subgroup_uniform_control_flow : enable
#extension GL_EXT_maximal_reconvergence : require
layout(local_size_x_id = 0, local_size_y_id = 1, local_size_z = 1) in;
layout(set=0, binding=2) coherent buffer OutputC { uint loc[]; } outputC;
layout(set=0, binding=1) coherent buffer OutputB { uvec4 b[]; } outputB;
layout(set=0, binding=0) coherent buffer InputA  { uint  a[]; } inputA;
layout(push_constant) uniform PC {
   // set to the real stride when writing out ballots, or zero when just counting
   int  invocationStride;
   // wildcard fields, for an example the dimensions of rendered area in the case of graphics shaders
   int  width;
   int  height;
   uint primitiveStride;
   uint subgroupStride;
   uint enableInvocationIndex;
};
int outLoc = 0;
bool testBit(uvec4 mask, uint bit) { return ((mask[bit / 32] >> (bit % 32)) & 1) != 0; }
uint elect() { return int(subgroupElect()) + 1; }
layout(constant_id = 10) const uint cmpIndex0 = 0u;
layout(constant_id = 11) const uint cmpIndex1 = 0u;


void main()
[[maximally_reconverges]]
{

    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
    if (testBit(uvec4(0x5e7c62c7, 0x70aa04d5, 0xd5ac6041, 0xab1a9911), gl_SubgroupInvocationID)) {
        if (subgroupElect()) {
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        }
    }
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
    if (testBit(uvec4(0x5e7c62c7, 0x70aa04d5, 0xd5ac6041, 0xab1a9911), gl_SubgroupInvocationID)) {
        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        }
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
    } else {
        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000e;
        } else {
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10012;
    }
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10015;
    if (testBit(uvec4(0xca5a5b81, 0x51702d72, 0x4762f0d4, 0xd50571b4), gl_SubgroupInvocationID)) {
        switch (gl_SubgroupInvocationID & 3) {
            case 0:
            {
                break;
            }
            case 1:
            {
                break;
            }
            case 2:
            {
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                break;
            }
            case 3:
            {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10020;
                break;
            }
        }
        if (testBit(uvec4(0x5e7c62c7, 0x70aa04d5, 0xd5ac6041, 0xab1a9911), gl_SubgroupInvocationID)) {
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10025;
        } else {
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        }
    }



}
#version 450 core
#extension GL_KHR_shader_subgroup_ballot : enable
#extension GL_KHR_shader_subgroup_vote : enable
#extension GL_NV_shader_subgroup_partitioned : enable
#extension GL_EXT_subgroup_uniform_control_flow : enable
#extension GL_EXT_maximal_reconvergence : require
layout(local_size_x_id = 0, local_size_y_id = 1, local_size_z = 1) in;
layout(set=0, binding=2) coherent buffer OutputC { uint loc[]; } outputC;
layout(set=0, binding=1) coherent buffer OutputB { uvec4 b[]; } outputB;
layout(set=0, binding=0) coherent buffer InputA  { uint  a[]; } inputA;
layout(push_constant) uniform PC {
   // set to the real stride when writing out ballots, or zero when just counting
   int  invocationStride;
   // wildcard fields, for an example the dimensions of rendered area in the case of graphics shaders
   int  width;
   int  height;
   uint primitiveStride;
   uint subgroupStride;
   uint enableInvocationIndex;
};
int outLoc = 0;
bool testBit(uvec4 mask, uint bit) { return ((mask[bit / 32] >> (bit % 32)) & 1) != 0; }
uint elect() { return int(subgroupElect()) + 1; }
layout(constant_id = 10) const uint cmpIndex0 = 0u;
layout(constant_id = 11) const uint cmpIndex1 = 0u;
layout(constant_id = 12) const uint cmpIndex2 = 0u;


void main()
[[maximally_reconverges]]
{

    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
        switch (gl_SubgroupInvocationID & 3) {
            case 0:
            {
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10004;
                break;
            }
            case 1:
            {
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                break;
            }
            case 2:
            {
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                break;
            }
            case 3:
            {
                break;
            }
        }
    } else {
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        if (subgroupElect()) {
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10013;
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10015;
    }
    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex2]) {
        }
        if (testBit(uvec4(0x579965e, 0xdcab3315, 0xc6e61baa, 0x8b38dac5), gl_SubgroupInvocationID)) {
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        }
    }



}
#version 450 core
#extension GL_KHR_shader_subgroup_ballot : enable
#extension GL_KHR_shader_subgroup_vote : enable
#extension GL_NV_shader_subgroup_partitioned : enable
#extension GL_EXT_subgroup_uniform_control_flow : enable
#extension GL_EXT_maximal_reconvergence : require
layout(local_size_x_id = 0, local_size_y_id = 1, local_size_z = 1) in;
layout(set=0, binding=2) coherent buffer OutputC { uint loc[]; } outputC;
layout(set=0, binding=1) coherent buffer OutputB { uvec4 b[]; } outputB;
layout(set=0, binding=0) coherent buffer InputA  { uint  a[]; } inputA;
layout(push_constant) uniform PC {
   // set to the real stride when writing out ballots, or zero when just counting
   int  invocationStride;
   // wildcard fields, for an example the dimensions of rendered area in the case of graphics shaders
   int  width;
   int  height;
   uint primitiveStride;
   uint subgroupStride;
   uint enableInvocationIndex;
};
int outLoc = 0;
bool testBit(uvec4 mask, uint bit) { return ((mask[bit / 32] >> (bit % 32)) & 1) != 0; }
uint elect() { return int(subgroupElect()) + 1; }
layout(constant_id = 10) const uint cmpIndex0 = 0u;
layout(constant_id = 11) const uint cmpIndex1 = 0u;


void main()
[[maximally_reconverges]]
{

    {
        int loopIdx0 = 0;
        do {
            loopIdx0++;
            return;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        } while (loopIdx0 < inputA.a[5]);
    }
    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        if (testBit(uvec4(0x91b3bcd8, 0x6a4b0e01, 0x2033a7ef, 0xef82cc51), gl_SubgroupInvocationID)) {
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        }
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
    }
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000d;
        {
            int loopIdx0 = 0;
            do {
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                if (subgroupElect()) {
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    break;
                }
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                loopIdx0++;
            } while (true);
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10016;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
    } else {
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000d;
        {
            int loopIdx0 = 0;
            do {
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                if (subgroupElect()) {
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    break;
                }
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                loopIdx0++;
            } while (true);
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10016;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
    }
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);



}
#version 450 core
#extension GL_KHR_shader_subgroup_ballot : enable
#extension GL_KHR_shader_subgroup_vote : enable
#extension GL_NV_shader_subgroup_partitioned : enable
#extension GL_EXT_subgroup_uniform_control_flow : enable
#extension GL_EXT_maximal_reconvergence : require
layout(local_size_x_id = 0, local_size_y_id = 1, local_size_z = 1) in;
layout(set=0, binding=2) coherent buffer OutputC { uint loc[]; } outputC;
layout(set=0, binding=1) coherent buffer OutputB { uvec4 b[]; } outputB;
layout(set=0, binding=0) coherent buffer InputA  { uint  a[]; } inputA;
layout(push_constant) uniform PC {
   // set to the real stride when writing out ballots, or zero when just counting
   int  invocationStride;
   // wildcard fields, for an example the dimensions of rendered area in the case of graphics shaders
   int  width;
   int  height;
   uint primitiveStride;
   uint subgroupStride;
   uint enableInvocationIndex;
};
int outLoc = 0;
bool testBit(uvec4 mask, uint bit) { return ((mask[bit / 32] >> (bit % 32)) & 1) != 0; }
uint elect() { return int(subgroupElect()) + 1; }


void main()
[[maximally_reconverges]]
{

    for (int loopIdx0 = 0;;loopIdx0++,    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true)) {
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10001;
        break;
        if (gl_SubgroupInvocationID == loopIdx0) {
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10005;
        if (subgroupElect()) {
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            break;
        }
        if (testBit(uvec4(0x5664d7eb, 0xdcbb511b, 0x9578e94b, 0xd825b137), gl_SubgroupInvocationID)) {
            break;
        } else {
            break;
        }
        if (subgroupElect()) {
        }
    }
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10013;
    for (int loopIdx0 = 0;
             loopIdx0 < gl_SubgroupInvocationID + 1;
             loopIdx0++) {
        if (inputA.a[3] == 3) {
        }
        switch (loopIdx0) {
            case 1: {
                break;
            }
            case 2: {
                break;
            }
            default: {
                break;
            }
        }
    }



}
#version 450 core
#extension GL_KHR_shader_subgroup_ballot : enable
#extension GL_KHR_shader_subgroup_vote : enable
#extension GL_NV_shader_subgroup_partitioned : enable
#extension GL_EXT_subgroup_uniform_control_flow : enable
#extension GL_EXT_maximal_reconvergence : require
layout(local_size_x_id = 0, local_size_y_id = 1, local_size_z = 1) in;
layout(set=0, binding=2) coherent buffer OutputC { uint loc[]; } outputC;
layout(set=0, binding=1) coherent buffer OutputB { uvec4 b[]; } outputB;
layout(set=0, binding=0) coherent buffer InputA  { uint  a[]; } inputA;
layout(push_constant) uniform PC {
   // set to the real stride when writing out ballots, or zero when just counting
   int  invocationStride;
   // wildcard fields, for an example the dimensions of rendered area in the case of graphics shaders
   int  width;
   int  height;
   uint primitiveStride;
   uint subgroupStride;
   uint enableInvocationIndex;
};
int outLoc = 0;
bool testBit(uvec4 mask, uint bit) { return ((mask[bit / 32] >> (bit % 32)) & 1) != 0; }
uint elect() { return int(subgroupElect()) + 1; }
layout(constant_id = 10) const uint cmpIndex0 = 0u;
layout(constant_id = 11) const uint cmpIndex1 = 0u;
layout(constant_id = 12) const uint cmpIndex2 = 0u;
layout(constant_id = 13) const uint cmpIndex3 = 0u;


void main()
[[maximally_reconverges]]
{

    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        {
            int loopIdx0 = 0;
            do {
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10004;
                if (subgroupElect()) {
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    break;
                }
                loopIdx0++;
            } while (true);
        }
    }
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex2]) {
        } else {
        }
        if (inputA.a[2] == 2) {
        } else {
        }
    } else {
        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex3]) {
        } else {
        }
        if (inputA.a[0] == 0) {
        } else {
        }
    }
    if (testBit(uvec4(0xccc1efae, 0x75923b03, 0x67c06410, 0xe210c4fd), gl_SubgroupInvocationID)) {
        if (inputA.a[2] == 2) {
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        }
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
    } else {
        for (int loopIdx0 = 0;
                 loopIdx0 < gl_SubgroupInvocationID + 1;
                 loopIdx0++) {
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10024;
        if (testBit(uvec4(0xe3ab482f, 0xa7752ed8, 0x7b9fd946, 0x9117fd06), gl_SubgroupInvocationID)) {
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        }
    }



}
#version 450 core
#extension GL_KHR_shader_subgroup_ballot : enable
#extension GL_KHR_shader_subgroup_vote : enable
#extension GL_NV_shader_subgroup_partitioned : enable
#extension GL_EXT_subgroup_uniform_control_flow : enable
#extension GL_EXT_maximal_reconvergence : require
layout(local_size_x_id = 0, local_size_y_id = 1, local_size_z = 1) in;
layout(set=0, binding=2) coherent buffer OutputC { uint loc[]; } outputC;
layout(set=0, binding=1) coherent buffer OutputB { uvec4 b[]; } outputB;
layout(set=0, binding=0) coherent buffer InputA  { uint  a[]; } inputA;
layout(push_constant) uniform PC {
   // set to the real stride when writing out ballots, or zero when just counting
   int  invocationStride;
   // wildcard fields, for an example the dimensions of rendered area in the case of graphics shaders
   int  width;
   int  height;
   uint primitiveStride;
   uint subgroupStride;
   uint enableInvocationIndex;
};
int outLoc = 0;
bool testBit(uvec4 mask, uint bit) { return ((mask[bit / 32] >> (bit % 32)) & 1) != 0; }
uint elect() { return int(subgroupElect()) + 1; }
layout(constant_id = 10) const uint cmpIndex0 = 0u;
layout(constant_id = 11) const uint cmpIndex1 = 0u;
layout(constant_id = 12) const uint cmpIndex2 = 0u;
layout(constant_id = 13) const uint cmpIndex3 = 0u;
layout(constant_id = 14) const uint cmpIndex4 = 0u;


void main()
[[maximally_reconverges]]
{

    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
    if (inputA.a[2] == 2) {
        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
        } else {
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        }
        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10008;
        }
    } else {
        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex2]) {
        } else {
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000e;
        }
        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex3]) {
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        } else {
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        }
    }
    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex4]) {
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10017;
        switch (gl_SubgroupInvocationID & 3) {
            case 0:
            {
                break;
            }
            case 1:
            {
                break;
            }
            case 2:
            {
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                break;
            }
            case 3:
            {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10021;
                break;
            }
        }
    } else {
        for (int loopIdx0 = 0;;loopIdx0++,        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true)) {
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            if (subgroupElect()) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10028;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                break;
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002c;
        }
    }



}
#version 450 core
#extension GL_KHR_shader_subgroup_ballot : enable
#extension GL_KHR_shader_subgroup_vote : enable
#extension GL_NV_shader_subgroup_partitioned : enable
#extension GL_EXT_subgroup_uniform_control_flow : enable
#extension GL_EXT_maximal_reconvergence : require
layout(local_size_x_id = 0, local_size_y_id = 1, local_size_z = 1) in;
layout(set=0, binding=2) coherent buffer OutputC { uint loc[]; } outputC;
layout(set=0, binding=1) coherent buffer OutputB { uvec4 b[]; } outputB;
layout(set=0, binding=0) coherent buffer InputA  { uint  a[]; } inputA;
layout(push_constant) uniform PC {
   // set to the real stride when writing out ballots, or zero when just counting
   int  invocationStride;
   // wildcard fields, for an example the dimensions of rendered area in the case of graphics shaders
   int  width;
   int  height;
   uint primitiveStride;
   uint subgroupStride;
   uint enableInvocationIndex;
};
int outLoc = 0;
bool testBit(uvec4 mask, uint bit) { return ((mask[bit / 32] >> (bit % 32)) & 1) != 0; }
uint elect() { return int(subgroupElect()) + 1; }


void main()
[[maximally_reconverges]]
{

    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10000;
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
    switch (inputA.a[2]) {
        case 3:
        {
            if (subgroupElect()) {
            }
            break;
        }
        case 2:
        {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10008;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            switch (gl_SubgroupInvocationID & 3) {
                case 0:
                {
                    break;
                }
                case 1:
                {
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    break;
                }
                case 2:
                {
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    break;
                }
                case 3:
                {
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    break;
                }
            }
            break;
        }
        case 4:
        {
            if (subgroupElect()) {
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001b;
            }
            break;
        }
    }



}
#version 450 core
#extension GL_KHR_shader_subgroup_ballot : enable
#extension GL_KHR_shader_subgroup_vote : enable
#extension GL_NV_shader_subgroup_partitioned : enable
#extension GL_EXT_subgroup_uniform_control_flow : enable
#extension GL_EXT_maximal_reconvergence : require
layout(local_size_x_id = 0, local_size_y_id = 1, local_size_z = 1) in;
layout(set=0, binding=2) coherent buffer OutputC { uint loc[]; } outputC;
layout(set=0, binding=1) coherent buffer OutputB { uvec4 b[]; } outputB;
layout(set=0, binding=0) coherent buffer InputA  { uint  a[]; } inputA;
layout(push_constant) uniform PC {
   // set to the real stride when writing out ballots, or zero when just counting
   int  invocationStride;
   // wildcard fields, for an example the dimensions of rendered area in the case of graphics shaders
   int  width;
   int  height;
   uint primitiveStride;
   uint subgroupStride;
   uint enableInvocationIndex;
};
int outLoc = 0;
bool testBit(uvec4 mask, uint bit) { return ((mask[bit / 32] >> (bit % 32)) & 1) != 0; }
uint elect() { return int(subgroupElect()) + 1; }
layout(constant_id = 10) const uint cmpIndex0 = 0u;
layout(constant_id = 11) const uint cmpIndex1 = 0u;


void main()
[[maximally_reconverges]]
{

    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
        if (testBit(uvec4(0x467d6e76, 0x4b45c110, 0xdc26e53e, 0xc4601a6e), gl_SubgroupInvocationID)) {
        }
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        {
            int loopIdx0 = 0;
            do {
                if (subgroupElect()) {
                    break;
                }
                loopIdx0++;
            } while (true);
        }
    }
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000b;
    if (testBit(uvec4(0x46e97b9d, 0xf7a119c6, 0xb4d59165, 0xb0864334), gl_SubgroupInvocationID)) {
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        if (testBit(uvec4(0xca3d6b2e, 0x914630b3, 0xb676d508, 0x160db633), gl_SubgroupInvocationID)) {
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10010;
        }
        for (int loopIdx0 = 0;
                 loopIdx0 < inputA.a[1];
                 loopIdx0++) {
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        }
    }
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
        switch (gl_SubgroupInvocationID & 3) {
            case 0:
            {
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                break;
            }
            case 1:
            {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001d;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                break;
            }
            case 2:
            {
                break;
            }
            case 3:
            {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10023;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                break;
            }
        }
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
    } else {
        switch (gl_SubgroupInvocationID & 3) {
            case 0:
            {
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                break;
            }
            case 1:
            {
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                break;
            }
            case 2:
            {
                break;
            }
            case 3:
            {
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                break;
            }
        }
    }
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);



}
#version 450 core
#extension GL_KHR_shader_subgroup_ballot : enable
#extension GL_KHR_shader_subgroup_vote : enable
#extension GL_NV_shader_subgroup_partitioned : enable
#extension GL_EXT_subgroup_uniform_control_flow : enable
#extension GL_EXT_maximal_reconvergence : require
layout(local_size_x_id = 0, local_size_y_id = 1, local_size_z = 1) in;
layout(set=0, binding=2) coherent buffer OutputC { uint loc[]; } outputC;
layout(set=0, binding=1) coherent buffer OutputB { uvec4 b[]; } outputB;
layout(set=0, binding=0) coherent buffer InputA  { uint  a[]; } inputA;
layout(push_constant) uniform PC {
   // set to the real stride when writing out ballots, or zero when just counting
   int  invocationStride;
   // wildcard fields, for an example the dimensions of rendered area in the case of graphics shaders
   int  width;
   int  height;
   uint primitiveStride;
   uint subgroupStride;
   uint enableInvocationIndex;
};
int outLoc = 0;
bool testBit(uvec4 mask, uint bit) { return ((mask[bit / 32] >> (bit % 32)) & 1) != 0; }
uint elect() { return int(subgroupElect()) + 1; }


void main()
[[maximally_reconverges]]
{

    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
    if (testBit(uvec4(0x5e7c62c7, 0x70aa04d5, 0xd5ac6041, 0xab1a9911), gl_SubgroupInvocationID)) {
        if (subgroupElect()) {
            if (testBit(uvec4(0x5e7c62c7, 0x70aa04d5, 0xd5ac6041, 0xab1a9911), gl_SubgroupInvocationID)) {
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            } else {
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            }
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        }
        if (inputA.a[1] == 1) {
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            for (int loopIdx0 = 0;;loopIdx0++,            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true)) {
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                if (subgroupElect()) {
                    break;
                }
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            }
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            if (subgroupElect()) {
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            }
        } else {
            switch (gl_SubgroupInvocationID & 3) {
                case 0:
                {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001a;
                    break;
                }
                case 1:
                {
                    break;
                }
                case 2:
                {
                    break;
                }
                case 3:
                {
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    break;
                }
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10024;
            if (subgroupElect()) {
            }
        }
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
    } else {
        if (subgroupElect()) {
            if (subgroupElect()) {
            }
            if (inputA.a[1] == 1) {
            }
        }
    }



}
#version 450 core
#extension GL_KHR_shader_subgroup_ballot : enable
#extension GL_KHR_shader_subgroup_vote : enable
#extension GL_NV_shader_subgroup_partitioned : enable
#extension GL_EXT_subgroup_uniform_control_flow : enable
#extension GL_EXT_maximal_reconvergence : require
layout(local_size_x_id = 0, local_size_y_id = 1, local_size_z = 1) in;
layout(set=0, binding=2) coherent buffer OutputC { uint loc[]; } outputC;
layout(set=0, binding=1) coherent buffer OutputB { uvec4 b[]; } outputB;
layout(set=0, binding=0) coherent buffer InputA  { uint  a[]; } inputA;
layout(push_constant) uniform PC {
   // set to the real stride when writing out ballots, or zero when just counting
   int  invocationStride;
   // wildcard fields, for an example the dimensions of rendered area in the case of graphics shaders
   int  width;
   int  height;
   uint primitiveStride;
   uint subgroupStride;
   uint enableInvocationIndex;
};
int outLoc = 0;
bool testBit(uvec4 mask, uint bit) { return ((mask[bit / 32] >> (bit % 32)) & 1) != 0; }
uint elect() { return int(subgroupElect()) + 1; }
layout(constant_id = 10) const uint cmpIndex0 = 0u;
layout(constant_id = 11) const uint cmpIndex1 = 0u;


void main()
[[maximally_reconverges]]
{

    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
        switch (gl_SubgroupInvocationID & 3) {
            case 0:
            {
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10004;
                break;
            }
            case 1:
            {
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                if (inputA.a[1] == 1) {
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                } else {
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000c;
                }
                break;
            }
            case 2:
            {
                break;
            }
            case 3:
            {
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10013;
                if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
                break;
            }
        }
    } else {
        {
            int loopIdx0 = 0;
            do {
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                {
                    int loopIdx1 = 0;
                    do {
                        loopIdx1++;
                    } while (loopIdx1 < inputA.a[1]);
                }
                if (inputA.a[3] == 3) {
                }
                if (subgroupElect()) {
                    break;
                }
                if (testBit(uvec4(0x812c43cc, 0x2f392383, 0xd1212f39, 0x629a3975), gl_SubgroupInvocationID)) {
                } else {
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
                switch (gl_SubgroupInvocationID & 3) {
                    case 0:
                    {
                        break;
                    }
                    case 1:
                    {
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        break;
                    }
                    case 2:
                    {
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        break;
                    }
                    case 3:
                    {
                        break;
                    }
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10033;
                loopIdx0++;
            } while (true);
        }
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10036;
    }
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);



}
#version 450 core
#extension GL_KHR_shader_subgroup_ballot : enable
#extension GL_KHR_shader_subgroup_vote : enable
#extension GL_NV_shader_subgroup_partitioned : enable
#extension GL_EXT_subgroup_uniform_control_flow : enable
#extension GL_EXT_maximal_reconvergence : require
layout(local_size_x_id = 0, local_size_y_id = 1, local_size_z = 1) in;
layout(set=0, binding=2) coherent buffer OutputC { uint loc[]; } outputC;
layout(set=0, binding=1) coherent buffer OutputB { uvec4 b[]; } outputB;
layout(set=0, binding=0) coherent buffer InputA  { uint  a[]; } inputA;
layout(push_constant) uniform PC {
   // set to the real stride when writing out ballots, or zero when just counting
   int  invocationStride;
   // wildcard fields, for an example the dimensions of rendered area in the case of graphics shaders
   int  width;
   int  height;
   uint primitiveStride;
   uint subgroupStride;
   uint enableInvocationIndex;
};
int outLoc = 0;
bool testBit(uvec4 mask, uint bit) { return ((mask[bit / 32] >> (bit % 32)) & 1) != 0; }
uint elect() { return int(subgroupElect()) + 1; }
layout(constant_id = 10) const uint cmpIndex0 = 0u;
layout(constant_id = 11) const uint cmpIndex1 = 0u;
layout(constant_id = 12) const uint cmpIndex2 = 0u;
layout(constant_id = 13) const uint cmpIndex3 = 0u;


void main()
[[maximally_reconverges]]
{

    {
        int loopIdx0 = 0;
        do {
            loopIdx0++;
            return;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        } while (loopIdx0 < inputA.a[5]);
    }
    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        if (testBit(uvec4(0x91b3bcd8, 0x6a4b0e01, 0x2033a7ef, 0xef82cc51), gl_SubgroupInvocationID)) {
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            } else {
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000d;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        } else {
            switch (gl_SubgroupInvocationID & 3) {
                case 0:
                {
                    break;
                }
                case 1:
                {
                    break;
                }
                case 2:
                {
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    break;
                }
                case 3:
                {
                    break;
                }
            }
            if (inputA.a[2] == 2) {
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001d;
            } else {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001f;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            }
        }
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        switch (gl_SubgroupInvocationID & 3) {
            case 0:
            {
                if (gl_LocalInvocationIndex >= inputA.a[cmpIndex2]) {
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
                break;
            }
            case 1:
            {
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                {
                    int loopIdx0 = 0;
                    do {
                        if (subgroupElect()) {
                            break;
                        }
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        loopIdx0++;
                    } while (true);
                }
                break;
            }
            case 2:
            {
                if (gl_LocalInvocationIndex >= inputA.a[cmpIndex3]) {
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                } else {
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10038;
                }
                break;
            }
            case 3:
            {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1003c;
                {
                    int loopIdx0 = 0;
                    do {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1003e;
                        if (subgroupElect()) {
                            break;
                        }
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        loopIdx0++;
                    } while (true);
                }
                break;
            }
        }
    }



}
#version 450 core
#extension GL_KHR_shader_subgroup_ballot : enable
#extension GL_KHR_shader_subgroup_vote : enable
#extension GL_NV_shader_subgroup_partitioned : enable
#extension GL_EXT_subgroup_uniform_control_flow : enable
#extension GL_EXT_maximal_reconvergence : require
layout(local_size_x_id = 0, local_size_y_id = 1, local_size_z = 1) in;
layout(set=0, binding=2) coherent buffer OutputC { uint loc[]; } outputC;
layout(set=0, binding=1) coherent buffer OutputB { uvec4 b[]; } outputB;
layout(set=0, binding=0) coherent buffer InputA  { uint  a[]; } inputA;
layout(push_constant) uniform PC {
   // set to the real stride when writing out ballots, or zero when just counting
   int  invocationStride;
   // wildcard fields, for an example the dimensions of rendered area in the case of graphics shaders
   int  width;
   int  height;
   uint primitiveStride;
   uint subgroupStride;
   uint enableInvocationIndex;
};
int outLoc = 0;
bool testBit(uvec4 mask, uint bit) { return ((mask[bit / 32] >> (bit % 32)) & 1) != 0; }
uint elect() { return int(subgroupElect()) + 1; }
layout(constant_id = 10) const uint cmpIndex0 = 0u;
layout(constant_id = 11) const uint cmpIndex1 = 0u;


void main()
[[maximally_reconverges]]
{

    for (int loopIdx0 = 0;;loopIdx0++,    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true)) {
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10001;
        break;
        if (gl_SubgroupInvocationID == loopIdx0) {
            if (inputA.a[3] == 3) {
            } else {
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            }
            if (gl_SubgroupInvocationID == loopIdx0) {
            } else {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000a;
            }
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        } else {
            break;
        }
        if (subgroupElect()) {
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            break;
        }
        if (gl_SubgroupInvocationID == loopIdx0) {
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10016;
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10018;
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            } else {
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            }
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        } else {
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            if (testBit(uvec4(0x9b54ecd6, 0x8188af72, 0xf3e714de, 0x4343808e), gl_SubgroupInvocationID)) {
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            } else {
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            }
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10027;
            switch (gl_SubgroupInvocationID & 3) {
                case 0:
                {
                    break;
                }
                case 1:
                {
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    break;
                }
                case 2:
                {
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    break;
                }
                case 3:
                {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10032;
                    break;
                }
            }
        }
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        switch (gl_SubgroupInvocationID & 3) {
            case 0:
            {
                switch (gl_SubgroupInvocationID & 3) {
                    case 0:
                    {
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1003c;
                        break;
                    }
                    case 1:
                    {
                        break;
                    }
                    case 2:
                    {
                        break;
                    }
                    case 3:
                    {
                        break;
                    }
                }
                break;
            }
            case 1:
            {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10047;
                if (testBit(uvec4(0x9b54ecd6, 0x8188af72, 0xf3e714de, 0x4343808e), gl_SubgroupInvocationID)) {
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1004a;
                }
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                break;
            }
            case 2:
            {
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                if (subgroupElect()) {
                }
                break;
            }
            case 3:
            {
                for (int loopIdx1 = 0;
                         loopIdx1 < inputA.a[3];
                         loopIdx1++) {
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
                break;
            }
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10059;
    }



}
#version 450 core
#extension GL_KHR_shader_subgroup_ballot : enable
#extension GL_KHR_shader_subgroup_vote : enable
#extension GL_NV_shader_subgroup_partitioned : enable
#extension GL_EXT_subgroup_uniform_control_flow : enable
#extension GL_EXT_maximal_reconvergence : require
layout(local_size_x_id = 0, local_size_y_id = 1, local_size_z = 1) in;
layout(set=0, binding=2) coherent buffer OutputC { uint loc[]; } outputC;
layout(set=0, binding=1) coherent buffer OutputB { uvec4 b[]; } outputB;
layout(set=0, binding=0) coherent buffer InputA  { uint  a[]; } inputA;
layout(push_constant) uniform PC {
   // set to the real stride when writing out ballots, or zero when just counting
   int  invocationStride;
   // wildcard fields, for an example the dimensions of rendered area in the case of graphics shaders
   int  width;
   int  height;
   uint primitiveStride;
   uint subgroupStride;
   uint enableInvocationIndex;
};
int outLoc = 0;
bool testBit(uvec4 mask, uint bit) { return ((mask[bit / 32] >> (bit % 32)) & 1) != 0; }
uint elect() { return int(subgroupElect()) + 1; }
layout(constant_id = 10) const uint cmpIndex0 = 0u;
layout(constant_id = 11) const uint cmpIndex1 = 0u;


void main()
[[maximally_reconverges]]
{

    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        {
            int loopIdx0 = 0;
            do {
                {
                    int loopIdx1 = 0;
                    do {
                        loopIdx1++;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    } while (loopIdx1 < inputA.a[4]);
                }
                if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                } else {
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
                if (subgroupElect()) {
                    break;
                }
                if (inputA.a[3] == 3) {
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                } else {
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                switch (gl_SubgroupInvocationID & 3) {
                    case 0:
                    {
                        break;
                    }
                    case 1:
                    {
                        break;
                    }
                    case 2:
                    {
                        break;
                    }
                    case 3:
                    {
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        break;
                    }
                }
                loopIdx0++;
            } while (true);
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10020;
        {
            int loopIdx0 = 0;
            do {
                loopIdx0++;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                switch (gl_SubgroupInvocationID & 3) {
                    case 0:
                    {
                        break;
                    }
                    case 1:
                    {
                        break;
                    }
                    case 2:
                    {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10029;
                        break;
                    }
                    case 3:
                    {
                        break;
                    }
                }
                switch (gl_SubgroupInvocationID & 3) {
                    case 0:
                    {
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        break;
                    }
                    case 1:
                    {
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        break;
                    }
                    case 2:
                    {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10036;
                        break;
                    }
                    case 3:
                    {
                        break;
                    }
                }
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            } while (loopIdx0 < inputA.a[4]);
        }
    }



}
#version 450 core
#extension GL_KHR_shader_subgroup_ballot : enable
#extension GL_KHR_shader_subgroup_vote : enable
#extension GL_NV_shader_subgroup_partitioned : enable
#extension GL_EXT_subgroup_uniform_control_flow : enable
#extension GL_EXT_maximal_reconvergence : require
layout(local_size_x_id = 0, local_size_y_id = 1, local_size_z = 1) in;
layout(set=0, binding=2) coherent buffer OutputC { uint loc[]; } outputC;
layout(set=0, binding=1) coherent buffer OutputB { uvec4 b[]; } outputB;
layout(set=0, binding=0) coherent buffer InputA  { uint  a[]; } inputA;
layout(push_constant) uniform PC {
   // set to the real stride when writing out ballots, or zero when just counting
   int  invocationStride;
   // wildcard fields, for an example the dimensions of rendered area in the case of graphics shaders
   int  width;
   int  height;
   uint primitiveStride;
   uint subgroupStride;
   uint enableInvocationIndex;
};
int outLoc = 0;
bool testBit(uvec4 mask, uint bit) { return ((mask[bit / 32] >> (bit % 32)) & 1) != 0; }
uint elect() { return int(subgroupElect()) + 1; }
layout(constant_id = 10) const uint cmpIndex0 = 0u;
layout(constant_id = 11) const uint cmpIndex1 = 0u;
layout(constant_id = 12) const uint cmpIndex2 = 0u;
layout(constant_id = 13) const uint cmpIndex3 = 0u;


void main()
[[maximally_reconverges]]
{

    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
    if (inputA.a[0] == 0) {
        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
            if (testBit(uvec4(0xf77511fe, 0x9ecaa8ed, 0x511db92f, 0x8ad08538), gl_SubgroupInvocationID)) {
            } else {
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            }
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            {
                int loopIdx0 = 0;
                do {
                    if (subgroupElect()) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000a;
                        break;
                    }
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    loopIdx0++;
                } while (true);
            }
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10011;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        if (subgroupElect()) {
            if (subgroupElect()) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10015;
            }
        }
    } else {
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        if (testBit(uvec4(0x9e19d960, 0xdc84f6e8, 0x5cf95d28, 0x1058dec4), gl_SubgroupInvocationID)) {
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            } else {
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            }
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex2]) {
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            } else {
            }
        } else {
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex3]) {
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            }
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002a;
            switch (gl_SubgroupInvocationID & 3) {
                case 0:
                {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002d;
                    break;
                }
                case 1:
                {
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    break;
                }
                case 2:
                {
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    break;
                }
                case 3:
                {
                    break;
                }
            }
        }
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1003a;
        for (int loopIdx0 = 0;
                 loopIdx0 < inputA.a[2];
                 loopIdx0++) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1003c;
            for (int loopIdx1 = 0;
                     loopIdx1 < gl_SubgroupInvocationID + 1;
                     loopIdx1++) {
            }
            if (inputA.a[0] == 0) {
            }
        }
    }



}
#version 450 core
#extension GL_KHR_shader_subgroup_ballot : enable
#extension GL_KHR_shader_subgroup_vote : enable
#extension GL_NV_shader_subgroup_partitioned : enable
#extension GL_EXT_subgroup_uniform_control_flow : enable
#extension GL_EXT_maximal_reconvergence : require
layout(local_size_x_id = 0, local_size_y_id = 1, local_size_z = 1) in;
layout(set=0, binding=2) coherent buffer OutputC { uint loc[]; } outputC;
layout(set=0, binding=1) coherent buffer OutputB { uvec4 b[]; } outputB;
layout(set=0, binding=0) coherent buffer InputA  { uint  a[]; } inputA;
layout(push_constant) uniform PC {
   // set to the real stride when writing out ballots, or zero when just counting
   int  invocationStride;
   // wildcard fields, for an example the dimensions of rendered area in the case of graphics shaders
   int  width;
   int  height;
   uint primitiveStride;
   uint subgroupStride;
   uint enableInvocationIndex;
};
int outLoc = 0;
bool testBit(uvec4 mask, uint bit) { return ((mask[bit / 32] >> (bit % 32)) & 1) != 0; }
uint elect() { return int(subgroupElect()) + 1; }
layout(constant_id = 10) const uint cmpIndex0 = 0u;
layout(constant_id = 11) const uint cmpIndex1 = 0u;
layout(constant_id = 12) const uint cmpIndex2 = 0u;
layout(constant_id = 13) const uint cmpIndex3 = 0u;


void main()
[[maximally_reconverges]]
{

    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10000;
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
    switch (inputA.a[2]) {
        case 3:
        {
            if (subgroupElect()) {
                {
                    int loopIdx0 = 0;
                    do {
                        loopIdx0++;
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10006;
                    } while (loopIdx0 < inputA.a[3]);
                }
                if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                } else {
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000d;
            }
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            break;
        }
        case 2:
        {
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
                if (inputA.a[3] == 3) {
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10015;
                } else {
                }
                if (gl_LocalInvocationIndex >= inputA.a[cmpIndex2]) {
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
            }
            if (testBit(uvec4(0xe6163c7e, 0x3dd7ce3b, 0xf9c3ed9c, 0xcc6299f6), gl_SubgroupInvocationID)) {
                if (gl_LocalInvocationIndex >= inputA.a[cmpIndex3]) {
                }
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            }
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            break;
        }
        case 4:
        {
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            if (subgroupElect()) {
                {
                    int loopIdx0 = 0;
                    do {
                        loopIdx0++;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    } while (loopIdx0 < inputA.a[1]);
                }
            }
            break;
        }
    }



}
#version 450 core
#extension GL_KHR_shader_subgroup_ballot : enable
#extension GL_KHR_shader_subgroup_vote : enable
#extension GL_NV_shader_subgroup_partitioned : enable
#extension GL_EXT_subgroup_uniform_control_flow : enable
#extension GL_EXT_maximal_reconvergence : require
layout(local_size_x_id = 0, local_size_y_id = 1, local_size_z = 1) in;
layout(set=0, binding=2) coherent buffer OutputC { uint loc[]; } outputC;
layout(set=0, binding=1) coherent buffer OutputB { uvec4 b[]; } outputB;
layout(set=0, binding=0) coherent buffer InputA  { uint  a[]; } inputA;
layout(push_constant) uniform PC {
   // set to the real stride when writing out ballots, or zero when just counting
   int  invocationStride;
   // wildcard fields, for an example the dimensions of rendered area in the case of graphics shaders
   int  width;
   int  height;
   uint primitiveStride;
   uint subgroupStride;
   uint enableInvocationIndex;
};
int outLoc = 0;
bool testBit(uvec4 mask, uint bit) { return ((mask[bit / 32] >> (bit % 32)) & 1) != 0; }
uint elect() { return int(subgroupElect()) + 1; }
layout(constant_id = 10) const uint cmpIndex0 = 0u;
layout(constant_id = 11) const uint cmpIndex1 = 0u;
layout(constant_id = 12) const uint cmpIndex2 = 0u;


void main()
[[maximally_reconverges]]
{

    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
        if (testBit(uvec4(0x467d6e76, 0x4b45c110, 0xdc26e53e, 0xc4601a6e), gl_SubgroupInvocationID)) {
            for (int loopIdx0 = 0;;loopIdx0++,            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true)) {
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                if (subgroupElect()) {
                    break;
                }
            }
        }
        if (testBit(uvec4(0x2f6e89dc, 0xdc9414f6, 0xed09ba40, 0xa12fb872), gl_SubgroupInvocationID)) {
            {
                int loopIdx0 = 0;
                do {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000b;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    if (subgroupElect()) {
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000f;
                        break;
                    }
                    loopIdx0++;
                } while (true);
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10013;
        }
    }
    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10016;
    if (testBit(uvec4(0x2f6e89dc, 0xdc9414f6, 0xed09ba40, 0xa12fb872), gl_SubgroupInvocationID)) {
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
    }
    {
        int loopIdx0 = 0;
        do {
            loopIdx0++;
            if (subgroupElect()) {
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001f;
                } else {
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
                if (gl_LocalInvocationIndex >= inputA.a[cmpIndex2]) {
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                } else {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10026;
                }
            }
            if (subgroupElect()) {
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                if (subgroupElect()) {
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002e;
                if (gl_SubgroupInvocationID == loopIdx0) {
                } else {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10031;
                }
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10034;
        } while (loopIdx0 < inputA.a[1]);
    }



}
#version 450 core
#extension GL_KHR_shader_subgroup_ballot : enable
#extension GL_KHR_shader_subgroup_vote : enable
#extension GL_NV_shader_subgroup_partitioned : enable
#extension GL_EXT_subgroup_uniform_control_flow : enable
#extension GL_EXT_maximal_reconvergence : require
layout(local_size_x_id = 0, local_size_y_id = 1, local_size_z = 1) in;
layout(set=0, binding=2) coherent buffer OutputC { uint loc[]; } outputC;
layout(set=0, binding=1) coherent buffer OutputB { uvec4 b[]; } outputB;
layout(set=0, binding=0) coherent buffer InputA  { uint  a[]; } inputA;
layout(push_constant) uniform PC {
   // set to the real stride when writing out ballots, or zero when just counting
   int  invocationStride;
   // wildcard fields, for an example the dimensions of rendered area in the case of graphics shaders
   int  width;
   int  height;
   uint primitiveStride;
   uint subgroupStride;
   uint enableInvocationIndex;
};
int outLoc = 0;
bool testBit(uvec4 mask, uint bit) { return ((mask[bit / 32] >> (bit % 32)) & 1) != 0; }
uint elect() { return int(subgroupElect()) + 1; }


void main()
[[maximally_reconverges]]
{

    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
    if (testBit(uvec4(0x5e7c62c7, 0x70aa04d5, 0xd5ac6041, 0xab1a9911), gl_SubgroupInvocationID)) {
        if (subgroupElect()) {
            if (testBit(uvec4(0x5e7c62c7, 0x70aa04d5, 0xd5ac6041, 0xab1a9911), gl_SubgroupInvocationID)) {
                for (int loopIdx0 = 0;
                         loopIdx0 < inputA.a[1];
                         loopIdx0++) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10005;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                {
                    int loopIdx0 = 0;
                    do {
                        loopIdx0++;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000b;
                    } while (loopIdx0 < inputA.a[3]);
                }
            } else {
                {
                    int loopIdx0 = 0;
                    do {
                        loopIdx0++;
                    } while (loopIdx0 < inputA.a[2]);
                }
                switch (gl_SubgroupInvocationID & 3) {
                    case 0:
                    {
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        break;
                    }
                    case 1:
                    {
                        break;
                    }
                    case 2:
                    {
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        break;
                    }
                    case 3:
                    {
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        break;
                    }
                }
            }
        }
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10020;
    }
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);



}
#version 450 core
#extension GL_KHR_shader_subgroup_ballot : enable
#extension GL_KHR_shader_subgroup_vote : enable
#extension GL_NV_shader_subgroup_partitioned : enable
#extension GL_EXT_subgroup_uniform_control_flow : enable
#extension GL_EXT_maximal_reconvergence : require
layout(local_size_x_id = 0, local_size_y_id = 1, local_size_z = 1) in;
layout(set=0, binding=2) coherent buffer OutputC { uint loc[]; } outputC;
layout(set=0, binding=1) coherent buffer OutputB { uvec4 b[]; } outputB;
layout(set=0, binding=0) coherent buffer InputA  { uint  a[]; } inputA;
layout(push_constant) uniform PC {
   // set to the real stride when writing out ballots, or zero when just counting
   int  invocationStride;
   // wildcard fields, for an example the dimensions of rendered area in the case of graphics shaders
   int  width;
   int  height;
   uint primitiveStride;
   uint subgroupStride;
   uint enableInvocationIndex;
};
int outLoc = 0;
bool testBit(uvec4 mask, uint bit) { return ((mask[bit / 32] >> (bit % 32)) & 1) != 0; }
uint elect() { return int(subgroupElect()) + 1; }
layout(constant_id = 10) const uint cmpIndex0 = 0u;
layout(constant_id = 11) const uint cmpIndex1 = 0u;
layout(constant_id = 12) const uint cmpIndex2 = 0u;
layout(constant_id = 13) const uint cmpIndex3 = 0u;
layout(constant_id = 14) const uint cmpIndex4 = 0u;
layout(constant_id = 15) const uint cmpIndex5 = 0u;
layout(constant_id = 16) const uint cmpIndex6 = 0u;


void main()
[[maximally_reconverges]]
{

    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
        switch (gl_SubgroupInvocationID & 3) {
            case 0:
            {
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10004;
                break;
            }
            case 1:
            {
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                if (inputA.a[2] == 2) {
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    if (testBit(uvec4(0xd4333cb6, 0x37e22ba5, 0xbf5155f0, 0x67d1e6d4), gl_SubgroupInvocationID)) {
                    }
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000c;
                    if (inputA.a[0] == 0) {
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000f;
                    } else {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10011;
                    }
                }
                break;
            }
            case 2:
            {
                if (inputA.a[3] == 3) {
                    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10019;
                    } else {
                    }
                    if (subgroupElect()) {
                    }
                } else {
                    if (testBit(uvec4(0xd4333cb6, 0x37e22ba5, 0xbf5155f0, 0x67d1e6d4), gl_SubgroupInvocationID)) {
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    } else {
                    }
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10023;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    if (subgroupElect()) {
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    }
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
                break;
            }
            case 3:
            {
                for (int loopIdx0 = 0;;loopIdx0++,                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true)) {
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002e;
                    break;
                    if (subgroupElect()) {
                        while (!subgroupElect()) {}
                        if (testBit(uvec4(0x579965e, 0xdcab3315, 0xc6e61baa, 0x8b38dac5), gl_SubgroupInvocationID)) {
                            break;
                        } else {
                            break;
                        }
                    }
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    if (subgroupElect()) {
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    }
                    if (gl_SubgroupInvocationID == loopIdx0) {
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    }
                }
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                break;
            }
        }
    } else {
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10044;
        {
            int loopIdx0 = 0;
            do {
                switch (gl_SubgroupInvocationID & 3) {
                    case 0:
                    {
                        if (testBit(uvec4(0xd4333cb6, 0x37e22ba5, 0xbf5155f0, 0x67d1e6d4), gl_SubgroupInvocationID)) {
                        }
                        break;
                    }
                    case 1:
                    {
                        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex2]) {
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        } else {
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1004f;
                        }
                        break;
                    }
                    case 2:
                    {
                        {
                            int loopIdx1 = 0;
                            do {
                                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                                if (subgroupElect()) {
                                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                                    break;
                                }
                                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                                loopIdx1++;
                            } while (true);
                        }
                        break;
                    }
                    case 3:
                    {
                        switch (inputA.a[3]) {
                            case 4:
                            {
                                break;
                            }
                            case 3:
                            {
                                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                                break;
                            }
                            case 5:
                            {
                                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                                break;
                            }
                        }
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10067;
                        break;
                    }
                }
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                if (gl_LocalInvocationIndex >= inputA.a[cmpIndex3]) {
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex4]) {
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    } else {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10070;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    }
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    if (gl_SubgroupInvocationID == loopIdx0) {
                    }
                }
                if (subgroupElect()) {
                    break;
                }
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                if (testBit(uvec4(0xedc86e76, 0xf7f5097c, 0x70d87a0d, 0xa26827a3), gl_SubgroupInvocationID)) {
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    {
                        int loopIdx1 = 0;
                        do {
                            loopIdx1++;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        } while (loopIdx1 < inputA.a[1]);
                    }
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10080;
                    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex5]) {
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    }
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10084;
                }
                loopIdx0++;
            } while (true);
        }
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        for (int loopIdx0 = 0;;loopIdx0++,        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true)) {
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex6]) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1008a;
                {
                    int loopIdx1 = 0;
                    do {
                        loopIdx1++;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    } while (loopIdx1 < inputA.a[2]);
                }
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                {
                    int loopIdx1 = 0;
                    do {
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        if (subgroupElect()) {
                            break;
                        }
                        loopIdx1++;
                    } while (true);
                }
            }
            if (subgroupElect()) {
                for (int loopIdx1 = 0;
                         loopIdx1 < gl_SubgroupInvocationID + 1;
                         loopIdx1++) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10098;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1009b;
                break;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            }
            if (subgroupElect()) {
                break;
            }
            switch (gl_SubgroupInvocationID & 3) {
                case 0:
                {
                    if (gl_SubgroupInvocationID == loopIdx0) {
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    }
                    break;
                }
                case 1:
                {
                    switch (loopIdx0) {
                        case 1: {
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                            break;
                        }
                        case 2: {
                            break;
                        }
                        default: {
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                            break;
                        }
                    }
                    break;
                }
                case 2:
                {
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    if (inputA.a[0] == 0) {
                    }
                    break;
                }
                case 3:
                {
                    if (testBit(uvec4(0x812c43cc, 0x2f392383, 0xd1212f39, 0x629a3975), gl_SubgroupInvocationID)) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x100bb;
                    }
                    break;
                }
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x100bf;
        }
    }



}
#version 450 core
#extension GL_KHR_shader_subgroup_ballot : enable
#extension GL_KHR_shader_subgroup_vote : enable
#extension GL_NV_shader_subgroup_partitioned : enable
#extension GL_EXT_subgroup_uniform_control_flow : enable
#extension GL_EXT_maximal_reconvergence : require
layout(local_size_x_id = 0, local_size_y_id = 1, local_size_z = 1) in;
layout(set=0, binding=2) coherent buffer OutputC { uint loc[]; } outputC;
layout(set=0, binding=1) coherent buffer OutputB { uvec4 b[]; } outputB;
layout(set=0, binding=0) coherent buffer InputA  { uint  a[]; } inputA;
layout(push_constant) uniform PC {
   // set to the real stride when writing out ballots, or zero when just counting
   int  invocationStride;
   // wildcard fields, for an example the dimensions of rendered area in the case of graphics shaders
   int  width;
   int  height;
   uint primitiveStride;
   uint subgroupStride;
   uint enableInvocationIndex;
};
int outLoc = 0;
bool testBit(uvec4 mask, uint bit) { return ((mask[bit / 32] >> (bit % 32)) & 1) != 0; }
uint elect() { return int(subgroupElect()) + 1; }
layout(constant_id = 10) const uint cmpIndex0 = 0u;
layout(constant_id = 11) const uint cmpIndex1 = 0u;
layout(constant_id = 12) const uint cmpIndex2 = 0u;
layout(constant_id = 13) const uint cmpIndex3 = 0u;
layout(constant_id = 14) const uint cmpIndex4 = 0u;
layout(constant_id = 15) const uint cmpIndex5 = 0u;
layout(constant_id = 16) const uint cmpIndex6 = 0u;
layout(constant_id = 17) const uint cmpIndex7 = 0u;
layout(constant_id = 18) const uint cmpIndex8 = 0u;
layout(constant_id = 19) const uint cmpIndex9 = 0u;
layout(constant_id = 20) const uint cmpIndex10 = 0u;
layout(constant_id = 21) const uint cmpIndex11 = 0u;
layout(constant_id = 22) const uint cmpIndex12 = 0u;
layout(constant_id = 23) const uint cmpIndex13 = 0u;
layout(constant_id = 24) const uint cmpIndex14 = 0u;
layout(constant_id = 25) const uint cmpIndex15 = 0u;
layout(constant_id = 26) const uint cmpIndex16 = 0u;


void main()
[[maximally_reconverges]]
{

    {
        int loopIdx0 = 0;
        do {
            loopIdx0++;
            return;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        } while (loopIdx0 < inputA.a[5]);
    }
    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        if (testBit(uvec4(0x91b3bcd8, 0x6a4b0e01, 0x2033a7ef, 0xef82cc51), gl_SubgroupInvocationID)) {
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
                {
                    int loopIdx0 = 0;
                    do {
                        loopIdx0++;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    } while (loopIdx0 < inputA.a[5]);
                }
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                if (gl_LocalInvocationIndex >= inputA.a[cmpIndex2]) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000e;
                }
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10011;
            } else {
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                if (gl_LocalInvocationIndex >= inputA.a[cmpIndex3]) {
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                if (inputA.a[2] == 2) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10019;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
            }
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex4]) {
                for (int loopIdx0 = 0;
                         loopIdx0 < inputA.a[1];
                         loopIdx0++) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001f;
                }
                while (!subgroupElect()) {}
                {
                    int loopIdx0 = 0;
                    do {
                        if (subgroupElect()) {
                            break;
                        }
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10026;
                        loopIdx0++;
                    } while (true);
                }
            } else {
                if (gl_LocalInvocationIndex >= inputA.a[cmpIndex5]) {
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                } else {
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
                switch (gl_SubgroupInvocationID & 3) {
                    case 0:
                    {
                        break;
                    }
                    case 1:
                    {
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        break;
                    }
                    case 2:
                    {
                        break;
                    }
                    case 3:
                    {
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        break;
                    }
                }
            }
        } else {
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex6]) {
                {
                    int loopIdx0 = 0;
                    do {
                        loopIdx0++;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    } while (loopIdx0 < inputA.a[5]);
                }
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                if (gl_LocalInvocationIndex >= inputA.a[cmpIndex7]) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000e;
                }
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10011;
            } else {
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                if (gl_LocalInvocationIndex >= inputA.a[cmpIndex8]) {
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                if (inputA.a[0] == 0) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10019;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
            }
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex9]) {
                for (int loopIdx0 = 0;
                         loopIdx0 < inputA.a[1];
                         loopIdx0++) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001f;
                }
                while (!subgroupElect()) {}
                {
                    int loopIdx0 = 0;
                    do {
                        if (subgroupElect()) {
                            break;
                        }
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10026;
                        loopIdx0++;
                    } while (true);
                }
            } else {
                if (gl_LocalInvocationIndex >= inputA.a[cmpIndex10]) {
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                } else {
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
                switch (gl_SubgroupInvocationID & 3) {
                    case 0:
                    {
                        break;
                    }
                    case 1:
                    {
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        break;
                    }
                    case 2:
                    {
                        break;
                    }
                    case 3:
                    {
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        break;
                    }
                }
            }
        }
        {
            int loopIdx0 = 0;
            do {
                if (gl_LocalInvocationIndex >= inputA.a[cmpIndex11]) {
                    for (int loopIdx1 = 0;
                             loopIdx1 < gl_SubgroupInvocationID + 1;
                             loopIdx1++) {
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    }
                } else {
                    for (int loopIdx1 = 0;
                             loopIdx1 < gl_SubgroupInvocationID + 1;
                             loopIdx1++) {
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    }
                }
                if (gl_SubgroupInvocationID == loopIdx0) {
                    if (testBit(uvec4(0xede2dc2c, 0xdcb30010, 0x2ebc3846, 0x63a3bd92), gl_SubgroupInvocationID)) {
                        break;
                    } else {
                        break;
                    }
                    if (inputA.a[0] == 0) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10082;
                    }
                }
                if (subgroupElect()) {
                    break;
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10088;
                if (testBit(uvec4(0x1e63b50d, 0x123a9eee, 0x5acbdd0b, 0xe77a12d4), gl_SubgroupInvocationID)) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1008a;
                    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex12]) {
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    } else {
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    }
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10090;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    if (gl_SubgroupInvocationID == loopIdx0) {
                    } else {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10094;
                    }
                } else {
                    if (gl_SubgroupInvocationID == loopIdx0) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10098;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    } else {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1009b;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    }
                    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex13]) {
                    }
                }
                {
                    int loopIdx1 = 0;
                    do {
                        break;
                        for (int loopIdx2 = 0;
                                 loopIdx2 < inputA.a[4];
                                 loopIdx2++) {
                        }
                        if (subgroupElect()) {
                            break;
                        }
                        if (gl_SubgroupInvocationID == loopIdx1) {
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        }
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x100ab;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        if (testBit(uvec4(0x1e63b50d, 0x123a9eee, 0x5acbdd0b, 0xe77a12d4), gl_SubgroupInvocationID)) {
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        }
                        loopIdx1++;
                    } while (true);
                }
                loopIdx0++;
            } while (true);
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x100b2;
    } else {
        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex14]) {
            for (int loopIdx0 = 0;
                     loopIdx0 < gl_SubgroupInvocationID + 1;
                     loopIdx0++) {
                switch (gl_SubgroupInvocationID & 3) {
                    case 0:
                    {
                        break;
                    }
                    case 1:
                    {
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x100bb;
                        break;
                    }
                    case 2:
                    {
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        break;
                    }
                    case 3:
                    {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x100c1;
                        break;
                    }
                }
                switch (loopIdx0) {
                    case 1: {
                        break;
                    }
                    case 2: {
                        break;
                    }
                    default: {
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x100cb;
                        break;
                    }
                }
            }
            if (inputA.a[2] == 2) {
                if (gl_LocalInvocationIndex >= inputA.a[cmpIndex15]) {
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                } else {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x100d3;
                }
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            }
        } else {
            if (testBit(uvec4(0x1e63b50d, 0x123a9eee, 0x5acbdd0b, 0xe77a12d4), gl_SubgroupInvocationID)) {
                if (gl_LocalInvocationIndex >= inputA.a[cmpIndex16]) {
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x100db;
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x100dd;
                {
                    int loopIdx0 = 0;
                    do {
                        if (subgroupElect()) {
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                            if (testBit(uvec4(0xede2dc2c, 0xdcb30010, 0x2ebc3846, 0x63a3bd92), gl_SubgroupInvocationID)) {
                                break;
                            } else {
                                break;
                            }
                        }
                        loopIdx0++;
                    } while (true);
                }
            }
        }
    }



}
#version 450 core
#extension GL_KHR_shader_subgroup_ballot : enable
#extension GL_KHR_shader_subgroup_vote : enable
#extension GL_NV_shader_subgroup_partitioned : enable
#extension GL_EXT_subgroup_uniform_control_flow : enable
#extension GL_EXT_maximal_reconvergence : require
layout(local_size_x_id = 0, local_size_y_id = 1, local_size_z = 1) in;
layout(set=0, binding=2) coherent buffer OutputC { uint loc[]; } outputC;
layout(set=0, binding=1) coherent buffer OutputB { uvec4 b[]; } outputB;
layout(set=0, binding=0) coherent buffer InputA  { uint  a[]; } inputA;
layout(push_constant) uniform PC {
   // set to the real stride when writing out ballots, or zero when just counting
   int  invocationStride;
   // wildcard fields, for an example the dimensions of rendered area in the case of graphics shaders
   int  width;
   int  height;
   uint primitiveStride;
   uint subgroupStride;
   uint enableInvocationIndex;
};
int outLoc = 0;
bool testBit(uvec4 mask, uint bit) { return ((mask[bit / 32] >> (bit % 32)) & 1) != 0; }
uint elect() { return int(subgroupElect()) + 1; }


void main()
[[maximally_reconverges]]
{

    for (int loopIdx0 = 0;;loopIdx0++,    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true)) {
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10001;
        break;
        if (gl_SubgroupInvocationID == loopIdx0) {
            if (inputA.a[3] == 3) {
                if (testBit(uvec4(0xe3e6077b, 0x934d4176, 0x44df3f14, 0x16bfbe39), gl_SubgroupInvocationID)) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10006;
                }
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                for (int loopIdx1 = 0;
                         loopIdx1 < inputA.a[2];
                         loopIdx1++) {
                }
            } else {
                if (gl_SubgroupInvocationID == loopIdx0) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000d;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                } else {
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10012;
            }
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            if (inputA.a[3] == 3) {
                break;
                {
                    int loopIdx1 = 0;
                    do {
                        loopIdx1++;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    } while (loopIdx1 < inputA.a[3]);
                }
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            }
        } else {
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            if (gl_SubgroupInvocationID == loopIdx0) {
                if (testBit(uvec4(0xbdeae9f, 0x37d0c6ef, 0x9f4cb738, 0x54c6189a), gl_SubgroupInvocationID)) {
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10021;
                }
                if (inputA.a[2] == 2) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10024;
                } else {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10026;
                }
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            } else {
                if (inputA.a[0] == 12345) {
                    while (true) {
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    }
                }
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                if (testBit(uvec4(0xe3e6077b, 0x934d4176, 0x44df3f14, 0x16bfbe39), gl_SubgroupInvocationID)) {
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            }
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        }
        if (subgroupElect()) {
            break;
        }
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        break;
    }



}
#version 450 core
#extension GL_KHR_shader_subgroup_ballot : enable
#extension GL_KHR_shader_subgroup_vote : enable
#extension GL_NV_shader_subgroup_partitioned : enable
#extension GL_EXT_subgroup_uniform_control_flow : enable
#extension GL_EXT_maximal_reconvergence : require
layout(local_size_x_id = 0, local_size_y_id = 1, local_size_z = 1) in;
layout(set=0, binding=2) coherent buffer OutputC { uint loc[]; } outputC;
layout(set=0, binding=1) coherent buffer OutputB { uvec4 b[]; } outputB;
layout(set=0, binding=0) coherent buffer InputA  { uint  a[]; } inputA;
layout(push_constant) uniform PC {
   // set to the real stride when writing out ballots, or zero when just counting
   int  invocationStride;
   // wildcard fields, for an example the dimensions of rendered area in the case of graphics shaders
   int  width;
   int  height;
   uint primitiveStride;
   uint subgroupStride;
   uint enableInvocationIndex;
};
int outLoc = 0;
bool testBit(uvec4 mask, uint bit) { return ((mask[bit / 32] >> (bit % 32)) & 1) != 0; }
uint elect() { return int(subgroupElect()) + 1; }
layout(constant_id = 10) const uint cmpIndex0 = 0u;
layout(constant_id = 11) const uint cmpIndex1 = 0u;
layout(constant_id = 12) const uint cmpIndex2 = 0u;
layout(constant_id = 13) const uint cmpIndex3 = 0u;
layout(constant_id = 14) const uint cmpIndex4 = 0u;


void main()
[[maximally_reconverges]]
{

    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        {
            int loopIdx0 = 0;
            do {
                {
                    int loopIdx1 = 0;
                    do {
                        loopIdx1++;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        break;
                        if (inputA.a[0] == 0) {
                        } else {
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        }
                    } while (loopIdx1 < inputA.a[4]);
                }
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                if (gl_SubgroupInvocationID == loopIdx0) {
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    } else {
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    }
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10014;
                if (subgroupElect()) {
                    break;
                }
                if (inputA.a[0] == 0) {
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    for (int loopIdx1 = 0;
                             loopIdx1 < inputA.a[1];
                             loopIdx1++) {
                    }
                } else {
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    switch (loopIdx0) {
                        case 1: {
                            break;
                        }
                        case 2: {
                            break;
                        }
                        default: {
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                            break;
                        }
                    }
                }
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                if (testBit(uvec4(0xb0caba39, 0xdcbca1e5, 0x73e934e7, 0x3e8bc839), gl_SubgroupInvocationID)) {
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    if (subgroupElect()) {
                    }
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002d;
                } else {
                    {
                        int loopIdx1 = 0;
                        do {
                            if (subgroupElect()) {
                                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                                break;
                            }
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10034;
                            loopIdx1++;
                        } while (true);
                    }
                }
                loopIdx0++;
            } while (true);
        }
        if (inputA.a[3] == 3) {
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            for (int loopIdx0 = 0;;loopIdx0++,            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true)) {
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                if (subgroupElect()) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1003d;
                    break;
                }
                for (int loopIdx1 = 0;
                         loopIdx1 < gl_SubgroupInvocationID + 1;
                         loopIdx1++) {
                }
                break;
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10044;
        } else {
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        }
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
    } else {
        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex2]) {
            if (inputA.a[2] == 2) {
                if (subgroupElect()) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1004d;
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1004f;
                {
                    int loopIdx0 = 0;
                    do {
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        if (subgroupElect()) {
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                            break;
                        }
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        loopIdx0++;
                    } while (true);
                }
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10059;
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex3]) {
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                if (gl_LocalInvocationIndex >= inputA.a[cmpIndex4]) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1005d;
                } else {
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
            }
        }
    }



}
#version 450 core
#extension GL_KHR_shader_subgroup_ballot : enable
#extension GL_KHR_shader_subgroup_vote : enable
#extension GL_NV_shader_subgroup_partitioned : enable
#extension GL_EXT_subgroup_uniform_control_flow : enable
#extension GL_EXT_maximal_reconvergence : require
layout(local_size_x_id = 0, local_size_y_id = 1, local_size_z = 1) in;
layout(set=0, binding=2) coherent buffer OutputC { uint loc[]; } outputC;
layout(set=0, binding=1) coherent buffer OutputB { uvec4 b[]; } outputB;
layout(set=0, binding=0) coherent buffer InputA  { uint  a[]; } inputA;
layout(push_constant) uniform PC {
   // set to the real stride when writing out ballots, or zero when just counting
   int  invocationStride;
   // wildcard fields, for an example the dimensions of rendered area in the case of graphics shaders
   int  width;
   int  height;
   uint primitiveStride;
   uint subgroupStride;
   uint enableInvocationIndex;
};
int outLoc = 0;
bool testBit(uvec4 mask, uint bit) { return ((mask[bit / 32] >> (bit % 32)) & 1) != 0; }
uint elect() { return int(subgroupElect()) + 1; }
layout(constant_id = 10) const uint cmpIndex0 = 0u;
layout(constant_id = 11) const uint cmpIndex1 = 0u;
layout(constant_id = 12) const uint cmpIndex2 = 0u;
layout(constant_id = 13) const uint cmpIndex3 = 0u;


void main()
[[maximally_reconverges]]
{

    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
    if (inputA.a[0] == 0) {
        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
            if (testBit(uvec4(0xf77511fe, 0x9ecaa8ed, 0x511db92f, 0x8ad08538), gl_SubgroupInvocationID)) {
                if (subgroupElect()) {
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
                switch (gl_SubgroupInvocationID & 3) {
                    case 0:
                    {
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        break;
                    }
                    case 1:
                    {
                        break;
                    }
                    case 2:
                    {
                        break;
                    }
                    case 3:
                    {
                        break;
                    }
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10012;
            } else {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10014;
                for (int loopIdx0 = 0;
                         loopIdx0 < gl_SubgroupInvocationID + 1;
                         loopIdx0++) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10016;
                    if (inputA.a[0] == 12345) {
                        while (true) {
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        }
                    }
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10019;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                if (subgroupElect()) {
                }
            }
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        } else {
            if (testBit(uvec4(0xf77511fe, 0x9ecaa8ed, 0x511db92f, 0x8ad08538), gl_SubgroupInvocationID)) {
                if (subgroupElect()) {
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
                switch (gl_SubgroupInvocationID & 3) {
                    case 0:
                    {
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        break;
                    }
                    case 1:
                    {
                        break;
                    }
                    case 2:
                    {
                        break;
                    }
                    case 3:
                    {
                        break;
                    }
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10012;
            } else {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10014;
                for (int loopIdx0 = 0;
                         loopIdx0 < gl_SubgroupInvocationID + 1;
                         loopIdx0++) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10016;
                    if (inputA.a[0] == 12345) {
                        while (true) {
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        }
                    }
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10019;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                if (subgroupElect()) {
                }
            }
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        }
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
    } else {
        if (subgroupElect()) {
            switch (inputA.a[3]) {
                case 4:
                {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10042;
                    if (subgroupElect()) {
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10045;
                    }
                    break;
                }
                case 3:
                {
                    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1004b;
                    } else {
                    }
                    return;
                    break;
                }
                case 5:
                {
                    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex2]) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10052;
                    } else {
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    }
                    break;
                }
            }
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10059;
            for (int loopIdx0 = 0;
                     loopIdx0 < inputA.a[2];
                     loopIdx0++) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1005b;
                for (int loopIdx1 = 0;
                         loopIdx1 < gl_SubgroupInvocationID + 1;
                         loopIdx1++) {
                }
                if (inputA.a[3] == 3) {
                }
            }
        }
        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex3]) {
            if (testBit(uvec4(0x9e19d960, 0xdc84f6e8, 0x5cf95d28, 0x1058dec4), gl_SubgroupInvocationID)) {
                if (inputA.a[2] == 2) {
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                switch (gl_SubgroupInvocationID & 3) {
                    case 0:
                    {
                        break;
                    }
                    case 1:
                    {
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        break;
                    }
                    case 2:
                    {
                        break;
                    }
                    case 3:
                    {
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        break;
                    }
                }
            }
            switch (gl_SubgroupInvocationID & 3) {
                case 0:
                {
                    if (testBit(uvec4(0xf7b3ccb6, 0xa731d3e9, 0xb74d8b76, 0x21cb827a), gl_SubgroupInvocationID)) {
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    }
                    break;
                }
                case 1:
                {
                    break;
                }
                case 2:
                {
                    for (int loopIdx0 = 0;
                             loopIdx0 < inputA.a[4];
                             loopIdx0++) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1007f;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    }
                    break;
                }
                case 3:
                {
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    if (inputA.a[0] == 0) {
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10087;
                    }
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    break;
                }
            }
        }
    }
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);



}
#version 450 core
#extension GL_KHR_shader_subgroup_ballot : enable
#extension GL_KHR_shader_subgroup_vote : enable
#extension GL_NV_shader_subgroup_partitioned : enable
#extension GL_EXT_subgroup_uniform_control_flow : enable
#extension GL_EXT_maximal_reconvergence : require
layout(local_size_x_id = 0, local_size_y_id = 1, local_size_z = 1) in;
layout(set=0, binding=2) coherent buffer OutputC { uint loc[]; } outputC;
layout(set=0, binding=1) coherent buffer OutputB { uvec4 b[]; } outputB;
layout(set=0, binding=0) coherent buffer InputA  { uint  a[]; } inputA;
layout(push_constant) uniform PC {
   // set to the real stride when writing out ballots, or zero when just counting
   int  invocationStride;
   // wildcard fields, for an example the dimensions of rendered area in the case of graphics shaders
   int  width;
   int  height;
   uint primitiveStride;
   uint subgroupStride;
   uint enableInvocationIndex;
};
int outLoc = 0;
bool testBit(uvec4 mask, uint bit) { return ((mask[bit / 32] >> (bit % 32)) & 1) != 0; }
uint elect() { return int(subgroupElect()) + 1; }
layout(constant_id = 10) const uint cmpIndex0 = 0u;
layout(constant_id = 11) const uint cmpIndex1 = 0u;
layout(constant_id = 12) const uint cmpIndex2 = 0u;
layout(constant_id = 13) const uint cmpIndex3 = 0u;
layout(constant_id = 14) const uint cmpIndex4 = 0u;


void main()
[[maximally_reconverges]]
{

    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10000;
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
    switch (inputA.a[2]) {
        case 3:
        {
            if (subgroupElect()) {
                {
                    int loopIdx0 = 0;
                    do {
                        loopIdx0++;
                        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10007;
                        }
                        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000a;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        } else {
                        }
                    } while (loopIdx0 < inputA.a[3]);
                }
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10010;
                {
                    int loopIdx0 = 0;
                    do {
                        if (gl_SubgroupInvocationID == loopIdx0) {
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        } else {
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        }
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        if (subgroupElect()) {
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10019;
                        }
                        if (subgroupElect()) {
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001c;
                            break;
                        }
                        if (subgroupElect()) {
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        }
                        if (testBit(uvec4(0x47437516, 0xdc8cc7ef, 0x85e228f4, 0xc902798b), gl_SubgroupInvocationID)) {
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10024;
                        } else {
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10027;
                        }
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        loopIdx0++;
                    } while (true);
                }
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            }
            break;
        }
        case 2:
        {
            switch (gl_SubgroupInvocationID & 3) {
                case 0:
                {
                    if (subgroupElect()) {
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        switch (inputA.a[3]) {
                            case 4:
                            {
                                break;
                            }
                            case 3:
                            {
                                break;
                            }
                            case 5:
                            {
                                outputC.loc[gl_LocalInvocationIndex]++;
                                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10039;
                                break;
                            }
                        }
                    }
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1003e;
                    break;
                }
                case 1:
                {
                    break;
                }
                case 2:
                {
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    if (testBit(uvec4(0xc8626f10, 0x4b547ee1, 0xd59c011f, 0x36238fad), gl_SubgroupInvocationID)) {
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        switch (gl_SubgroupInvocationID & 3) {
                            case 0:
                            {
                                break;
                            }
                            case 1:
                            {
                                break;
                            }
                            case 2:
                            {
                                break;
                            }
                            case 3:
                            {
                                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                                outputC.loc[gl_LocalInvocationIndex]++;
                                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1004f;
                                break;
                            }
                        }
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    } else {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10054;
                        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex2]) {
                        }
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    }
                    break;
                }
                case 3:
                {
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    break;
                }
            }
            {
                int loopIdx0 = 0;
                do {
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    if (subgroupElect()) {
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10062;
                        break;
                    }
                    if (subgroupElect()) {
                        switch (gl_SubgroupInvocationID & 3) {
                            case 0:
                            {
                                break;
                            }
                            case 1:
                            {
                                break;
                            }
                            case 2:
                            {
                                break;
                            }
                            case 3:
                            {
                                break;
                            }
                        }
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        break;
                    }
                    if (testBit(uvec4(0x2d447467, 0x7ae64289, 0x13784927, 0xf531f510), gl_SubgroupInvocationID)) {
                        if (inputA.a[0] == 0) {
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10076;
                        } else {
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        }
                        switch (inputA.a[1]) {
                            case 2:
                            {
                                break;
                            }
                            case 1:
                            {
                                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                                break;
                            }
                            case 3:
                            {
                                outputC.loc[gl_LocalInvocationIndex]++;
                                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10081;
                                break;
                            }
                        }
                    } else {
                        break;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        if (testBit(uvec4(0xc8626f10, 0x4b547ee1, 0xd59c011f, 0x36238fad), gl_SubgroupInvocationID)) {
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        } else {
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1008b;
                        }
                    }
                    loopIdx0++;
                } while (true);
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1008f;
            break;
        }
        case 4:
        {
            if (inputA.a[0] == 0) {
                if (gl_LocalInvocationIndex >= inputA.a[cmpIndex3]) {
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    {
                        int loopIdx0 = 0;
                        do {
                            loopIdx0++;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        } while (loopIdx0 < inputA.a[4]);
                    }
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex4]) {
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1009b;
                    } else {
                    }
                }
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x100a0;
            }
            break;
        }
    }



}
#version 450 core
#extension GL_KHR_shader_subgroup_ballot : enable
#extension GL_KHR_shader_subgroup_vote : enable
#extension GL_NV_shader_subgroup_partitioned : enable
#extension GL_EXT_subgroup_uniform_control_flow : enable
#extension GL_EXT_maximal_reconvergence : require
layout(local_size_x_id = 0, local_size_y_id = 1, local_size_z = 1) in;
layout(set=0, binding=2) coherent buffer OutputC { uint loc[]; } outputC;
layout(set=0, binding=1) coherent buffer OutputB { uvec4 b[]; } outputB;
layout(set=0, binding=0) coherent buffer InputA  { uint  a[]; } inputA;
layout(push_constant) uniform PC {
   // set to the real stride when writing out ballots, or zero when just counting
   int  invocationStride;
   // wildcard fields, for an example the dimensions of rendered area in the case of graphics shaders
   int  width;
   int  height;
   uint primitiveStride;
   uint subgroupStride;
   uint enableInvocationIndex;
};
int outLoc = 0;
bool testBit(uvec4 mask, uint bit) { return ((mask[bit / 32] >> (bit % 32)) & 1) != 0; }
uint elect() { return int(subgroupElect()) + 1; }
layout(constant_id = 10) const uint cmpIndex0 = 0u;
layout(constant_id = 11) const uint cmpIndex1 = 0u;
layout(constant_id = 12) const uint cmpIndex2 = 0u;


void main()
[[maximally_reconverges]]
{

    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
        if (testBit(uvec4(0x467d6e76, 0x4b45c110, 0xdc26e53e, 0xc4601a6e), gl_SubgroupInvocationID)) {
            for (int loopIdx0 = 0;;loopIdx0++,            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true)) {
                for (int loopIdx1 = 0;
                         loopIdx1 < inputA.a[5];
                         loopIdx1++) {
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
                switch (loopIdx0) {
                    case 1: {
                        break;
                    }
                    case 2: {
                        break;
                    }
                    default: {
                        break;
                    }
                }
                if (subgroupElect()) {
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10010;
                    break;
                }
                if (subgroupElect()) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10014;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
                if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                } else {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001a;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            }
        }
    } else {
        if (testBit(uvec4(0x467d6e76, 0x4b45c110, 0xdc26e53e, 0xc4601a6e), gl_SubgroupInvocationID)) {
            for (int loopIdx0 = 0;;loopIdx0++,            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true)) {
                for (int loopIdx1 = 0;
                         loopIdx1 < inputA.a[5];
                         loopIdx1++) {
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
                switch (loopIdx0) {
                    case 1: {
                        break;
                    }
                    case 2: {
                        break;
                    }
                    default: {
                        break;
                    }
                }
                if (subgroupElect()) {
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10010;
                    break;
                }
                if (subgroupElect()) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10014;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
                if (gl_LocalInvocationIndex >= inputA.a[cmpIndex2]) {
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                } else {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001a;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            }
        }
    }



}
#version 450 core
#extension GL_KHR_shader_subgroup_ballot : enable
#extension GL_KHR_shader_subgroup_vote : enable
#extension GL_NV_shader_subgroup_partitioned : enable
#extension GL_EXT_subgroup_uniform_control_flow : enable
layout(local_size_x_id = 0, local_size_y_id = 1, local_size_z = 1) in;
layout(set=0, binding=2) coherent buffer OutputC { uint loc[]; } outputC;
layout(set=0, binding=1) coherent buffer OutputB { uvec4 b[]; } outputB;
layout(set=0, binding=0) coherent buffer InputA  { uint  a[]; } inputA;
layout(push_constant) uniform PC {
   // set to the real stride when writing out ballots, or zero when just counting
   int  invocationStride;
   // wildcard fields, for an example the dimensions of rendered area in the case of graphics shaders
   int  width;
   int  height;
   uint primitiveStride;
   uint subgroupStride;
   uint enableInvocationIndex;
};
int outLoc = 0;
bool testBit(uvec4 mask, uint bit) { return ((mask[bit / 32] >> (bit % 32)) & 1) != 0; }
uint elect() { return int(subgroupElect()) + 1; }
layout(constant_id = 10) const uint cmpIndex0 = 0u;
layout(constant_id = 11) const uint cmpIndex1 = 0u;
layout(constant_id = 12) const uint cmpIndex2 = 0u;


void main()
[[subgroup_uniform_control_flow]]
{

    if (inputA.a[2] == 2) {
        for (int loopIdx0 = 0;
                 loopIdx0 < gl_SubgroupInvocationID + 1;
                 loopIdx0++) {
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10003;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        {
            int loopIdx0 = 0;
            do {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10006;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                if (subgroupElect()) {
                    break;
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000b;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                loopIdx0++;
            } while (true);
        }
    } else {
        for (int loopIdx0 = 0;
                 loopIdx0 < inputA.a[3];
                 loopIdx0++) {
        }
        if (testBit(uvec4(0xcfbc2897, 0xfc76d7d0, 0x3a289c17, 0xb008b37a), gl_SubgroupInvocationID)) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10012;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        } else {
        }
    }
    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10017;
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001b;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        }
        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex2]) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001f;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        }
    }



}
#version 450 core
#extension GL_KHR_shader_subgroup_ballot : enable
#extension GL_KHR_shader_subgroup_vote : enable
#extension GL_NV_shader_subgroup_partitioned : enable
#extension GL_EXT_subgroup_uniform_control_flow : enable
layout(local_size_x_id = 0, local_size_y_id = 1, local_size_z = 1) in;
layout(set=0, binding=2) coherent buffer OutputC { uint loc[]; } outputC;
layout(set=0, binding=1) coherent buffer OutputB { uvec4 b[]; } outputB;
layout(set=0, binding=0) coherent buffer InputA  { uint  a[]; } inputA;
layout(push_constant) uniform PC {
   // set to the real stride when writing out ballots, or zero when just counting
   int  invocationStride;
   // wildcard fields, for an example the dimensions of rendered area in the case of graphics shaders
   int  width;
   int  height;
   uint primitiveStride;
   uint subgroupStride;
   uint enableInvocationIndex;
};
int outLoc = 0;
bool testBit(uvec4 mask, uint bit) { return ((mask[bit / 32] >> (bit % 32)) & 1) != 0; }
uint elect() { return int(subgroupElect()) + 1; }
layout(constant_id = 10) const uint cmpIndex0 = 0u;
layout(constant_id = 11) const uint cmpIndex1 = 0u;


void main()
[[subgroup_uniform_control_flow]]
{

    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10000;
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
    if (testBit(uvec4(0x5e7c62c7, 0x70aa04d5, 0xd5ac6041, 0xab1a9911), gl_SubgroupInvocationID)) {
        if (subgroupElect()) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10004;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        }
    }
    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10008;
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
    if (testBit(uvec4(0x5e7c62c7, 0x70aa04d5, 0xd5ac6041, 0xab1a9911), gl_SubgroupInvocationID)) {
        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000c;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000f;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
    } else {
        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
        } else {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10014;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        }
    }
    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10018;
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
    if (testBit(uvec4(0xca5a5b81, 0x51702d72, 0x4762f0d4, 0xd50571b4), gl_SubgroupInvocationID)) {
        switch (gl_SubgroupInvocationID & 3) {
            case 0:
            {
                break;
            }
            case 1:
            {
                break;
            }
            case 2:
            {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10021;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                break;
            }
            case 3:
            {
                break;
            }
        }
        if (testBit(uvec4(0x5e7c62c7, 0x70aa04d5, 0xd5ac6041, 0xab1a9911), gl_SubgroupInvocationID)) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10028;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        } else {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002b;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        }
    }



}
#version 450 core
#extension GL_KHR_shader_subgroup_ballot : enable
#extension GL_KHR_shader_subgroup_vote : enable
#extension GL_NV_shader_subgroup_partitioned : enable
#extension GL_EXT_subgroup_uniform_control_flow : enable
layout(local_size_x_id = 0, local_size_y_id = 1, local_size_z = 1) in;
layout(set=0, binding=2) coherent buffer OutputC { uint loc[]; } outputC;
layout(set=0, binding=1) coherent buffer OutputB { uvec4 b[]; } outputB;
layout(set=0, binding=0) coherent buffer InputA  { uint  a[]; } inputA;
layout(push_constant) uniform PC {
   // set to the real stride when writing out ballots, or zero when just counting
   int  invocationStride;
   // wildcard fields, for an example the dimensions of rendered area in the case of graphics shaders
   int  width;
   int  height;
   uint primitiveStride;
   uint subgroupStride;
   uint enableInvocationIndex;
};
int outLoc = 0;
bool testBit(uvec4 mask, uint bit) { return ((mask[bit / 32] >> (bit % 32)) & 1) != 0; }
uint elect() { return int(subgroupElect()) + 1; }
layout(constant_id = 10) const uint cmpIndex0 = 0u;


void main()
[[subgroup_uniform_control_flow]]
{

    if (testBit(uvec4(0x579965e, 0xdcab3315, 0xc6e61baa, 0x8b38dac5), gl_SubgroupInvocationID)) {
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10001;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
    } else {
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10004;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        if (inputA.a[1] == 1) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10007;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        } else {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10007;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        }
        if (inputA.a[1] == 1) {
        }
    }
    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10010;
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
    if (subgroupElect()) {
        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10014;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        } else {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10017;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        }
        for (int loopIdx0 = 0;;loopIdx0++,        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect()) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001b;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            if (subgroupElect()) {
                break;
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10020;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10023;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
    }



}
#version 450 core
#extension GL_KHR_shader_subgroup_ballot : enable
#extension GL_KHR_shader_subgroup_vote : enable
#extension GL_NV_shader_subgroup_partitioned : enable
#extension GL_EXT_subgroup_uniform_control_flow : enable
layout(local_size_x_id = 0, local_size_y_id = 1, local_size_z = 1) in;
layout(set=0, binding=2) coherent buffer OutputC { uint loc[]; } outputC;
layout(set=0, binding=1) coherent buffer OutputB { uvec4 b[]; } outputB;
layout(set=0, binding=0) coherent buffer InputA  { uint  a[]; } inputA;
layout(push_constant) uniform PC {
   // set to the real stride when writing out ballots, or zero when just counting
   int  invocationStride;
   // wildcard fields, for an example the dimensions of rendered area in the case of graphics shaders
   int  width;
   int  height;
   uint primitiveStride;
   uint subgroupStride;
   uint enableInvocationIndex;
};
int outLoc = 0;
bool testBit(uvec4 mask, uint bit) { return ((mask[bit / 32] >> (bit % 32)) & 1) != 0; }
uint elect() { return int(subgroupElect()) + 1; }
layout(constant_id = 10) const uint cmpIndex0 = 0u;
layout(constant_id = 11) const uint cmpIndex1 = 0u;


void main()
[[subgroup_uniform_control_flow]]
{

    {
        int loopIdx0 = 0;
        do {
            loopIdx0++;
            return;
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10002;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        } while (loopIdx0 < inputA.a[5]);
    }
    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10006;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        if (testBit(uvec4(0x91b3bcd8, 0x6a4b0e01, 0x2033a7ef, 0xef82cc51), gl_SubgroupInvocationID)) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10009;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000c;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
    }
    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000f;
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
        {
            int loopIdx0 = 0;
            do {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10013;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                if (subgroupElect()) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10016;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    break;
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001a;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                loopIdx0++;
            } while (true);
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001d;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
    } else {
        {
            int loopIdx0 = 0;
            do {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10013;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                if (subgroupElect()) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10016;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    break;
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001a;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                loopIdx0++;
            } while (true);
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001d;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
    }
    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002e;
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();



}
#version 450 core
#extension GL_KHR_shader_subgroup_ballot : enable
#extension GL_KHR_shader_subgroup_vote : enable
#extension GL_NV_shader_subgroup_partitioned : enable
#extension GL_EXT_subgroup_uniform_control_flow : enable
layout(local_size_x_id = 0, local_size_y_id = 1, local_size_z = 1) in;
layout(set=0, binding=2) coherent buffer OutputC { uint loc[]; } outputC;
layout(set=0, binding=1) coherent buffer OutputB { uvec4 b[]; } outputB;
layout(set=0, binding=0) coherent buffer InputA  { uint  a[]; } inputA;
layout(push_constant) uniform PC {
   // set to the real stride when writing out ballots, or zero when just counting
   int  invocationStride;
   // wildcard fields, for an example the dimensions of rendered area in the case of graphics shaders
   int  width;
   int  height;
   uint primitiveStride;
   uint subgroupStride;
   uint enableInvocationIndex;
};
int outLoc = 0;
bool testBit(uvec4 mask, uint bit) { return ((mask[bit / 32] >> (bit % 32)) & 1) != 0; }
uint elect() { return int(subgroupElect()) + 1; }


void main()
[[subgroup_uniform_control_flow]]
{

    for (int loopIdx0 = 0;;loopIdx0++,    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect()) {
        break;
        if (gl_SubgroupInvocationID == loopIdx0) {
        }
        if (subgroupElect()) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10005;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            break;
        }
        if (testBit(uvec4(0x5664d7eb, 0xdcbb511b, 0x9578e94b, 0xd825b137), gl_SubgroupInvocationID)) {
            break;
        } else {
            break;
        }
        if (subgroupElect()) {
        }
    }
    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10011;
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
    for (int loopIdx0 = 0;
             loopIdx0 < gl_SubgroupInvocationID + 1;
             loopIdx0++) {
        if (inputA.a[3] == 3) {
        }
        switch (loopIdx0) {
            case 1: {
                break;
            }
            case 2: {
                break;
            }
            default: {
                break;
            }
        }
    }



}
#version 450 core
#extension GL_KHR_shader_subgroup_ballot : enable
#extension GL_KHR_shader_subgroup_vote : enable
#extension GL_NV_shader_subgroup_partitioned : enable
#extension GL_EXT_subgroup_uniform_control_flow : enable
layout(local_size_x_id = 0, local_size_y_id = 1, local_size_z = 1) in;
layout(set=0, binding=2) coherent buffer OutputC { uint loc[]; } outputC;
layout(set=0, binding=1) coherent buffer OutputB { uvec4 b[]; } outputB;
layout(set=0, binding=0) coherent buffer InputA  { uint  a[]; } inputA;
layout(push_constant) uniform PC {
   // set to the real stride when writing out ballots, or zero when just counting
   int  invocationStride;
   // wildcard fields, for an example the dimensions of rendered area in the case of graphics shaders
   int  width;
   int  height;
   uint primitiveStride;
   uint subgroupStride;
   uint enableInvocationIndex;
};
int outLoc = 0;
bool testBit(uvec4 mask, uint bit) { return ((mask[bit / 32] >> (bit % 32)) & 1) != 0; }
uint elect() { return int(subgroupElect()) + 1; }
layout(constant_id = 10) const uint cmpIndex0 = 0u;


void main()
[[subgroup_uniform_control_flow]]
{

    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10000;
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
        if (subgroupElect()) {
        }
        {
            int loopIdx0 = 0;
            do {
                if (subgroupElect()) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10007;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    break;
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000b;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                loopIdx0++;
            } while (true);
        }
    }
    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000f;
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
    for (int loopIdx0 = 0;;loopIdx0++,    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect()) {
        switch (gl_SubgroupInvocationID & 3) {
            case 0:
            case 1:
            {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10014;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                break;
            }
            case 2:
            case 3:
            {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10018;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                break;
            }
        }
        for (int loopIdx1 = 0;;loopIdx1++,        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect()) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001d;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            if (subgroupElect()) {
                break;
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10022;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        }
        if (subgroupElect()) {
            break;
        }
        if (subgroupElect()) {
        }
        if (gl_SubgroupInvocationID == loopIdx0) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002b;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        } else {
        }
    }



}
#version 450 core
#extension GL_KHR_shader_subgroup_ballot : enable
#extension GL_KHR_shader_subgroup_vote : enable
#extension GL_NV_shader_subgroup_partitioned : enable
#extension GL_EXT_subgroup_uniform_control_flow : enable
layout(local_size_x_id = 0, local_size_y_id = 1, local_size_z = 1) in;
layout(set=0, binding=2) coherent buffer OutputC { uint loc[]; } outputC;
layout(set=0, binding=1) coherent buffer OutputB { uvec4 b[]; } outputB;
layout(set=0, binding=0) coherent buffer InputA  { uint  a[]; } inputA;
layout(push_constant) uniform PC {
   // set to the real stride when writing out ballots, or zero when just counting
   int  invocationStride;
   // wildcard fields, for an example the dimensions of rendered area in the case of graphics shaders
   int  width;
   int  height;
   uint primitiveStride;
   uint subgroupStride;
   uint enableInvocationIndex;
};
int outLoc = 0;
bool testBit(uvec4 mask, uint bit) { return ((mask[bit / 32] >> (bit % 32)) & 1) != 0; }
uint elect() { return int(subgroupElect()) + 1; }
layout(constant_id = 10) const uint cmpIndex0 = 0u;
layout(constant_id = 11) const uint cmpIndex1 = 0u;
layout(constant_id = 12) const uint cmpIndex2 = 0u;
layout(constant_id = 13) const uint cmpIndex3 = 0u;


void main()
[[subgroup_uniform_control_flow]]
{

    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10001;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        {
            int loopIdx0 = 0;
            do {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10004;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                if (subgroupElect()) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10007;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    break;
                }
                loopIdx0++;
            } while (true);
        }
    }
    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000d;
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex2]) {
        } else {
        }
        if (inputA.a[3] == 3) {
        } else {
        }
    } else {
        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex3]) {
        } else {
        }
        if (inputA.a[1] == 1) {
        } else {
        }
    }



}
#version 450 core
#extension GL_KHR_shader_subgroup_ballot : enable
#extension GL_KHR_shader_subgroup_vote : enable
#extension GL_NV_shader_subgroup_partitioned : enable
#extension GL_EXT_subgroup_uniform_control_flow : enable
layout(local_size_x_id = 0, local_size_y_id = 1, local_size_z = 1) in;
layout(set=0, binding=2) coherent buffer OutputC { uint loc[]; } outputC;
layout(set=0, binding=1) coherent buffer OutputB { uvec4 b[]; } outputB;
layout(set=0, binding=0) coherent buffer InputA  { uint  a[]; } inputA;
layout(push_constant) uniform PC {
   // set to the real stride when writing out ballots, or zero when just counting
   int  invocationStride;
   // wildcard fields, for an example the dimensions of rendered area in the case of graphics shaders
   int  width;
   int  height;
   uint primitiveStride;
   uint subgroupStride;
   uint enableInvocationIndex;
};
int outLoc = 0;
bool testBit(uvec4 mask, uint bit) { return ((mask[bit / 32] >> (bit % 32)) & 1) != 0; }
uint elect() { return int(subgroupElect()) + 1; }
layout(constant_id = 10) const uint cmpIndex0 = 0u;
layout(constant_id = 11) const uint cmpIndex1 = 0u;
layout(constant_id = 12) const uint cmpIndex2 = 0u;
layout(constant_id = 13) const uint cmpIndex3 = 0u;
layout(constant_id = 14) const uint cmpIndex4 = 0u;


void main()
[[subgroup_uniform_control_flow]]
{

    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10000;
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
    if (inputA.a[2] == 2) {
        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
        } else {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10005;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        }
        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10009;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        }
    } else {
        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex2]) {
        } else {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000f;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        }
        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex3]) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10013;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        } else {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10016;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        }
    }
    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex4]) {
        switch (gl_SubgroupInvocationID & 3) {
            case 0:
            case 1:
            {
                break;
            }
            case 2:
            case 3:
            {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001f;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                break;
            }
        }
    } else {
        for (int loopIdx0 = 0;;loopIdx0++,        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect()) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10025;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            if (subgroupElect()) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10028;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                break;
            }
        }
    }



}
#version 450 core
#extension GL_KHR_shader_subgroup_ballot : enable
#extension GL_KHR_shader_subgroup_vote : enable
#extension GL_NV_shader_subgroup_partitioned : enable
#extension GL_EXT_subgroup_uniform_control_flow : enable
layout(local_size_x_id = 0, local_size_y_id = 1, local_size_z = 1) in;
layout(set=0, binding=2) coherent buffer OutputC { uint loc[]; } outputC;
layout(set=0, binding=1) coherent buffer OutputB { uvec4 b[]; } outputB;
layout(set=0, binding=0) coherent buffer InputA  { uint  a[]; } inputA;
layout(push_constant) uniform PC {
   // set to the real stride when writing out ballots, or zero when just counting
   int  invocationStride;
   // wildcard fields, for an example the dimensions of rendered area in the case of graphics shaders
   int  width;
   int  height;
   uint primitiveStride;
   uint subgroupStride;
   uint enableInvocationIndex;
};
int outLoc = 0;
bool testBit(uvec4 mask, uint bit) { return ((mask[bit / 32] >> (bit % 32)) & 1) != 0; }
uint elect() { return int(subgroupElect()) + 1; }
layout(constant_id = 10) const uint cmpIndex0 = 0u;
layout(constant_id = 11) const uint cmpIndex1 = 0u;
layout(constant_id = 12) const uint cmpIndex2 = 0u;
layout(constant_id = 13) const uint cmpIndex3 = 0u;


void main()
[[subgroup_uniform_control_flow]]
{

    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10000;
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
    switch (inputA.a[2]) {
        case 3:
        {
            if (subgroupElect()) {
            }
            break;
        }
        case 2:
        {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10008;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            switch (gl_SubgroupInvocationID & 3) {
                case 0:
                case 1:
                {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000c;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    break;
                }
                case 2:
                case 3:
                {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10010;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    break;
                }
            }
            break;
        }
        case 4:
        {
            if (subgroupElect()) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10017;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            }
            break;
        }
    }
    if (testBit(uvec4(0x47437516, 0xdc8cc7ef, 0x85e228f4, 0xc902798b), gl_SubgroupInvocationID)) {
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001d;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10020;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        } else {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10020;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        }
        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
        }
    } else {
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001d;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex2]) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10020;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        } else {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10020;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        }
        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex3]) {
        }
    }



}
#version 450 core
#extension GL_KHR_shader_subgroup_ballot : enable
#extension GL_KHR_shader_subgroup_vote : enable
#extension GL_NV_shader_subgroup_partitioned : enable
#extension GL_EXT_subgroup_uniform_control_flow : enable
layout(local_size_x_id = 0, local_size_y_id = 1, local_size_z = 1) in;
layout(set=0, binding=2) coherent buffer OutputC { uint loc[]; } outputC;
layout(set=0, binding=1) coherent buffer OutputB { uvec4 b[]; } outputB;
layout(set=0, binding=0) coherent buffer InputA  { uint  a[]; } inputA;
layout(push_constant) uniform PC {
   // set to the real stride when writing out ballots, or zero when just counting
   int  invocationStride;
   // wildcard fields, for an example the dimensions of rendered area in the case of graphics shaders
   int  width;
   int  height;
   uint primitiveStride;
   uint subgroupStride;
   uint enableInvocationIndex;
};
int outLoc = 0;
bool testBit(uvec4 mask, uint bit) { return ((mask[bit / 32] >> (bit % 32)) & 1) != 0; }
uint elect() { return int(subgroupElect()) + 1; }
layout(constant_id = 10) const uint cmpIndex0 = 0u;


void main()
[[subgroup_uniform_control_flow]]
{

    if (testBit(uvec4(0x467d6e76, 0x4b45c110, 0xdc26e53e, 0xc4601a6e), gl_SubgroupInvocationID)) {
        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
        }
    } else {
        if (testBit(uvec4(0x467d6e76, 0x4b45c110, 0xdc26e53e, 0xc4601a6e), gl_SubgroupInvocationID)) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10005;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        }
        switch (gl_SubgroupInvocationID & 3) {
            case 0:
            case 1:
            {
                break;
            }
            case 2:
            case 3:
            {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000c;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                break;
            }
        }
    }
    switch (gl_SubgroupInvocationID & 3) {
        case 0:
        case 1:
        {
            switch (gl_SubgroupInvocationID & 3) {
                case 0:
                {
                    break;
                }
                case 1:
                {
                    break;
                }
                case 2:
                {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10019;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    break;
                }
                case 3:
                {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001d;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    break;
                }
            }
            break;
        }
        case 2:
        case 3:
        {
            for (int loopIdx0 = 0;;loopIdx0++,            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect()) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10024;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                if (subgroupElect()) {
                    break;
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10029;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            }
            break;
        }
    }
    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002e;
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();



}
#version 450 core
#extension GL_KHR_shader_subgroup_ballot : enable
#extension GL_KHR_shader_subgroup_vote : enable
#extension GL_NV_shader_subgroup_partitioned : enable
#extension GL_EXT_subgroup_uniform_control_flow : enable
layout(local_size_x_id = 0, local_size_y_id = 1, local_size_z = 1) in;
layout(set=0, binding=2) coherent buffer OutputC { uint loc[]; } outputC;
layout(set=0, binding=1) coherent buffer OutputB { uvec4 b[]; } outputB;
layout(set=0, binding=0) coherent buffer InputA  { uint  a[]; } inputA;
layout(push_constant) uniform PC {
   // set to the real stride when writing out ballots, or zero when just counting
   int  invocationStride;
   // wildcard fields, for an example the dimensions of rendered area in the case of graphics shaders
   int  width;
   int  height;
   uint primitiveStride;
   uint subgroupStride;
   uint enableInvocationIndex;
};
int outLoc = 0;
bool testBit(uvec4 mask, uint bit) { return ((mask[bit / 32] >> (bit % 32)) & 1) != 0; }
uint elect() { return int(subgroupElect()) + 1; }
layout(constant_id = 10) const uint cmpIndex0 = 0u;
layout(constant_id = 11) const uint cmpIndex1 = 0u;


void main()
[[subgroup_uniform_control_flow]]
{

    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10001;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10004;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        } else {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10004;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000a;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
    }
    for (int loopIdx0 = 0;
             loopIdx0 < gl_SubgroupInvocationID + 1;
             loopIdx0++) {
        switch (gl_SubgroupInvocationID & 3) {
            case 0:
            case 1:
            {
                break;
            }
            case 2:
            case 3:
            {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10012;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                break;
            }
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10016;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
    }
    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10019;
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
    if (testBit(uvec4(0xca3d6b2e, 0x914630b3, 0xb676d508, 0x160db633), gl_SubgroupInvocationID)) {
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001c;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        {
            int loopIdx0 = 0;
            do {
                if (subgroupElect()) {
                    break;
                }
                loopIdx0++;
            } while (true);
        }
    } else {
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001c;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        {
            int loopIdx0 = 0;
            do {
                if (subgroupElect()) {
                    break;
                }
                loopIdx0++;
            } while (true);
        }
    }



}
#version 450 core
#extension GL_KHR_shader_subgroup_ballot : enable
#extension GL_KHR_shader_subgroup_vote : enable
#extension GL_NV_shader_subgroup_partitioned : enable
#extension GL_EXT_subgroup_uniform_control_flow : enable
layout(local_size_x_id = 0, local_size_y_id = 1, local_size_z = 1) in;
layout(set=0, binding=2) coherent buffer OutputC { uint loc[]; } outputC;
layout(set=0, binding=1) coherent buffer OutputB { uvec4 b[]; } outputB;
layout(set=0, binding=0) coherent buffer InputA  { uint  a[]; } inputA;
layout(push_constant) uniform PC {
   // set to the real stride when writing out ballots, or zero when just counting
   int  invocationStride;
   // wildcard fields, for an example the dimensions of rendered area in the case of graphics shaders
   int  width;
   int  height;
   uint primitiveStride;
   uint subgroupStride;
   uint enableInvocationIndex;
};
int outLoc = 0;
bool testBit(uvec4 mask, uint bit) { return ((mask[bit / 32] >> (bit % 32)) & 1) != 0; }
uint elect() { return int(subgroupElect()) + 1; }
layout(constant_id = 10) const uint cmpIndex0 = 0u;
layout(constant_id = 11) const uint cmpIndex1 = 0u;


void main()
[[subgroup_uniform_control_flow]]
{

    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
        if (testBit(uvec4(0x467d6e76, 0x4b45c110, 0xdc26e53e, 0xc4601a6e), gl_SubgroupInvocationID)) {
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10003;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        {
            int loopIdx0 = 0;
            do {
                if (subgroupElect()) {
                    break;
                }
                loopIdx0++;
            } while (true);
        }
    }
    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000b;
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
    if (testBit(uvec4(0x46e97b9d, 0xf7a119c6, 0xb4d59165, 0xb0864334), gl_SubgroupInvocationID)) {
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000e;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        if (testBit(uvec4(0xca3d6b2e, 0x914630b3, 0xb676d508, 0x160db633), gl_SubgroupInvocationID)) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10011;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        }
        for (int loopIdx0 = 0;
                 loopIdx0 < inputA.a[1];
                 loopIdx0++) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10015;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        }
    }
    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10019;
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
        switch (gl_SubgroupInvocationID & 3) {
            case 0:
            {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001e;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                break;
            }
            case 1:
            {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10022;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                break;
            }
            case 2:
            {
                break;
            }
            case 3:
            {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10028;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                break;
            }
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002c;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
    } else {
        switch (gl_SubgroupInvocationID & 3) {
            case 0:
            case 1:
            {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10031;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                break;
            }
            case 2:
            case 3:
            {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10035;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                break;
            }
        }
    }
    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1003a;
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();



}
#version 450 core
#extension GL_KHR_shader_subgroup_ballot : enable
#extension GL_KHR_shader_subgroup_vote : enable
#extension GL_NV_shader_subgroup_partitioned : enable
#extension GL_EXT_subgroup_uniform_control_flow : enable
layout(local_size_x_id = 0, local_size_y_id = 1, local_size_z = 1) in;
layout(set=0, binding=2) coherent buffer OutputC { uint loc[]; } outputC;
layout(set=0, binding=1) coherent buffer OutputB { uvec4 b[]; } outputB;
layout(set=0, binding=0) coherent buffer InputA  { uint  a[]; } inputA;
layout(push_constant) uniform PC {
   // set to the real stride when writing out ballots, or zero when just counting
   int  invocationStride;
   // wildcard fields, for an example the dimensions of rendered area in the case of graphics shaders
   int  width;
   int  height;
   uint primitiveStride;
   uint subgroupStride;
   uint enableInvocationIndex;
};
int outLoc = 0;
bool testBit(uvec4 mask, uint bit) { return ((mask[bit / 32] >> (bit % 32)) & 1) != 0; }
uint elect() { return int(subgroupElect()) + 1; }


void main()
[[subgroup_uniform_control_flow]]
{

    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10000;
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
    if (testBit(uvec4(0x5e7c62c7, 0x70aa04d5, 0xd5ac6041, 0xab1a9911), gl_SubgroupInvocationID)) {
        if (subgroupElect()) {
            if (testBit(uvec4(0x5e7c62c7, 0x70aa04d5, 0xd5ac6041, 0xab1a9911), gl_SubgroupInvocationID)) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10005;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            } else {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10008;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000b;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        }
        if (inputA.a[1] == 1) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000f;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            for (int loopIdx0 = 0;;loopIdx0++,            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect()) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10012;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                if (subgroupElect()) {
                    break;
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10017;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001a;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            if (subgroupElect()) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001d;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            }
        } else {
            switch (gl_SubgroupInvocationID & 3) {
                case 0:
                case 1:
                {
                    break;
                }
                case 2:
                case 3:
                {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10025;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    break;
                }
            }
            if (subgroupElect()) {
            }
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002c;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
    } else {
        if (subgroupElect()) {
            if (subgroupElect()) {
            }
            if (inputA.a[1] == 1) {
            }
        }
    }



}
#version 450 core
#extension GL_KHR_shader_subgroup_ballot : enable
#extension GL_KHR_shader_subgroup_vote : enable
#extension GL_NV_shader_subgroup_partitioned : enable
#extension GL_EXT_subgroup_uniform_control_flow : enable
layout(local_size_x_id = 0, local_size_y_id = 1, local_size_z = 1) in;
layout(set=0, binding=2) coherent buffer OutputC { uint loc[]; } outputC;
layout(set=0, binding=1) coherent buffer OutputB { uvec4 b[]; } outputB;
layout(set=0, binding=0) coherent buffer InputA  { uint  a[]; } inputA;
layout(push_constant) uniform PC {
   // set to the real stride when writing out ballots, or zero when just counting
   int  invocationStride;
   // wildcard fields, for an example the dimensions of rendered area in the case of graphics shaders
   int  width;
   int  height;
   uint primitiveStride;
   uint subgroupStride;
   uint enableInvocationIndex;
};
int outLoc = 0;
bool testBit(uvec4 mask, uint bit) { return ((mask[bit / 32] >> (bit % 32)) & 1) != 0; }
uint elect() { return int(subgroupElect()) + 1; }
layout(constant_id = 10) const uint cmpIndex0 = 0u;
layout(constant_id = 11) const uint cmpIndex1 = 0u;


void main()
[[subgroup_uniform_control_flow]]
{

    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
        switch (gl_SubgroupInvocationID & 3) {
            case 0:
            case 1:
            {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10003;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                if (inputA.a[1] == 1) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10006;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                } else {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10009;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                }
                break;
            }
            case 2:
            case 3:
            {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000e;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10011;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                }
                break;
            }
        }
    } else {
        {
            int loopIdx0 = 0;
            do {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10018;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                {
                    int loopIdx1 = 0;
                    do {
                        loopIdx1++;
                    } while (loopIdx1 < inputA.a[1]);
                }
                if (inputA.a[3] == 3) {
                }
                if (subgroupElect()) {
                    break;
                }
                if (testBit(uvec4(0x812c43cc, 0x2f392383, 0xd1212f39, 0x629a3975), gl_SubgroupInvocationID)) {
                } else {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10023;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                }
                switch (gl_SubgroupInvocationID & 3) {
                    case 0:
                    {
                        break;
                    }
                    case 1:
                    {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002a;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                        break;
                    }
                    case 2:
                    {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002e;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                        break;
                    }
                    case 3:
                    {
                        break;
                    }
                }
                loopIdx0++;
            } while (true);
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10035;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
    }
    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10038;
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();



}
#version 450 core
#extension GL_KHR_shader_subgroup_ballot : enable
#extension GL_KHR_shader_subgroup_vote : enable
#extension GL_NV_shader_subgroup_partitioned : enable
#extension GL_EXT_subgroup_uniform_control_flow : enable
layout(local_size_x_id = 0, local_size_y_id = 1, local_size_z = 1) in;
layout(set=0, binding=2) coherent buffer OutputC { uint loc[]; } outputC;
layout(set=0, binding=1) coherent buffer OutputB { uvec4 b[]; } outputB;
layout(set=0, binding=0) coherent buffer InputA  { uint  a[]; } inputA;
layout(push_constant) uniform PC {
   // set to the real stride when writing out ballots, or zero when just counting
   int  invocationStride;
   // wildcard fields, for an example the dimensions of rendered area in the case of graphics shaders
   int  width;
   int  height;
   uint primitiveStride;
   uint subgroupStride;
   uint enableInvocationIndex;
};
int outLoc = 0;
bool testBit(uvec4 mask, uint bit) { return ((mask[bit / 32] >> (bit % 32)) & 1) != 0; }
uint elect() { return int(subgroupElect()) + 1; }
layout(constant_id = 10) const uint cmpIndex0 = 0u;
layout(constant_id = 11) const uint cmpIndex1 = 0u;
layout(constant_id = 12) const uint cmpIndex2 = 0u;
layout(constant_id = 13) const uint cmpIndex3 = 0u;


void main()
[[subgroup_uniform_control_flow]]
{

    {
        int loopIdx0 = 0;
        do {
            loopIdx0++;
            return;
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10002;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        } while (loopIdx0 < inputA.a[5]);
    }
    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10006;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        if (testBit(uvec4(0x91b3bcd8, 0x6a4b0e01, 0x2033a7ef, 0xef82cc51), gl_SubgroupInvocationID)) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10009;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000c;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            } else {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000c;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10012;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        } else {
            switch (gl_SubgroupInvocationID & 3) {
                case 0:
                case 1:
                {
                    break;
                }
                case 2:
                case 3:
                {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10019;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    break;
                }
            }
            if (inputA.a[2] == 2) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001e;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            } else {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10021;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            }
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10025;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        switch (gl_SubgroupInvocationID & 3) {
            case 0:
            case 1:
            {
                if (gl_LocalInvocationIndex >= inputA.a[cmpIndex2]) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002a;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002d;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                {
                    int loopIdx0 = 0;
                    do {
                        if (subgroupElect()) {
                            break;
                        }
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10033;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                        loopIdx0++;
                    } while (true);
                }
                break;
            }
            case 2:
            case 3:
            {
                if (gl_LocalInvocationIndex >= inputA.a[cmpIndex3]) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10039;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                } else {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1003c;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                }
                {
                    int loopIdx0 = 0;
                    do {
                        if (subgroupElect()) {
                            break;
                        }
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10043;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                        loopIdx0++;
                    } while (true);
                }
                break;
            }
        }
    }



}
#version 450 core
#extension GL_KHR_shader_subgroup_ballot : enable
#extension GL_KHR_shader_subgroup_vote : enable
#extension GL_NV_shader_subgroup_partitioned : enable
#extension GL_EXT_subgroup_uniform_control_flow : enable
layout(local_size_x_id = 0, local_size_y_id = 1, local_size_z = 1) in;
layout(set=0, binding=2) coherent buffer OutputC { uint loc[]; } outputC;
layout(set=0, binding=1) coherent buffer OutputB { uvec4 b[]; } outputB;
layout(set=0, binding=0) coherent buffer InputA  { uint  a[]; } inputA;
layout(push_constant) uniform PC {
   // set to the real stride when writing out ballots, or zero when just counting
   int  invocationStride;
   // wildcard fields, for an example the dimensions of rendered area in the case of graphics shaders
   int  width;
   int  height;
   uint primitiveStride;
   uint subgroupStride;
   uint enableInvocationIndex;
};
int outLoc = 0;
bool testBit(uvec4 mask, uint bit) { return ((mask[bit / 32] >> (bit % 32)) & 1) != 0; }
uint elect() { return int(subgroupElect()) + 1; }
layout(constant_id = 10) const uint cmpIndex0 = 0u;
layout(constant_id = 11) const uint cmpIndex1 = 0u;


void main()
[[subgroup_uniform_control_flow]]
{

    for (int loopIdx0 = 0;;loopIdx0++,    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect()) {
        break;
        if (gl_SubgroupInvocationID == loopIdx0) {
            if (inputA.a[3] == 3) {
            } else {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10005;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            }
            if (gl_SubgroupInvocationID == loopIdx0) {
            } else {
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000b;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        } else {
            break;
        }
        if (subgroupElect()) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10011;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            break;
        }
        if (gl_SubgroupInvocationID == loopIdx0) {
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
            }
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10019;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            } else {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001c;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001f;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        } else {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10022;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            if (testBit(uvec4(0x9b54ecd6, 0x8188af72, 0xf3e714de, 0x4343808e), gl_SubgroupInvocationID)) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10025;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            } else {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10025;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002b;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            switch (gl_SubgroupInvocationID & 3) {
                case 0:
                case 1:
                {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002f;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    break;
                }
                case 2:
                case 3:
                {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10033;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    break;
                }
            }
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10038;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        switch (gl_SubgroupInvocationID & 3) {
            case 0:
            {
                switch (gl_SubgroupInvocationID & 3) {
                    case 0:
                    case 1:
                    {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1003e;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                        break;
                    }
                    case 2:
                    case 3:
                    {
                        break;
                    }
                }
                break;
            }
            case 1:
            {
                if (testBit(uvec4(0x9b54ecd6, 0x8188af72, 0xf3e714de, 0x4343808e), gl_SubgroupInvocationID)) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10047;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1004a;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                break;
            }
            case 2:
            {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1004e;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                if (subgroupElect()) {
                }
                break;
            }
            case 3:
            {
                for (int loopIdx1 = 0;
                         loopIdx1 < inputA.a[3];
                         loopIdx1++) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10055;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                }
                break;
            }
        }
    }



}
#version 450 core
#extension GL_KHR_shader_subgroup_ballot : enable
#extension GL_KHR_shader_subgroup_vote : enable
#extension GL_NV_shader_subgroup_partitioned : enable
#extension GL_EXT_subgroup_uniform_control_flow : enable
layout(local_size_x_id = 0, local_size_y_id = 1, local_size_z = 1) in;
layout(set=0, binding=2) coherent buffer OutputC { uint loc[]; } outputC;
layout(set=0, binding=1) coherent buffer OutputB { uvec4 b[]; } outputB;
layout(set=0, binding=0) coherent buffer InputA  { uint  a[]; } inputA;
layout(push_constant) uniform PC {
   // set to the real stride when writing out ballots, or zero when just counting
   int  invocationStride;
   // wildcard fields, for an example the dimensions of rendered area in the case of graphics shaders
   int  width;
   int  height;
   uint primitiveStride;
   uint subgroupStride;
   uint enableInvocationIndex;
};
int outLoc = 0;
bool testBit(uvec4 mask, uint bit) { return ((mask[bit / 32] >> (bit % 32)) & 1) != 0; }
uint elect() { return int(subgroupElect()) + 1; }
layout(constant_id = 10) const uint cmpIndex0 = 0u;
layout(constant_id = 11) const uint cmpIndex1 = 0u;


void main()
[[subgroup_uniform_control_flow]]
{

    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10001;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        {
            int loopIdx0 = 0;
            do {
                {
                    int loopIdx1 = 0;
                    do {
                        loopIdx1++;
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10005;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    } while (loopIdx1 < inputA.a[4]);
                }
                if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10009;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                } else {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000c;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                }
                if (subgroupElect()) {
                    break;
                }
                if (inputA.a[3] == 3) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10013;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                } else {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10016;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10019;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                switch (gl_SubgroupInvocationID & 3) {
                    case 0:
                    {
                        break;
                    }
                    case 1:
                    {
                        break;
                    }
                    case 2:
                    {
                        break;
                    }
                    case 3:
                    {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10023;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                        break;
                    }
                }
                loopIdx0++;
            } while (true);
        }
        {
            int loopIdx0 = 0;
            do {
                loopIdx0++;
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10029;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                switch (gl_SubgroupInvocationID & 3) {
                    case 0:
                    case 1:
                    {
                        break;
                    }
                    case 2:
                    case 3:
                    {
                        break;
                    }
                }
                switch (gl_SubgroupInvocationID & 3) {
                    case 0:
                    case 1:
                    {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10033;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                        break;
                    }
                    case 2:
                    case 3:
                    {
                        break;
                    }
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10039;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            } while (loopIdx0 < inputA.a[4]);
        }
    }



}
#version 450 core
#extension GL_KHR_shader_subgroup_ballot : enable
#extension GL_KHR_shader_subgroup_vote : enable
#extension GL_NV_shader_subgroup_partitioned : enable
#extension GL_EXT_subgroup_uniform_control_flow : enable
layout(local_size_x_id = 0, local_size_y_id = 1, local_size_z = 1) in;
layout(set=0, binding=2) coherent buffer OutputC { uint loc[]; } outputC;
layout(set=0, binding=1) coherent buffer OutputB { uvec4 b[]; } outputB;
layout(set=0, binding=0) coherent buffer InputA  { uint  a[]; } inputA;
layout(push_constant) uniform PC {
   // set to the real stride when writing out ballots, or zero when just counting
   int  invocationStride;
   // wildcard fields, for an example the dimensions of rendered area in the case of graphics shaders
   int  width;
   int  height;
   uint primitiveStride;
   uint subgroupStride;
   uint enableInvocationIndex;
};
int outLoc = 0;
bool testBit(uvec4 mask, uint bit) { return ((mask[bit / 32] >> (bit % 32)) & 1) != 0; }
uint elect() { return int(subgroupElect()) + 1; }
layout(constant_id = 10) const uint cmpIndex0 = 0u;
layout(constant_id = 11) const uint cmpIndex1 = 0u;
layout(constant_id = 12) const uint cmpIndex2 = 0u;
layout(constant_id = 13) const uint cmpIndex3 = 0u;


void main()
[[subgroup_uniform_control_flow]]
{

    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10000;
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
    if (inputA.a[0] == 0) {
        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
            if (testBit(uvec4(0xf77511fe, 0x9ecaa8ed, 0x511db92f, 0x8ad08538), gl_SubgroupInvocationID)) {
            } else {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10006;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10009;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            {
                int loopIdx0 = 0;
                do {
                    if (subgroupElect()) {
                        break;
                    }
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000f;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    loopIdx0++;
                } while (true);
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10012;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10015;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        if (subgroupElect()) {
            if (subgroupElect()) {
            }
        }
    } else {
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001c;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        if (testBit(uvec4(0x9e19d960, 0xdc84f6e8, 0x5cf95d28, 0x1058dec4), gl_SubgroupInvocationID)) {
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10020;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            } else {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10020;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10026;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex2]) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10029;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            } else {
            }
        } else {
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex3]) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002f;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10032;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            switch (gl_SubgroupInvocationID & 3) {
                case 0:
                case 1:
                {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10036;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    break;
                }
                case 2:
                case 3:
                {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1003a;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    break;
                }
            }
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1003f;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        for (int loopIdx0 = 0;
                 loopIdx0 < inputA.a[2];
                 loopIdx0++) {
            for (int loopIdx1 = 0;
                     loopIdx1 < gl_SubgroupInvocationID + 1;
                     loopIdx1++) {
            }
            if (inputA.a[0] == 0) {
            }
        }
    }



}
#version 450 core
#extension GL_KHR_shader_subgroup_ballot : enable
#extension GL_KHR_shader_subgroup_vote : enable
#extension GL_NV_shader_subgroup_partitioned : enable
#extension GL_EXT_subgroup_uniform_control_flow : enable
layout(local_size_x_id = 0, local_size_y_id = 1, local_size_z = 1) in;
layout(set=0, binding=2) coherent buffer OutputC { uint loc[]; } outputC;
layout(set=0, binding=1) coherent buffer OutputB { uvec4 b[]; } outputB;
layout(set=0, binding=0) coherent buffer InputA  { uint  a[]; } inputA;
layout(push_constant) uniform PC {
   // set to the real stride when writing out ballots, or zero when just counting
   int  invocationStride;
   // wildcard fields, for an example the dimensions of rendered area in the case of graphics shaders
   int  width;
   int  height;
   uint primitiveStride;
   uint subgroupStride;
   uint enableInvocationIndex;
};
int outLoc = 0;
bool testBit(uvec4 mask, uint bit) { return ((mask[bit / 32] >> (bit % 32)) & 1) != 0; }
uint elect() { return int(subgroupElect()) + 1; }
layout(constant_id = 10) const uint cmpIndex0 = 0u;
layout(constant_id = 11) const uint cmpIndex1 = 0u;
layout(constant_id = 12) const uint cmpIndex2 = 0u;
layout(constant_id = 13) const uint cmpIndex3 = 0u;


void main()
[[subgroup_uniform_control_flow]]
{

    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10000;
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
    switch (inputA.a[2]) {
        case 3:
        {
            if (subgroupElect()) {
                {
                    int loopIdx0 = 0;
                    do {
                        loopIdx0++;
                    } while (loopIdx0 < inputA.a[3]);
                }
                if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10008;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                } else {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10008;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                }
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000f;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            break;
        }
        case 2:
        {
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
                if (inputA.a[3] == 3) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10015;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                } else {
                }
                if (gl_LocalInvocationIndex >= inputA.a[cmpIndex2]) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001a;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                }
            }
            if (testBit(uvec4(0xe6163c7e, 0x3dd7ce3b, 0xf9c3ed9c, 0xcc6299f6), gl_SubgroupInvocationID)) {
                if (gl_LocalInvocationIndex >= inputA.a[cmpIndex3]) {
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10021;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10024;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            break;
        }
        case 4:
        {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10028;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            if (subgroupElect()) {
                {
                    int loopIdx0 = 0;
                    do {
                        loopIdx0++;
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002c;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    } while (loopIdx0 < inputA.a[1]);
                }
            }
            break;
        }
    }



}
#version 450 core
#extension GL_KHR_shader_subgroup_ballot : enable
#extension GL_KHR_shader_subgroup_vote : enable
#extension GL_NV_shader_subgroup_partitioned : enable
#extension GL_EXT_subgroup_uniform_control_flow : enable
layout(local_size_x_id = 0, local_size_y_id = 1, local_size_z = 1) in;
layout(set=0, binding=2) coherent buffer OutputC { uint loc[]; } outputC;
layout(set=0, binding=1) coherent buffer OutputB { uvec4 b[]; } outputB;
layout(set=0, binding=0) coherent buffer InputA  { uint  a[]; } inputA;
layout(push_constant) uniform PC {
   // set to the real stride when writing out ballots, or zero when just counting
   int  invocationStride;
   // wildcard fields, for an example the dimensions of rendered area in the case of graphics shaders
   int  width;
   int  height;
   uint primitiveStride;
   uint subgroupStride;
   uint enableInvocationIndex;
};
int outLoc = 0;
bool testBit(uvec4 mask, uint bit) { return ((mask[bit / 32] >> (bit % 32)) & 1) != 0; }
uint elect() { return int(subgroupElect()) + 1; }
layout(constant_id = 10) const uint cmpIndex0 = 0u;
layout(constant_id = 11) const uint cmpIndex1 = 0u;


void main()
[[subgroup_uniform_control_flow]]
{

    if (testBit(uvec4(0x3750d52a, 0x1615a8dd, 0x4c4903d2, 0x4c9741dd), gl_SubgroupInvocationID)) {
        return;
        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10003;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10006;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
    } else {
        if (testBit(uvec4(0xca3d6b2e, 0x914630b3, 0xb676d508, 0x160db633), gl_SubgroupInvocationID)) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000a;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            {
                int loopIdx0 = 0;
                do {
                    if (subgroupElect()) {
                        break;
                    }
                    loopIdx0++;
                } while (true);
            }
        } else {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000a;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            {
                int loopIdx0 = 0;
                do {
                    if (subgroupElect()) {
                        break;
                    }
                    loopIdx0++;
                } while (true);
            }
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001a;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
    }
    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
        if (subgroupElect()) {
            if (inputA.a[1] == 1) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10020;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            } else {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10020;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            }
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10027;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
    } else {
        if (subgroupElect()) {
            if (inputA.a[0] == 0) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10020;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            } else {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10020;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            }
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10027;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
    }
    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10036;
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();



}
#version 450 core
#extension GL_KHR_shader_subgroup_ballot : enable
#extension GL_KHR_shader_subgroup_vote : enable
#extension GL_NV_shader_subgroup_partitioned : enable
#extension GL_EXT_subgroup_uniform_control_flow : enable
layout(local_size_x_id = 0, local_size_y_id = 1, local_size_z = 1) in;
layout(set=0, binding=2) coherent buffer OutputC { uint loc[]; } outputC;
layout(set=0, binding=1) coherent buffer OutputB { uvec4 b[]; } outputB;
layout(set=0, binding=0) coherent buffer InputA  { uint  a[]; } inputA;
layout(push_constant) uniform PC {
   // set to the real stride when writing out ballots, or zero when just counting
   int  invocationStride;
   // wildcard fields, for an example the dimensions of rendered area in the case of graphics shaders
   int  width;
   int  height;
   uint primitiveStride;
   uint subgroupStride;
   uint enableInvocationIndex;
};
int outLoc = 0;
bool testBit(uvec4 mask, uint bit) { return ((mask[bit / 32] >> (bit % 32)) & 1) != 0; }
uint elect() { return int(subgroupElect()) + 1; }


void main()
[[subgroup_uniform_control_flow]]
{

    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10000;
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
    if (testBit(uvec4(0x5e7c62c7, 0x70aa04d5, 0xd5ac6041, 0xab1a9911), gl_SubgroupInvocationID)) {
        if (subgroupElect()) {
            if (testBit(uvec4(0x5e7c62c7, 0x70aa04d5, 0xd5ac6041, 0xab1a9911), gl_SubgroupInvocationID)) {
                for (int loopIdx0 = 0;
                         loopIdx0 < inputA.a[1];
                         loopIdx0++) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10006;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10009;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                {
                    int loopIdx0 = 0;
                    do {
                        loopIdx0++;
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000c;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    } while (loopIdx0 < inputA.a[3]);
                }
            } else {
                {
                    int loopIdx0 = 0;
                    do {
                        loopIdx0++;
                    } while (loopIdx0 < inputA.a[2]);
                }
                switch (gl_SubgroupInvocationID & 3) {
                    case 0:
                    {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10014;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                        break;
                    }
                    case 1:
                    {
                        break;
                    }
                    case 2:
                    {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001a;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                        break;
                    }
                    case 3:
                    {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001e;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                        break;
                    }
                }
            }
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10024;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
    }
    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10027;
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();



}
#version 450 core
#extension GL_KHR_shader_subgroup_ballot : enable
#extension GL_KHR_shader_subgroup_vote : enable
#extension GL_NV_shader_subgroup_partitioned : enable
#extension GL_EXT_subgroup_uniform_control_flow : enable
layout(local_size_x_id = 0, local_size_y_id = 1, local_size_z = 1) in;
layout(set=0, binding=2) coherent buffer OutputC { uint loc[]; } outputC;
layout(set=0, binding=1) coherent buffer OutputB { uvec4 b[]; } outputB;
layout(set=0, binding=0) coherent buffer InputA  { uint  a[]; } inputA;
layout(push_constant) uniform PC {
   // set to the real stride when writing out ballots, or zero when just counting
   int  invocationStride;
   // wildcard fields, for an example the dimensions of rendered area in the case of graphics shaders
   int  width;
   int  height;
   uint primitiveStride;
   uint subgroupStride;
   uint enableInvocationIndex;
};
int outLoc = 0;
bool testBit(uvec4 mask, uint bit) { return ((mask[bit / 32] >> (bit % 32)) & 1) != 0; }
uint elect() { return int(subgroupElect()) + 1; }
layout(constant_id = 10) const uint cmpIndex0 = 0u;
layout(constant_id = 11) const uint cmpIndex1 = 0u;
layout(constant_id = 12) const uint cmpIndex2 = 0u;
layout(constant_id = 13) const uint cmpIndex3 = 0u;
layout(constant_id = 14) const uint cmpIndex4 = 0u;
layout(constant_id = 15) const uint cmpIndex5 = 0u;
layout(constant_id = 16) const uint cmpIndex6 = 0u;


void main()
[[subgroup_uniform_control_flow]]
{

    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
        switch (gl_SubgroupInvocationID & 3) {
            case 0:
            case 1:
            {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10003;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                if (inputA.a[2] == 2) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10006;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    if (testBit(uvec4(0xd4333cb6, 0x37e22ba5, 0xbf5155f0, 0x67d1e6d4), gl_SubgroupInvocationID)) {
                    }
                    if (inputA.a[0] == 0) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000b;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    } else {
                    }
                }
                break;
            }
            case 2:
            case 3:
            {
                if (inputA.a[3] == 3) {
                    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10014;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    } else {
                    }
                    if (subgroupElect()) {
                    }
                } else {
                    if (testBit(uvec4(0xd4333cb6, 0x37e22ba5, 0xbf5155f0, 0x67d1e6d4), gl_SubgroupInvocationID)) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001c;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    } else {
                    }
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10020;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    if (subgroupElect()) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10023;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    }
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10026;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                }
                for (int loopIdx0 = 0;;loopIdx0++,                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect()) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002a;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    break;
                    if (subgroupElect()) {
                        while (!subgroupElect()) {}
                        if (testBit(uvec4(0x579965e, 0xdcab3315, 0xc6e61baa, 0x8b38dac5), gl_SubgroupInvocationID)) {
                            break;
                        } else {
                            break;
                        }
                    }
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10035;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    if (subgroupElect()) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10038;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    }
                    if (gl_SubgroupInvocationID == loopIdx0) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1003c;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    }
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10040;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                break;
            }
        }
    } else {
        {
            int loopIdx0 = 0;
            do {
                switch (gl_SubgroupInvocationID & 3) {
                    case 0:
                    {
                        if (testBit(uvec4(0xd4333cb6, 0x37e22ba5, 0xbf5155f0, 0x67d1e6d4), gl_SubgroupInvocationID)) {
                        }
                        break;
                    }
                    case 1:
                    {
                        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex2]) {
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1004d;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                        } else {
                        }
                        break;
                    }
                    case 2:
                    {
                        {
                            int loopIdx1 = 0;
                            do {
                                outputC.loc[gl_LocalInvocationIndex]++;
                                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10054;
                                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                                if (subgroupElect()) {
                                    outputC.loc[gl_LocalInvocationIndex]++;
                                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10057;
                                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                                    break;
                                }
                                outputC.loc[gl_LocalInvocationIndex]++;
                                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1005b;
                                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                                loopIdx1++;
                            } while (true);
                        }
                        break;
                    }
                    case 3:
                    {
                        switch (inputA.a[3]) {
                            case 4:
                            {
                                break;
                            }
                            case 3:
                            {
                                outputC.loc[gl_LocalInvocationIndex]++;
                                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10064;
                                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                                break;
                            }
                            case 5:
                            {
                                outputC.loc[gl_LocalInvocationIndex]++;
                                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10068;
                                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                                break;
                            }
                        }
                        break;
                    }
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1006e;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                if (gl_LocalInvocationIndex >= inputA.a[cmpIndex3]) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10071;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex4]) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10074;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    } else {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10077;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    }
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1007a;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    if (gl_SubgroupInvocationID == loopIdx0) {
                    }
                }
                if (subgroupElect()) {
                    break;
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10082;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                if (testBit(uvec4(0xedc86e76, 0xf7f5097c, 0x70d87a0d, 0xa26827a3), gl_SubgroupInvocationID)) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10085;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    {
                        int loopIdx1 = 0;
                        do {
                            loopIdx1++;
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10088;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                        } while (loopIdx1 < inputA.a[1]);
                    }
                    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex5]) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1008c;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    }
                }
                loopIdx0++;
            } while (true);
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10091;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        for (int loopIdx0 = 0;;loopIdx0++,        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect()) {
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex6]) {
                {
                    int loopIdx1 = 0;
                    do {
                        loopIdx1++;
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10096;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    } while (loopIdx1 < inputA.a[2]);
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10099;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                {
                    int loopIdx1 = 0;
                    do {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1009c;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                        if (subgroupElect()) {
                            break;
                        }
                        loopIdx1++;
                    } while (true);
                }
            }
            if (subgroupElect()) {
                for (int loopIdx1 = 0;
                         loopIdx1 < gl_SubgroupInvocationID + 1;
                         loopIdx1++) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x100a5;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                }
                break;
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x100a9;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            }
            if (subgroupElect()) {
                break;
            }
            switch (gl_SubgroupInvocationID & 3) {
                case 0:
                {
                    if (gl_SubgroupInvocationID == loopIdx0) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x100b2;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    }
                    break;
                }
                case 1:
                {
                    switch (loopIdx0) {
                        case 1: {
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x100b9;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                            break;
                        }
                        case 2: {
                            break;
                        }
                        default: {
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x100bf;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                            break;
                        }
                    }
                    break;
                }
                case 2:
                {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x100c5;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    if (inputA.a[0] == 0) {
                    }
                    break;
                }
                case 3:
                {
                    if (testBit(uvec4(0x812c43cc, 0x2f392383, 0xd1212f39, 0x629a3975), gl_SubgroupInvocationID)) {
                    }
                    break;
                }
            }
        }
    }



}
#version 450 core
#extension GL_KHR_shader_subgroup_ballot : enable
#extension GL_KHR_shader_subgroup_vote : enable
#extension GL_NV_shader_subgroup_partitioned : enable
#extension GL_EXT_subgroup_uniform_control_flow : enable
layout(local_size_x_id = 0, local_size_y_id = 1, local_size_z = 1) in;
layout(set=0, binding=2) coherent buffer OutputC { uint loc[]; } outputC;
layout(set=0, binding=1) coherent buffer OutputB { uvec4 b[]; } outputB;
layout(set=0, binding=0) coherent buffer InputA  { uint  a[]; } inputA;
layout(push_constant) uniform PC {
   // set to the real stride when writing out ballots, or zero when just counting
   int  invocationStride;
   // wildcard fields, for an example the dimensions of rendered area in the case of graphics shaders
   int  width;
   int  height;
   uint primitiveStride;
   uint subgroupStride;
   uint enableInvocationIndex;
};
int outLoc = 0;
bool testBit(uvec4 mask, uint bit) { return ((mask[bit / 32] >> (bit % 32)) & 1) != 0; }
uint elect() { return int(subgroupElect()) + 1; }
layout(constant_id = 10) const uint cmpIndex0 = 0u;
layout(constant_id = 11) const uint cmpIndex1 = 0u;
layout(constant_id = 12) const uint cmpIndex2 = 0u;
layout(constant_id = 13) const uint cmpIndex3 = 0u;
layout(constant_id = 14) const uint cmpIndex4 = 0u;
layout(constant_id = 15) const uint cmpIndex5 = 0u;
layout(constant_id = 16) const uint cmpIndex6 = 0u;
layout(constant_id = 17) const uint cmpIndex7 = 0u;
layout(constant_id = 18) const uint cmpIndex8 = 0u;
layout(constant_id = 19) const uint cmpIndex9 = 0u;
layout(constant_id = 20) const uint cmpIndex10 = 0u;
layout(constant_id = 21) const uint cmpIndex11 = 0u;
layout(constant_id = 22) const uint cmpIndex12 = 0u;
layout(constant_id = 23) const uint cmpIndex13 = 0u;
layout(constant_id = 24) const uint cmpIndex14 = 0u;
layout(constant_id = 25) const uint cmpIndex15 = 0u;
layout(constant_id = 26) const uint cmpIndex16 = 0u;


void main()
[[subgroup_uniform_control_flow]]
{

    {
        int loopIdx0 = 0;
        do {
            loopIdx0++;
            return;
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10002;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        } while (loopIdx0 < inputA.a[5]);
    }
    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10006;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        if (testBit(uvec4(0x91b3bcd8, 0x6a4b0e01, 0x2033a7ef, 0xef82cc51), gl_SubgroupInvocationID)) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10009;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
                {
                    int loopIdx0 = 0;
                    do {
                        loopIdx0++;
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000d;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    } while (loopIdx0 < inputA.a[5]);
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10010;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                if (gl_LocalInvocationIndex >= inputA.a[cmpIndex2]) {
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10014;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            } else {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10017;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                if (gl_LocalInvocationIndex >= inputA.a[cmpIndex3]) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001a;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001d;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                if (inputA.a[2] == 2) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10020;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                }
            }
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex4]) {
                for (int loopIdx0 = 0;
                         loopIdx0 < inputA.a[1];
                         loopIdx0++) {
                }
                while (!subgroupElect()) {}
                {
                    int loopIdx0 = 0;
                    do {
                        if (subgroupElect()) {
                            break;
                        }
                        loopIdx0++;
                    } while (true);
                }
            } else {
                if (gl_LocalInvocationIndex >= inputA.a[cmpIndex5]) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002f;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                } else {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10032;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                }
                switch (gl_SubgroupInvocationID & 3) {
                    case 0:
                    case 1:
                    {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10037;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                        break;
                    }
                    case 2:
                    case 3:
                    {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1003b;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                        break;
                    }
                }
            }
        } else {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10009;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex6]) {
                {
                    int loopIdx0 = 0;
                    do {
                        loopIdx0++;
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000d;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    } while (loopIdx0 < inputA.a[5]);
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10010;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                if (gl_LocalInvocationIndex >= inputA.a[cmpIndex7]) {
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10014;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            } else {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10017;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                if (gl_LocalInvocationIndex >= inputA.a[cmpIndex8]) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001a;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001d;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                if (inputA.a[0] == 0) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10020;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                }
            }
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex9]) {
                for (int loopIdx0 = 0;
                         loopIdx0 < inputA.a[1];
                         loopIdx0++) {
                }
                while (!subgroupElect()) {}
                {
                    int loopIdx0 = 0;
                    do {
                        if (subgroupElect()) {
                            break;
                        }
                        loopIdx0++;
                    } while (true);
                }
            } else {
                if (gl_LocalInvocationIndex >= inputA.a[cmpIndex10]) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002f;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                } else {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10032;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                }
                switch (gl_SubgroupInvocationID & 3) {
                    case 0:
                    case 1:
                    {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10037;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                        break;
                    }
                    case 2:
                    case 3:
                    {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1003b;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                        break;
                    }
                }
            }
        }
        {
            int loopIdx0 = 0;
            do {
                if (gl_LocalInvocationIndex >= inputA.a[cmpIndex11]) {
                    for (int loopIdx1 = 0;
                             loopIdx1 < gl_SubgroupInvocationID + 1;
                             loopIdx1++) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1007c;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    }
                } else {
                    for (int loopIdx1 = 0;
                             loopIdx1 < gl_SubgroupInvocationID + 1;
                             loopIdx1++) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1007c;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    }
                }
                if (gl_SubgroupInvocationID == loopIdx0) {
                    if (testBit(uvec4(0xede2dc2c, 0xdcb30010, 0x2ebc3846, 0x63a3bd92), gl_SubgroupInvocationID)) {
                        break;
                    } else {
                        break;
                    }
                    if (inputA.a[0] == 0) {
                    }
                }
                if (subgroupElect()) {
                    break;
                }
                if (testBit(uvec4(0x1e63b50d, 0x123a9eee, 0x5acbdd0b, 0xe77a12d4), gl_SubgroupInvocationID)) {
                    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex12]) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10093;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    } else {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10096;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    }
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10099;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    if (gl_SubgroupInvocationID == loopIdx0) {
                    } else {
                    }
                } else {
                    if (gl_SubgroupInvocationID == loopIdx0) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x100a0;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    } else {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x100a3;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    }
                    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex13]) {
                    }
                }
                {
                    int loopIdx1 = 0;
                    do {
                        break;
                        for (int loopIdx2 = 0;
                                 loopIdx2 < inputA.a[4];
                                 loopIdx2++) {
                        }
                        if (subgroupElect()) {
                            break;
                        }
                        if (gl_SubgroupInvocationID == loopIdx1) {
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x100b1;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                        }
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x100b4;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                        if (testBit(uvec4(0x1e63b50d, 0x123a9eee, 0x5acbdd0b, 0xe77a12d4), gl_SubgroupInvocationID)) {
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x100b7;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                        }
                        loopIdx1++;
                    } while (true);
                }
                loopIdx0++;
            } while (true);
        }
    } else {
        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex14]) {
            for (int loopIdx0 = 0;
                     loopIdx0 < gl_SubgroupInvocationID + 1;
                     loopIdx0++) {
                switch (gl_SubgroupInvocationID & 3) {
                    case 0:
                    case 1:
                    {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x100c1;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                        break;
                    }
                    case 2:
                    case 3:
                    {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x100c5;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                        break;
                    }
                }
                switch (loopIdx0) {
                    case 1: {
                        break;
                    }
                    case 2: {
                        break;
                    }
                    default: {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x100cf;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                        break;
                    }
                }
            }
            if (inputA.a[2] == 2) {
                if (gl_LocalInvocationIndex >= inputA.a[cmpIndex15]) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x100d6;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                } else {
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x100da;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            }
        } else {
            if (testBit(uvec4(0x1e63b50d, 0x123a9eee, 0x5acbdd0b, 0xe77a12d4), gl_SubgroupInvocationID)) {
                if (gl_LocalInvocationIndex >= inputA.a[cmpIndex16]) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x100e0;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                }
                {
                    int loopIdx0 = 0;
                    do {
                        if (subgroupElect()) {
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x100e5;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                            if (testBit(uvec4(0xede2dc2c, 0xdcb30010, 0x2ebc3846, 0x63a3bd92), gl_SubgroupInvocationID)) {
                                break;
                            } else {
                                break;
                            }
                        }
                        loopIdx0++;
                    } while (true);
                }
            }
        }
    }



}
#version 450 core
#extension GL_KHR_shader_subgroup_ballot : enable
#extension GL_KHR_shader_subgroup_vote : enable
#extension GL_NV_shader_subgroup_partitioned : enable
#extension GL_EXT_subgroup_uniform_control_flow : enable
layout(local_size_x_id = 0, local_size_y_id = 1, local_size_z = 1) in;
layout(set=0, binding=2) coherent buffer OutputC { uint loc[]; } outputC;
layout(set=0, binding=1) coherent buffer OutputB { uvec4 b[]; } outputB;
layout(set=0, binding=0) coherent buffer InputA  { uint  a[]; } inputA;
layout(push_constant) uniform PC {
   // set to the real stride when writing out ballots, or zero when just counting
   int  invocationStride;
   // wildcard fields, for an example the dimensions of rendered area in the case of graphics shaders
   int  width;
   int  height;
   uint primitiveStride;
   uint subgroupStride;
   uint enableInvocationIndex;
};
int outLoc = 0;
bool testBit(uvec4 mask, uint bit) { return ((mask[bit / 32] >> (bit % 32)) & 1) != 0; }
uint elect() { return int(subgroupElect()) + 1; }


void main()
[[subgroup_uniform_control_flow]]
{

    for (int loopIdx0 = 0;;loopIdx0++,    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect()) {
        break;
        if (gl_SubgroupInvocationID == loopIdx0) {
            if (inputA.a[3] == 3) {
                if (testBit(uvec4(0xe3e6077b, 0x934d4176, 0x44df3f14, 0x16bfbe39), gl_SubgroupInvocationID)) {
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10006;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                for (int loopIdx1 = 0;
                         loopIdx1 < inputA.a[2];
                         loopIdx1++) {
                }
            } else {
                if (gl_SubgroupInvocationID == loopIdx0) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000c;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                } else {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000f;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                }
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10013;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            if (inputA.a[3] == 3) {
                break;
                {
                    int loopIdx1 = 0;
                    do {
                        loopIdx1++;
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10018;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    } while (loopIdx1 < inputA.a[3]);
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001b;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            }
        } else {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001f;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            if (gl_SubgroupInvocationID == loopIdx0) {
                if (testBit(uvec4(0xbdeae9f, 0x37d0c6ef, 0x9f4cb738, 0x54c6189a), gl_SubgroupInvocationID)) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10023;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                }
                if (inputA.a[2] == 2) {
                } else {
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10029;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            } else {
                if (inputA.a[0] == 12345) {
                    while (true) {
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    }
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002d;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                if (testBit(uvec4(0xe3e6077b, 0x934d4176, 0x44df3f14, 0x16bfbe39), gl_SubgroupInvocationID)) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10030;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10033;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10036;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        }
        if (subgroupElect()) {
            break;
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1003c;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        break;
    }



}
#version 450 core
#extension GL_KHR_shader_subgroup_ballot : enable
#extension GL_KHR_shader_subgroup_vote : enable
#extension GL_NV_shader_subgroup_partitioned : enable
#extension GL_EXT_subgroup_uniform_control_flow : enable
layout(local_size_x_id = 0, local_size_y_id = 1, local_size_z = 1) in;
layout(set=0, binding=2) coherent buffer OutputC { uint loc[]; } outputC;
layout(set=0, binding=1) coherent buffer OutputB { uvec4 b[]; } outputB;
layout(set=0, binding=0) coherent buffer InputA  { uint  a[]; } inputA;
layout(push_constant) uniform PC {
   // set to the real stride when writing out ballots, or zero when just counting
   int  invocationStride;
   // wildcard fields, for an example the dimensions of rendered area in the case of graphics shaders
   int  width;
   int  height;
   uint primitiveStride;
   uint subgroupStride;
   uint enableInvocationIndex;
};
int outLoc = 0;
bool testBit(uvec4 mask, uint bit) { return ((mask[bit / 32] >> (bit % 32)) & 1) != 0; }
uint elect() { return int(subgroupElect()) + 1; }
layout(constant_id = 10) const uint cmpIndex0 = 0u;
layout(constant_id = 11) const uint cmpIndex1 = 0u;
layout(constant_id = 12) const uint cmpIndex2 = 0u;
layout(constant_id = 13) const uint cmpIndex3 = 0u;
layout(constant_id = 14) const uint cmpIndex4 = 0u;


void main()
[[subgroup_uniform_control_flow]]
{

    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10001;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        {
            int loopIdx0 = 0;
            do {
                {
                    int loopIdx1 = 0;
                    do {
                        loopIdx1++;
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10005;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                        break;
                        if (inputA.a[0] == 0) {
                        } else {
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000a;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                        }
                    } while (loopIdx1 < inputA.a[4]);
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000e;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                if (gl_SubgroupInvocationID == loopIdx0) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10011;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10014;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    } else {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10017;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    }
                }
                if (subgroupElect()) {
                    break;
                }
                if (inputA.a[0] == 0) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001f;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    for (int loopIdx1 = 0;
                             loopIdx1 < inputA.a[1];
                             loopIdx1++) {
                    }
                } else {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10024;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    switch (loopIdx0) {
                        case 1: {
                            break;
                        }
                        case 2: {
                            break;
                        }
                        default: {
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002c;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                            break;
                        }
                    }
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10031;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                if (testBit(uvec4(0xb0caba39, 0xdcbca1e5, 0x73e934e7, 0x3e8bc839), gl_SubgroupInvocationID)) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10034;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    if (subgroupElect()) {
                    }
                } else {
                    {
                        int loopIdx1 = 0;
                        do {
                            if (subgroupElect()) {
                                outputC.loc[gl_LocalInvocationIndex]++;
                                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1003b;
                                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                                break;
                            }
                            loopIdx1++;
                        } while (true);
                    }
                }
                loopIdx0++;
            } while (true);
        }
        if (inputA.a[3] == 3) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10043;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            for (int loopIdx0 = 0;;loopIdx0++,            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect()) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10046;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                if (subgroupElect()) {
                    break;
                }
                for (int loopIdx1 = 0;
                         loopIdx1 < gl_SubgroupInvocationID + 1;
                         loopIdx1++) {
                }
                break;
            }
        } else {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10050;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10053;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
    } else {
        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex2]) {
            if (inputA.a[2] == 2) {
                if (subgroupElect()) {
                }
                {
                    int loopIdx0 = 0;
                    do {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1005b;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                        if (subgroupElect()) {
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1005e;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                            break;
                        }
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10062;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                        loopIdx0++;
                    } while (true);
                }
            }
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex3]) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10067;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                if (gl_LocalInvocationIndex >= inputA.a[cmpIndex4]) {
                } else {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1006b;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                }
            }
        }
    }



}
#version 450 core
#extension GL_KHR_shader_subgroup_ballot : enable
#extension GL_KHR_shader_subgroup_vote : enable
#extension GL_NV_shader_subgroup_partitioned : enable
#extension GL_EXT_subgroup_uniform_control_flow : enable
layout(local_size_x_id = 0, local_size_y_id = 1, local_size_z = 1) in;
layout(set=0, binding=2) coherent buffer OutputC { uint loc[]; } outputC;
layout(set=0, binding=1) coherent buffer OutputB { uvec4 b[]; } outputB;
layout(set=0, binding=0) coherent buffer InputA  { uint  a[]; } inputA;
layout(push_constant) uniform PC {
   // set to the real stride when writing out ballots, or zero when just counting
   int  invocationStride;
   // wildcard fields, for an example the dimensions of rendered area in the case of graphics shaders
   int  width;
   int  height;
   uint primitiveStride;
   uint subgroupStride;
   uint enableInvocationIndex;
};
int outLoc = 0;
bool testBit(uvec4 mask, uint bit) { return ((mask[bit / 32] >> (bit % 32)) & 1) != 0; }
uint elect() { return int(subgroupElect()) + 1; }
layout(constant_id = 10) const uint cmpIndex0 = 0u;
layout(constant_id = 11) const uint cmpIndex1 = 0u;
layout(constant_id = 12) const uint cmpIndex2 = 0u;
layout(constant_id = 13) const uint cmpIndex3 = 0u;


void main()
[[subgroup_uniform_control_flow]]
{

    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10000;
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
    if (inputA.a[0] == 0) {
        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
            if (testBit(uvec4(0xf77511fe, 0x9ecaa8ed, 0x511db92f, 0x8ad08538), gl_SubgroupInvocationID)) {
                if (subgroupElect()) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10006;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                }
                switch (gl_SubgroupInvocationID & 3) {
                    case 0:
                    {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000b;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                        break;
                    }
                    case 1:
                    {
                        break;
                    }
                    case 2:
                    {
                        break;
                    }
                    case 3:
                    {
                        break;
                    }
                }
            } else {
                for (int loopIdx0 = 0;
                         loopIdx0 < gl_SubgroupInvocationID + 1;
                         loopIdx0++) {
                    if (inputA.a[0] == 12345) {
                        while (true) {
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                        }
                    }
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10019;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                if (subgroupElect()) {
                }
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001e;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        } else {
            if (testBit(uvec4(0xf77511fe, 0x9ecaa8ed, 0x511db92f, 0x8ad08538), gl_SubgroupInvocationID)) {
                if (subgroupElect()) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10006;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                }
                switch (gl_SubgroupInvocationID & 3) {
                    case 0:
                    {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000b;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                        break;
                    }
                    case 1:
                    {
                        break;
                    }
                    case 2:
                    {
                        break;
                    }
                    case 3:
                    {
                        break;
                    }
                }
            } else {
                for (int loopIdx0 = 0;
                         loopIdx0 < gl_SubgroupInvocationID + 1;
                         loopIdx0++) {
                    if (inputA.a[0] == 12345) {
                        while (true) {
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                        }
                    }
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10019;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                if (subgroupElect()) {
                }
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001e;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1003e;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
    } else {
        if (subgroupElect()) {
            switch (inputA.a[3]) {
                case 4:
                {
                    if (subgroupElect()) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10045;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    }
                    break;
                }
                case 3:
                {
                    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1004b;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    } else {
                    }
                    return;
                    break;
                }
                case 5:
                {
                    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex2]) {
                    } else {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10054;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    }
                    break;
                }
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10059;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            for (int loopIdx0 = 0;
                     loopIdx0 < inputA.a[2];
                     loopIdx0++) {
                for (int loopIdx1 = 0;
                         loopIdx1 < gl_SubgroupInvocationID + 1;
                         loopIdx1++) {
                }
                if (inputA.a[3] == 3) {
                }
            }
        }
        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex3]) {
            if (testBit(uvec4(0x9e19d960, 0xdc84f6e8, 0x5cf95d28, 0x1058dec4), gl_SubgroupInvocationID)) {
                if (inputA.a[2] == 2) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10065;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10068;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                switch (gl_SubgroupInvocationID & 3) {
                    case 0:
                    case 1:
                    {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1006c;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                        break;
                    }
                    case 2:
                    case 3:
                    {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10070;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                        break;
                    }
                }
            }
            switch (gl_SubgroupInvocationID & 3) {
                case 0:
                case 1:
                {
                    if (testBit(uvec4(0xf7b3ccb6, 0xa731d3e9, 0xb74d8b76, 0x21cb827a), gl_SubgroupInvocationID)) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10078;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    }
                    break;
                }
                case 2:
                case 3:
                {
                    for (int loopIdx0 = 0;
                             loopIdx0 < inputA.a[4];
                             loopIdx0++) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1007e;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    }
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10081;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    if (inputA.a[0] == 0) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10084;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    }
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10087;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    break;
                }
            }
        }
    }
    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1008d;
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();



}
#version 450 core
#extension GL_KHR_shader_subgroup_ballot : enable
#extension GL_KHR_shader_subgroup_vote : enable
#extension GL_NV_shader_subgroup_partitioned : enable
#extension GL_EXT_subgroup_uniform_control_flow : enable
layout(local_size_x_id = 0, local_size_y_id = 1, local_size_z = 1) in;
layout(set=0, binding=2) coherent buffer OutputC { uint loc[]; } outputC;
layout(set=0, binding=1) coherent buffer OutputB { uvec4 b[]; } outputB;
layout(set=0, binding=0) coherent buffer InputA  { uint  a[]; } inputA;
layout(push_constant) uniform PC {
   // set to the real stride when writing out ballots, or zero when just counting
   int  invocationStride;
   // wildcard fields, for an example the dimensions of rendered area in the case of graphics shaders
   int  width;
   int  height;
   uint primitiveStride;
   uint subgroupStride;
   uint enableInvocationIndex;
};
int outLoc = 0;
bool testBit(uvec4 mask, uint bit) { return ((mask[bit / 32] >> (bit % 32)) & 1) != 0; }
uint elect() { return int(subgroupElect()) + 1; }
layout(constant_id = 10) const uint cmpIndex0 = 0u;
layout(constant_id = 11) const uint cmpIndex1 = 0u;
layout(constant_id = 12) const uint cmpIndex2 = 0u;
layout(constant_id = 13) const uint cmpIndex3 = 0u;
layout(constant_id = 14) const uint cmpIndex4 = 0u;


void main()
[[subgroup_uniform_control_flow]]
{

    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10000;
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
    switch (inputA.a[2]) {
        case 3:
        {
            if (subgroupElect()) {
                {
                    int loopIdx0 = 0;
                    do {
                        loopIdx0++;
                        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
                        }
                        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10009;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                        } else {
                        }
                    } while (loopIdx0 < inputA.a[3]);
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000e;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                {
                    int loopIdx0 = 0;
                    do {
                        if (gl_SubgroupInvocationID == loopIdx0) {
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10012;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                        } else {
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10012;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                        }
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10018;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                        if (subgroupElect()) {
                        }
                        if (subgroupElect()) {
                            break;
                        }
                        if (subgroupElect()) {
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10020;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                        }
                        if (testBit(uvec4(0x47437516, 0xdc8cc7ef, 0x85e228f4, 0xc902798b), gl_SubgroupInvocationID)) {
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10024;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                        } else {
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10027;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                        }
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002a;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                        loopIdx0++;
                    } while (true);
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002d;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            }
            break;
        }
        case 2:
        {
            switch (gl_SubgroupInvocationID & 3) {
                case 0:
                {
                    if (subgroupElect()) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10035;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                        switch (inputA.a[3]) {
                            case 4:
                            {
                                break;
                            }
                            case 3:
                            {
                                break;
                            }
                            case 5:
                            {
                                break;
                            }
                        }
                    }
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10040;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    break;
                }
                case 1:
                {
                    break;
                }
                case 2:
                {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10046;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    if (testBit(uvec4(0xc8626f10, 0x4b547ee1, 0xd59c011f, 0x36238fad), gl_SubgroupInvocationID)) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10049;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                        switch (gl_SubgroupInvocationID & 3) {
                            case 0:
                            case 1:
                            {
                                break;
                            }
                            case 2:
                            case 3:
                            {
                                outputC.loc[gl_LocalInvocationIndex]++;
                                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1004f;
                                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                                break;
                            }
                        }
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10053;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    } else {
                        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex2]) {
                        }
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10058;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    }
                    break;
                }
                case 3:
                {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1005d;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    break;
                }
            }
            {
                int loopIdx0 = 0;
                do {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10062;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    if (subgroupElect()) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10065;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                        break;
                    }
                    if (subgroupElect()) {
                        switch (gl_SubgroupInvocationID & 3) {
                            case 0:
                            case 1:
                            {
                                break;
                            }
                            case 2:
                            case 3:
                            {
                                break;
                            }
                        }
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10070;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                        break;
                    }
                    if (testBit(uvec4(0x2d447467, 0x7ae64289, 0x13784927, 0xf531f510), gl_SubgroupInvocationID)) {
                        if (inputA.a[0] == 0) {
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10076;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                        } else {
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10079;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                        }
                        switch (inputA.a[1]) {
                            case 2:
                            {
                                break;
                            }
                            case 1:
                            {
                                outputC.loc[gl_LocalInvocationIndex]++;
                                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10080;
                                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                                break;
                            }
                            case 3:
                            {
                                break;
                            }
                        }
                    } else {
                        break;
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10088;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                        if (testBit(uvec4(0xc8626f10, 0x4b547ee1, 0xd59c011f, 0x36238fad), gl_SubgroupInvocationID)) {
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1008b;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                        } else {
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1008e;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                        }
                    }
                    loopIdx0++;
                } while (true);
            }
            break;
        }
        case 4:
        {
            if (inputA.a[0] == 0) {
                if (gl_LocalInvocationIndex >= inputA.a[cmpIndex3]) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10097;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    {
                        int loopIdx0 = 0;
                        do {
                            loopIdx0++;
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1009a;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                        } while (loopIdx0 < inputA.a[4]);
                    }
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1009d;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex4]) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x100a0;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    } else {
                    }
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x100a5;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            }
            break;
        }
    }



}
#version 450 core
#extension GL_KHR_shader_subgroup_ballot : enable
#extension GL_KHR_shader_subgroup_vote : enable
#extension GL_NV_shader_subgroup_partitioned : enable
#extension GL_EXT_subgroup_uniform_control_flow : enable
layout(local_size_x_id = 0, local_size_y_id = 1, local_size_z = 1) in;
layout(set=0, binding=2) coherent buffer OutputC { uint loc[]; } outputC;
layout(set=0, binding=1) coherent buffer OutputB { uvec4 b[]; } outputB;
layout(set=0, binding=0) coherent buffer InputA  { uint  a[]; } inputA;
layout(push_constant) uniform PC {
   // set to the real stride when writing out ballots, or zero when just counting
   int  invocationStride;
   // wildcard fields, for an example the dimensions of rendered area in the case of graphics shaders
   int  width;
   int  height;
   uint primitiveStride;
   uint subgroupStride;
   uint enableInvocationIndex;
};
int outLoc = 0;
bool testBit(uvec4 mask, uint bit) { return ((mask[bit / 32] >> (bit % 32)) & 1) != 0; }
uint elect() { return int(subgroupElect()) + 1; }
layout(constant_id = 10) const uint cmpIndex0 = 0u;
layout(constant_id = 11) const uint cmpIndex1 = 0u;
layout(constant_id = 12) const uint cmpIndex2 = 0u;


void main()
[[subgroup_uniform_control_flow]]
{

    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
        if (testBit(uvec4(0x467d6e76, 0x4b45c110, 0xdc26e53e, 0xc4601a6e), gl_SubgroupInvocationID)) {
            for (int loopIdx0 = 0;;loopIdx0++,            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect()) {
                for (int loopIdx1 = 0;
                         loopIdx1 < inputA.a[5];
                         loopIdx1++) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10004;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                }
                switch (loopIdx0) {
                    case 1: {
                        break;
                    }
                    case 2: {
                        break;
                    }
                    default: {
                        break;
                    }
                }
                if (subgroupElect()) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10010;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    break;
                }
                if (subgroupElect()) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10015;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                }
                if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10019;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                } else {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001c;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001f;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            }
        }
    } else {
        if (testBit(uvec4(0x467d6e76, 0x4b45c110, 0xdc26e53e, 0xc4601a6e), gl_SubgroupInvocationID)) {
            for (int loopIdx0 = 0;;loopIdx0++,            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect()) {
                for (int loopIdx1 = 0;
                         loopIdx1 < inputA.a[5];
                         loopIdx1++) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10004;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                }
                switch (loopIdx0) {
                    case 1: {
                        break;
                    }
                    case 2: {
                        break;
                    }
                    default: {
                        break;
                    }
                }
                if (subgroupElect()) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10010;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    break;
                }
                if (subgroupElect()) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10015;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                }
                if (gl_LocalInvocationIndex >= inputA.a[cmpIndex2]) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10019;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                } else {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001c;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001f;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            }
        }
    }



}
#version 450 core
#extension GL_KHR_shader_subgroup_ballot : enable
#extension GL_KHR_shader_subgroup_vote : enable
#extension GL_NV_shader_subgroup_partitioned : enable
#extension GL_EXT_subgroup_uniform_control_flow : enable
layout(local_size_x_id = 0, local_size_y_id = 1, local_size_z = 1) in;
layout(set=0, binding=2) coherent buffer OutputC { uint loc[]; } outputC;
layout(set=0, binding=1) coherent buffer OutputB { uvec4 b[]; } outputB;
layout(set=0, binding=0) coherent buffer InputA  { uint  a[]; } inputA;
layout(push_constant) uniform PC {
   // set to the real stride when writing out ballots, or zero when just counting
   int  invocationStride;
   // wildcard fields, for an example the dimensions of rendered area in the case of graphics shaders
   int  width;
   int  height;
   uint primitiveStride;
   uint subgroupStride;
   uint enableInvocationIndex;
};
int outLoc = 0;
bool testBit(uvec4 mask, uint bit) { return ((mask[bit / 32] >> (bit % 32)) & 1) != 0; }
uint elect() { return int(subgroupElect()) + 1; }
layout(constant_id = 10) const uint cmpIndex0 = 0u;
layout(constant_id = 11) const uint cmpIndex1 = 0u;
layout(constant_id = 12) const uint cmpIndex2 = 0u;


void main()
[[subgroup_uniform_control_flow]]
{

    if (inputA.a[2] == 2) {
        for (int loopIdx0 = 0;
                 loopIdx0 < gl_SubgroupInvocationID + 1;
                 loopIdx0++) {
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10003;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        {
            int loopIdx0 = 0;
            do {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10006;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                if (subgroupElect()) {
                    break;
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000b;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                loopIdx0++;
            } while (true);
        }
    } else {
        for (int loopIdx0 = 0;
                 loopIdx0 < inputA.a[3];
                 loopIdx0++) {
        }
        if (testBit(uvec4(0xcfbc2897, 0xfc76d7d0, 0x3a289c17, 0xb008b37a), gl_SubgroupInvocationID)) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10012;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        } else {
        }
    }
    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10017;
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001b;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        }
        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex2]) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001f;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        }
    }



}
#version 450 core
#extension GL_KHR_shader_subgroup_ballot : enable
#extension GL_KHR_shader_subgroup_vote : enable
#extension GL_NV_shader_subgroup_partitioned : enable
#extension GL_EXT_subgroup_uniform_control_flow : enable
layout(local_size_x_id = 0, local_size_y_id = 1, local_size_z = 1) in;
layout(set=0, binding=2) coherent buffer OutputC { uint loc[]; } outputC;
layout(set=0, binding=1) coherent buffer OutputB { uvec4 b[]; } outputB;
layout(set=0, binding=0) coherent buffer InputA  { uint  a[]; } inputA;
layout(push_constant) uniform PC {
   // set to the real stride when writing out ballots, or zero when just counting
   int  invocationStride;
   // wildcard fields, for an example the dimensions of rendered area in the case of graphics shaders
   int  width;
   int  height;
   uint primitiveStride;
   uint subgroupStride;
   uint enableInvocationIndex;
};
int outLoc = 0;
bool testBit(uvec4 mask, uint bit) { return ((mask[bit / 32] >> (bit % 32)) & 1) != 0; }
uint elect() { return int(subgroupElect()) + 1; }
layout(constant_id = 10) const uint cmpIndex0 = 0u;
layout(constant_id = 11) const uint cmpIndex1 = 0u;


void main()
[[subgroup_uniform_control_flow]]
{

    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10000;
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
    if (testBit(uvec4(0x5e7c62c7, 0x70aa04d5, 0xd5ac6041, 0xab1a9911), gl_SubgroupInvocationID)) {
        if (subgroupElect()) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10004;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        }
    }
    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10008;
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
    if (testBit(uvec4(0x5e7c62c7, 0x70aa04d5, 0xd5ac6041, 0xab1a9911), gl_SubgroupInvocationID)) {
        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000c;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000f;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
    } else {
        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
        } else {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10014;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        }
    }
    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10018;
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
    if (testBit(uvec4(0xca5a5b81, 0x51702d72, 0x4762f0d4, 0xd50571b4), gl_SubgroupInvocationID)) {
        switch (gl_SubgroupInvocationID & 3) {
            case 0:
            {
                break;
            }
            case 1:
            {
                break;
            }
            case 2:
            {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10021;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                break;
            }
            case 3:
            {
                break;
            }
        }
        if (testBit(uvec4(0x5e7c62c7, 0x70aa04d5, 0xd5ac6041, 0xab1a9911), gl_SubgroupInvocationID)) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10028;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        } else {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002b;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        }
    }



}
#version 450 core
#extension GL_KHR_shader_subgroup_ballot : enable
#extension GL_KHR_shader_subgroup_vote : enable
#extension GL_NV_shader_subgroup_partitioned : enable
#extension GL_EXT_subgroup_uniform_control_flow : enable
layout(local_size_x_id = 0, local_size_y_id = 1, local_size_z = 1) in;
layout(set=0, binding=2) coherent buffer OutputC { uint loc[]; } outputC;
layout(set=0, binding=1) coherent buffer OutputB { uvec4 b[]; } outputB;
layout(set=0, binding=0) coherent buffer InputA  { uint  a[]; } inputA;
layout(push_constant) uniform PC {
   // set to the real stride when writing out ballots, or zero when just counting
   int  invocationStride;
   // wildcard fields, for an example the dimensions of rendered area in the case of graphics shaders
   int  width;
   int  height;
   uint primitiveStride;
   uint subgroupStride;
   uint enableInvocationIndex;
};
int outLoc = 0;
bool testBit(uvec4 mask, uint bit) { return ((mask[bit / 32] >> (bit % 32)) & 1) != 0; }
uint elect() { return int(subgroupElect()) + 1; }
layout(constant_id = 10) const uint cmpIndex0 = 0u;


void main()
[[subgroup_uniform_control_flow]]
{

    if (testBit(uvec4(0x579965e, 0xdcab3315, 0xc6e61baa, 0x8b38dac5), gl_SubgroupInvocationID)) {
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10001;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
    } else {
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10004;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        if (inputA.a[1] == 1) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10007;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        } else {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10007;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        }
        if (inputA.a[1] == 1) {
        }
    }
    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10010;
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
    if (subgroupElect()) {
        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10014;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        } else {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10017;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        }
        for (int loopIdx0 = 0;;loopIdx0++,        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true)) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001b;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            if (subgroupElect()) {
                break;
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10020;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10023;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
    }



}
#version 450 core
#extension GL_KHR_shader_subgroup_ballot : enable
#extension GL_KHR_shader_subgroup_vote : enable
#extension GL_NV_shader_subgroup_partitioned : enable
#extension GL_EXT_subgroup_uniform_control_flow : enable
layout(local_size_x_id = 0, local_size_y_id = 1, local_size_z = 1) in;
layout(set=0, binding=2) coherent buffer OutputC { uint loc[]; } outputC;
layout(set=0, binding=1) coherent buffer OutputB { uvec4 b[]; } outputB;
layout(set=0, binding=0) coherent buffer InputA  { uint  a[]; } inputA;
layout(push_constant) uniform PC {
   // set to the real stride when writing out ballots, or zero when just counting
   int  invocationStride;
   // wildcard fields, for an example the dimensions of rendered area in the case of graphics shaders
   int  width;
   int  height;
   uint primitiveStride;
   uint subgroupStride;
   uint enableInvocationIndex;
};
int outLoc = 0;
bool testBit(uvec4 mask, uint bit) { return ((mask[bit / 32] >> (bit % 32)) & 1) != 0; }
uint elect() { return int(subgroupElect()) + 1; }
layout(constant_id = 10) const uint cmpIndex0 = 0u;
layout(constant_id = 11) const uint cmpIndex1 = 0u;


void main()
[[subgroup_uniform_control_flow]]
{

    {
        int loopIdx0 = 0;
        do {
            loopIdx0++;
            return;
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10002;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        } while (loopIdx0 < inputA.a[5]);
    }
    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10006;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        if (testBit(uvec4(0x91b3bcd8, 0x6a4b0e01, 0x2033a7ef, 0xef82cc51), gl_SubgroupInvocationID)) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10009;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000c;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
    }
    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000f;
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
        {
            int loopIdx0 = 0;
            do {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10013;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                if (subgroupElect()) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10016;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    break;
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001a;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                loopIdx0++;
            } while (true);
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001d;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
    } else {
        {
            int loopIdx0 = 0;
            do {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10013;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                if (subgroupElect()) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10016;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    break;
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001a;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                loopIdx0++;
            } while (true);
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001d;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
    }
    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002e;
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);



}
#version 450 core
#extension GL_KHR_shader_subgroup_ballot : enable
#extension GL_KHR_shader_subgroup_vote : enable
#extension GL_NV_shader_subgroup_partitioned : enable
#extension GL_EXT_subgroup_uniform_control_flow : enable
layout(local_size_x_id = 0, local_size_y_id = 1, local_size_z = 1) in;
layout(set=0, binding=2) coherent buffer OutputC { uint loc[]; } outputC;
layout(set=0, binding=1) coherent buffer OutputB { uvec4 b[]; } outputB;
layout(set=0, binding=0) coherent buffer InputA  { uint  a[]; } inputA;
layout(push_constant) uniform PC {
   // set to the real stride when writing out ballots, or zero when just counting
   int  invocationStride;
   // wildcard fields, for an example the dimensions of rendered area in the case of graphics shaders
   int  width;
   int  height;
   uint primitiveStride;
   uint subgroupStride;
   uint enableInvocationIndex;
};
int outLoc = 0;
bool testBit(uvec4 mask, uint bit) { return ((mask[bit / 32] >> (bit % 32)) & 1) != 0; }
uint elect() { return int(subgroupElect()) + 1; }


void main()
[[subgroup_uniform_control_flow]]
{

    for (int loopIdx0 = 0;;loopIdx0++,    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true)) {
        break;
        if (gl_SubgroupInvocationID == loopIdx0) {
        }
        if (subgroupElect()) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10005;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            break;
        }
        if (testBit(uvec4(0x5664d7eb, 0xdcbb511b, 0x9578e94b, 0xd825b137), gl_SubgroupInvocationID)) {
            break;
        } else {
            break;
        }
        if (subgroupElect()) {
        }
    }
    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10011;
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
    for (int loopIdx0 = 0;
             loopIdx0 < gl_SubgroupInvocationID + 1;
             loopIdx0++) {
        if (inputA.a[3] == 3) {
        }
        switch (loopIdx0) {
            case 1: {
                break;
            }
            case 2: {
                break;
            }
            default: {
                break;
            }
        }
    }



}
#version 450 core
#extension GL_KHR_shader_subgroup_ballot : enable
#extension GL_KHR_shader_subgroup_vote : enable
#extension GL_NV_shader_subgroup_partitioned : enable
#extension GL_EXT_subgroup_uniform_control_flow : enable
layout(local_size_x_id = 0, local_size_y_id = 1, local_size_z = 1) in;
layout(set=0, binding=2) coherent buffer OutputC { uint loc[]; } outputC;
layout(set=0, binding=1) coherent buffer OutputB { uvec4 b[]; } outputB;
layout(set=0, binding=0) coherent buffer InputA  { uint  a[]; } inputA;
layout(push_constant) uniform PC {
   // set to the real stride when writing out ballots, or zero when just counting
   int  invocationStride;
   // wildcard fields, for an example the dimensions of rendered area in the case of graphics shaders
   int  width;
   int  height;
   uint primitiveStride;
   uint subgroupStride;
   uint enableInvocationIndex;
};
int outLoc = 0;
bool testBit(uvec4 mask, uint bit) { return ((mask[bit / 32] >> (bit % 32)) & 1) != 0; }
uint elect() { return int(subgroupElect()) + 1; }
layout(constant_id = 10) const uint cmpIndex0 = 0u;


void main()
[[subgroup_uniform_control_flow]]
{

    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10000;
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
        if (subgroupElect()) {
        }
        {
            int loopIdx0 = 0;
            do {
                if (subgroupElect()) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10007;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    break;
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000b;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                loopIdx0++;
            } while (true);
        }
    }
    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000f;
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
    for (int loopIdx0 = 0;;loopIdx0++,    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true)) {
        switch (gl_SubgroupInvocationID & 3) {
            case 0:
            case 1:
            {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10014;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                break;
            }
            case 2:
            case 3:
            {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10018;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                break;
            }
        }
        for (int loopIdx1 = 0;;loopIdx1++,        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true)) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001d;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            if (subgroupElect()) {
                break;
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10022;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        }
        if (subgroupElect()) {
            break;
        }
        if (subgroupElect()) {
        }
        if (gl_SubgroupInvocationID == loopIdx0) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002b;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        } else {
        }
    }



}
#version 450 core
#extension GL_KHR_shader_subgroup_ballot : enable
#extension GL_KHR_shader_subgroup_vote : enable
#extension GL_NV_shader_subgroup_partitioned : enable
#extension GL_EXT_subgroup_uniform_control_flow : enable
layout(local_size_x_id = 0, local_size_y_id = 1, local_size_z = 1) in;
layout(set=0, binding=2) coherent buffer OutputC { uint loc[]; } outputC;
layout(set=0, binding=1) coherent buffer OutputB { uvec4 b[]; } outputB;
layout(set=0, binding=0) coherent buffer InputA  { uint  a[]; } inputA;
layout(push_constant) uniform PC {
   // set to the real stride when writing out ballots, or zero when just counting
   int  invocationStride;
   // wildcard fields, for an example the dimensions of rendered area in the case of graphics shaders
   int  width;
   int  height;
   uint primitiveStride;
   uint subgroupStride;
   uint enableInvocationIndex;
};
int outLoc = 0;
bool testBit(uvec4 mask, uint bit) { return ((mask[bit / 32] >> (bit % 32)) & 1) != 0; }
uint elect() { return int(subgroupElect()) + 1; }
layout(constant_id = 10) const uint cmpIndex0 = 0u;
layout(constant_id = 11) const uint cmpIndex1 = 0u;
layout(constant_id = 12) const uint cmpIndex2 = 0u;
layout(constant_id = 13) const uint cmpIndex3 = 0u;


void main()
[[subgroup_uniform_control_flow]]
{

    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10001;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        {
            int loopIdx0 = 0;
            do {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10004;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                if (subgroupElect()) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10007;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    break;
                }
                loopIdx0++;
            } while (true);
        }
    }
    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000d;
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex2]) {
        } else {
        }
        if (inputA.a[3] == 3) {
        } else {
        }
    } else {
        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex3]) {
        } else {
        }
        if (inputA.a[1] == 1) {
        } else {
        }
    }



}
#version 450 core
#extension GL_KHR_shader_subgroup_ballot : enable
#extension GL_KHR_shader_subgroup_vote : enable
#extension GL_NV_shader_subgroup_partitioned : enable
#extension GL_EXT_subgroup_uniform_control_flow : enable
layout(local_size_x_id = 0, local_size_y_id = 1, local_size_z = 1) in;
layout(set=0, binding=2) coherent buffer OutputC { uint loc[]; } outputC;
layout(set=0, binding=1) coherent buffer OutputB { uvec4 b[]; } outputB;
layout(set=0, binding=0) coherent buffer InputA  { uint  a[]; } inputA;
layout(push_constant) uniform PC {
   // set to the real stride when writing out ballots, or zero when just counting
   int  invocationStride;
   // wildcard fields, for an example the dimensions of rendered area in the case of graphics shaders
   int  width;
   int  height;
   uint primitiveStride;
   uint subgroupStride;
   uint enableInvocationIndex;
};
int outLoc = 0;
bool testBit(uvec4 mask, uint bit) { return ((mask[bit / 32] >> (bit % 32)) & 1) != 0; }
uint elect() { return int(subgroupElect()) + 1; }
layout(constant_id = 10) const uint cmpIndex0 = 0u;
layout(constant_id = 11) const uint cmpIndex1 = 0u;
layout(constant_id = 12) const uint cmpIndex2 = 0u;
layout(constant_id = 13) const uint cmpIndex3 = 0u;
layout(constant_id = 14) const uint cmpIndex4 = 0u;


void main()
[[subgroup_uniform_control_flow]]
{

    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10000;
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
    if (inputA.a[2] == 2) {
        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
        } else {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10005;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        }
        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10009;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        }
    } else {
        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex2]) {
        } else {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000f;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        }
        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex3]) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10013;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        } else {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10016;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        }
    }
    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex4]) {
        switch (gl_SubgroupInvocationID & 3) {
            case 0:
            case 1:
            {
                break;
            }
            case 2:
            case 3:
            {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001f;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                break;
            }
        }
    } else {
        for (int loopIdx0 = 0;;loopIdx0++,        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true)) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10025;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            if (subgroupElect()) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10028;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                break;
            }
        }
    }



}
#version 450 core
#extension GL_KHR_shader_subgroup_ballot : enable
#extension GL_KHR_shader_subgroup_vote : enable
#extension GL_NV_shader_subgroup_partitioned : enable
#extension GL_EXT_subgroup_uniform_control_flow : enable
layout(local_size_x_id = 0, local_size_y_id = 1, local_size_z = 1) in;
layout(set=0, binding=2) coherent buffer OutputC { uint loc[]; } outputC;
layout(set=0, binding=1) coherent buffer OutputB { uvec4 b[]; } outputB;
layout(set=0, binding=0) coherent buffer InputA  { uint  a[]; } inputA;
layout(push_constant) uniform PC {
   // set to the real stride when writing out ballots, or zero when just counting
   int  invocationStride;
   // wildcard fields, for an example the dimensions of rendered area in the case of graphics shaders
   int  width;
   int  height;
   uint primitiveStride;
   uint subgroupStride;
   uint enableInvocationIndex;
};
int outLoc = 0;
bool testBit(uvec4 mask, uint bit) { return ((mask[bit / 32] >> (bit % 32)) & 1) != 0; }
uint elect() { return int(subgroupElect()) + 1; }
layout(constant_id = 10) const uint cmpIndex0 = 0u;
layout(constant_id = 11) const uint cmpIndex1 = 0u;
layout(constant_id = 12) const uint cmpIndex2 = 0u;
layout(constant_id = 13) const uint cmpIndex3 = 0u;


void main()
[[subgroup_uniform_control_flow]]
{

    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10000;
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
    switch (inputA.a[2]) {
        case 3:
        {
            if (subgroupElect()) {
            }
            break;
        }
        case 2:
        {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10008;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            switch (gl_SubgroupInvocationID & 3) {
                case 0:
                case 1:
                {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000c;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    break;
                }
                case 2:
                case 3:
                {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10010;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    break;
                }
            }
            break;
        }
        case 4:
        {
            if (subgroupElect()) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10017;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            }
            break;
        }
    }
    if (testBit(uvec4(0x47437516, 0xdc8cc7ef, 0x85e228f4, 0xc902798b), gl_SubgroupInvocationID)) {
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001d;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10020;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        } else {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10020;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        }
        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
        }
    } else {
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001d;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex2]) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10020;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        } else {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10020;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        }
        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex3]) {
        }
    }



}
#version 450 core
#extension GL_KHR_shader_subgroup_ballot : enable
#extension GL_KHR_shader_subgroup_vote : enable
#extension GL_NV_shader_subgroup_partitioned : enable
#extension GL_EXT_subgroup_uniform_control_flow : enable
layout(local_size_x_id = 0, local_size_y_id = 1, local_size_z = 1) in;
layout(set=0, binding=2) coherent buffer OutputC { uint loc[]; } outputC;
layout(set=0, binding=1) coherent buffer OutputB { uvec4 b[]; } outputB;
layout(set=0, binding=0) coherent buffer InputA  { uint  a[]; } inputA;
layout(push_constant) uniform PC {
   // set to the real stride when writing out ballots, or zero when just counting
   int  invocationStride;
   // wildcard fields, for an example the dimensions of rendered area in the case of graphics shaders
   int  width;
   int  height;
   uint primitiveStride;
   uint subgroupStride;
   uint enableInvocationIndex;
};
int outLoc = 0;
bool testBit(uvec4 mask, uint bit) { return ((mask[bit / 32] >> (bit % 32)) & 1) != 0; }
uint elect() { return int(subgroupElect()) + 1; }
layout(constant_id = 10) const uint cmpIndex0 = 0u;


void main()
[[subgroup_uniform_control_flow]]
{

    if (testBit(uvec4(0x467d6e76, 0x4b45c110, 0xdc26e53e, 0xc4601a6e), gl_SubgroupInvocationID)) {
        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
        }
    } else {
        if (testBit(uvec4(0x467d6e76, 0x4b45c110, 0xdc26e53e, 0xc4601a6e), gl_SubgroupInvocationID)) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10005;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        }
        switch (gl_SubgroupInvocationID & 3) {
            case 0:
            case 1:
            {
                break;
            }
            case 2:
            case 3:
            {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000c;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                break;
            }
        }
    }
    switch (gl_SubgroupInvocationID & 3) {
        case 0:
        case 1:
        {
            switch (gl_SubgroupInvocationID & 3) {
                case 0:
                {
                    break;
                }
                case 1:
                {
                    break;
                }
                case 2:
                {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10019;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    break;
                }
                case 3:
                {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001d;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    break;
                }
            }
            break;
        }
        case 2:
        case 3:
        {
            for (int loopIdx0 = 0;;loopIdx0++,            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true)) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10024;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                if (subgroupElect()) {
                    break;
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10029;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            }
            break;
        }
    }
    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002e;
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);



}
#version 450 core
#extension GL_KHR_shader_subgroup_ballot : enable
#extension GL_KHR_shader_subgroup_vote : enable
#extension GL_NV_shader_subgroup_partitioned : enable
#extension GL_EXT_subgroup_uniform_control_flow : enable
layout(local_size_x_id = 0, local_size_y_id = 1, local_size_z = 1) in;
layout(set=0, binding=2) coherent buffer OutputC { uint loc[]; } outputC;
layout(set=0, binding=1) coherent buffer OutputB { uvec4 b[]; } outputB;
layout(set=0, binding=0) coherent buffer InputA  { uint  a[]; } inputA;
layout(push_constant) uniform PC {
   // set to the real stride when writing out ballots, or zero when just counting
   int  invocationStride;
   // wildcard fields, for an example the dimensions of rendered area in the case of graphics shaders
   int  width;
   int  height;
   uint primitiveStride;
   uint subgroupStride;
   uint enableInvocationIndex;
};
int outLoc = 0;
bool testBit(uvec4 mask, uint bit) { return ((mask[bit / 32] >> (bit % 32)) & 1) != 0; }
uint elect() { return int(subgroupElect()) + 1; }
layout(constant_id = 10) const uint cmpIndex0 = 0u;
layout(constant_id = 11) const uint cmpIndex1 = 0u;


void main()
[[subgroup_uniform_control_flow]]
{

    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10001;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10004;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        } else {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10004;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000a;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
    }
    for (int loopIdx0 = 0;
             loopIdx0 < gl_SubgroupInvocationID + 1;
             loopIdx0++) {
        switch (gl_SubgroupInvocationID & 3) {
            case 0:
            case 1:
            {
                break;
            }
            case 2:
            case 3:
            {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10012;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                break;
            }
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10016;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
    }
    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10019;
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
    if (testBit(uvec4(0xca3d6b2e, 0x914630b3, 0xb676d508, 0x160db633), gl_SubgroupInvocationID)) {
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001c;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        {
            int loopIdx0 = 0;
            do {
                if (subgroupElect()) {
                    break;
                }
                loopIdx0++;
            } while (true);
        }
    } else {
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001c;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        {
            int loopIdx0 = 0;
            do {
                if (subgroupElect()) {
                    break;
                }
                loopIdx0++;
            } while (true);
        }
    }



}
#version 450 core
#extension GL_KHR_shader_subgroup_ballot : enable
#extension GL_KHR_shader_subgroup_vote : enable
#extension GL_NV_shader_subgroup_partitioned : enable
#extension GL_EXT_subgroup_uniform_control_flow : enable
layout(local_size_x_id = 0, local_size_y_id = 1, local_size_z = 1) in;
layout(set=0, binding=2) coherent buffer OutputC { uint loc[]; } outputC;
layout(set=0, binding=1) coherent buffer OutputB { uvec4 b[]; } outputB;
layout(set=0, binding=0) coherent buffer InputA  { uint  a[]; } inputA;
layout(push_constant) uniform PC {
   // set to the real stride when writing out ballots, or zero when just counting
   int  invocationStride;
   // wildcard fields, for an example the dimensions of rendered area in the case of graphics shaders
   int  width;
   int  height;
   uint primitiveStride;
   uint subgroupStride;
   uint enableInvocationIndex;
};
int outLoc = 0;
bool testBit(uvec4 mask, uint bit) { return ((mask[bit / 32] >> (bit % 32)) & 1) != 0; }
uint elect() { return int(subgroupElect()) + 1; }
layout(constant_id = 10) const uint cmpIndex0 = 0u;
layout(constant_id = 11) const uint cmpIndex1 = 0u;


void main()
[[subgroup_uniform_control_flow]]
{

    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
        if (testBit(uvec4(0x467d6e76, 0x4b45c110, 0xdc26e53e, 0xc4601a6e), gl_SubgroupInvocationID)) {
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10003;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        {
            int loopIdx0 = 0;
            do {
                if (subgroupElect()) {
                    break;
                }
                loopIdx0++;
            } while (true);
        }
    }
    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000b;
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
    if (testBit(uvec4(0x46e97b9d, 0xf7a119c6, 0xb4d59165, 0xb0864334), gl_SubgroupInvocationID)) {
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000e;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        if (testBit(uvec4(0xca3d6b2e, 0x914630b3, 0xb676d508, 0x160db633), gl_SubgroupInvocationID)) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10011;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        }
        for (int loopIdx0 = 0;
                 loopIdx0 < inputA.a[1];
                 loopIdx0++) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10015;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        }
    }
    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10019;
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
        switch (gl_SubgroupInvocationID & 3) {
            case 0:
            {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001e;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                break;
            }
            case 1:
            {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10022;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                break;
            }
            case 2:
            {
                break;
            }
            case 3:
            {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10028;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                break;
            }
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002c;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
    } else {
        switch (gl_SubgroupInvocationID & 3) {
            case 0:
            case 1:
            {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10031;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                break;
            }
            case 2:
            case 3:
            {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10035;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                break;
            }
        }
    }
    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1003a;
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);



}
#version 450 core
#extension GL_KHR_shader_subgroup_ballot : enable
#extension GL_KHR_shader_subgroup_vote : enable
#extension GL_NV_shader_subgroup_partitioned : enable
#extension GL_EXT_subgroup_uniform_control_flow : enable
layout(local_size_x_id = 0, local_size_y_id = 1, local_size_z = 1) in;
layout(set=0, binding=2) coherent buffer OutputC { uint loc[]; } outputC;
layout(set=0, binding=1) coherent buffer OutputB { uvec4 b[]; } outputB;
layout(set=0, binding=0) coherent buffer InputA  { uint  a[]; } inputA;
layout(push_constant) uniform PC {
   // set to the real stride when writing out ballots, or zero when just counting
   int  invocationStride;
   // wildcard fields, for an example the dimensions of rendered area in the case of graphics shaders
   int  width;
   int  height;
   uint primitiveStride;
   uint subgroupStride;
   uint enableInvocationIndex;
};
int outLoc = 0;
bool testBit(uvec4 mask, uint bit) { return ((mask[bit / 32] >> (bit % 32)) & 1) != 0; }
uint elect() { return int(subgroupElect()) + 1; }


void main()
[[subgroup_uniform_control_flow]]
{

    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10000;
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
    if (testBit(uvec4(0x5e7c62c7, 0x70aa04d5, 0xd5ac6041, 0xab1a9911), gl_SubgroupInvocationID)) {
        if (subgroupElect()) {
            if (testBit(uvec4(0x5e7c62c7, 0x70aa04d5, 0xd5ac6041, 0xab1a9911), gl_SubgroupInvocationID)) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10005;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            } else {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10008;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000b;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        }
        if (inputA.a[1] == 1) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000f;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            for (int loopIdx0 = 0;;loopIdx0++,            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true)) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10012;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                if (subgroupElect()) {
                    break;
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10017;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001a;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            if (subgroupElect()) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001d;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            }
        } else {
            switch (gl_SubgroupInvocationID & 3) {
                case 0:
                case 1:
                {
                    break;
                }
                case 2:
                case 3:
                {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10025;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    break;
                }
            }
            if (subgroupElect()) {
            }
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002c;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
    } else {
        if (subgroupElect()) {
            if (subgroupElect()) {
            }
            if (inputA.a[1] == 1) {
            }
        }
    }



}
#version 450 core
#extension GL_KHR_shader_subgroup_ballot : enable
#extension GL_KHR_shader_subgroup_vote : enable
#extension GL_NV_shader_subgroup_partitioned : enable
#extension GL_EXT_subgroup_uniform_control_flow : enable
layout(local_size_x_id = 0, local_size_y_id = 1, local_size_z = 1) in;
layout(set=0, binding=2) coherent buffer OutputC { uint loc[]; } outputC;
layout(set=0, binding=1) coherent buffer OutputB { uvec4 b[]; } outputB;
layout(set=0, binding=0) coherent buffer InputA  { uint  a[]; } inputA;
layout(push_constant) uniform PC {
   // set to the real stride when writing out ballots, or zero when just counting
   int  invocationStride;
   // wildcard fields, for an example the dimensions of rendered area in the case of graphics shaders
   int  width;
   int  height;
   uint primitiveStride;
   uint subgroupStride;
   uint enableInvocationIndex;
};
int outLoc = 0;
bool testBit(uvec4 mask, uint bit) { return ((mask[bit / 32] >> (bit % 32)) & 1) != 0; }
uint elect() { return int(subgroupElect()) + 1; }
layout(constant_id = 10) const uint cmpIndex0 = 0u;
layout(constant_id = 11) const uint cmpIndex1 = 0u;


void main()
[[subgroup_uniform_control_flow]]
{

    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
        switch (gl_SubgroupInvocationID & 3) {
            case 0:
            case 1:
            {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10003;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                if (inputA.a[1] == 1) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10006;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                } else {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10009;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
                break;
            }
            case 2:
            case 3:
            {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000e;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10011;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
                break;
            }
        }
    } else {
        {
            int loopIdx0 = 0;
            do {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10018;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                {
                    int loopIdx1 = 0;
                    do {
                        loopIdx1++;
                    } while (loopIdx1 < inputA.a[1]);
                }
                if (inputA.a[3] == 3) {
                }
                if (subgroupElect()) {
                    break;
                }
                if (testBit(uvec4(0x812c43cc, 0x2f392383, 0xd1212f39, 0x629a3975), gl_SubgroupInvocationID)) {
                } else {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10023;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
                switch (gl_SubgroupInvocationID & 3) {
                    case 0:
                    {
                        break;
                    }
                    case 1:
                    {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002a;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        break;
                    }
                    case 2:
                    {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002e;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        break;
                    }
                    case 3:
                    {
                        break;
                    }
                }
                loopIdx0++;
            } while (true);
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10035;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
    }
    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10038;
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);



}
#version 450 core
#extension GL_KHR_shader_subgroup_ballot : enable
#extension GL_KHR_shader_subgroup_vote : enable
#extension GL_NV_shader_subgroup_partitioned : enable
#extension GL_EXT_subgroup_uniform_control_flow : enable
layout(local_size_x_id = 0, local_size_y_id = 1, local_size_z = 1) in;
layout(set=0, binding=2) coherent buffer OutputC { uint loc[]; } outputC;
layout(set=0, binding=1) coherent buffer OutputB { uvec4 b[]; } outputB;
layout(set=0, binding=0) coherent buffer InputA  { uint  a[]; } inputA;
layout(push_constant) uniform PC {
   // set to the real stride when writing out ballots, or zero when just counting
   int  invocationStride;
   // wildcard fields, for an example the dimensions of rendered area in the case of graphics shaders
   int  width;
   int  height;
   uint primitiveStride;
   uint subgroupStride;
   uint enableInvocationIndex;
};
int outLoc = 0;
bool testBit(uvec4 mask, uint bit) { return ((mask[bit / 32] >> (bit % 32)) & 1) != 0; }
uint elect() { return int(subgroupElect()) + 1; }
layout(constant_id = 10) const uint cmpIndex0 = 0u;
layout(constant_id = 11) const uint cmpIndex1 = 0u;
layout(constant_id = 12) const uint cmpIndex2 = 0u;
layout(constant_id = 13) const uint cmpIndex3 = 0u;


void main()
[[subgroup_uniform_control_flow]]
{

    {
        int loopIdx0 = 0;
        do {
            loopIdx0++;
            return;
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10002;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        } while (loopIdx0 < inputA.a[5]);
    }
    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10006;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        if (testBit(uvec4(0x91b3bcd8, 0x6a4b0e01, 0x2033a7ef, 0xef82cc51), gl_SubgroupInvocationID)) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10009;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000c;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            } else {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000c;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10012;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        } else {
            switch (gl_SubgroupInvocationID & 3) {
                case 0:
                case 1:
                {
                    break;
                }
                case 2:
                case 3:
                {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10019;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    break;
                }
            }
            if (inputA.a[2] == 2) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001e;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            } else {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10021;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            }
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10025;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        switch (gl_SubgroupInvocationID & 3) {
            case 0:
            case 1:
            {
                if (gl_LocalInvocationIndex >= inputA.a[cmpIndex2]) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002a;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002d;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                {
                    int loopIdx0 = 0;
                    do {
                        if (subgroupElect()) {
                            break;
                        }
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10033;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        loopIdx0++;
                    } while (true);
                }
                break;
            }
            case 2:
            case 3:
            {
                if (gl_LocalInvocationIndex >= inputA.a[cmpIndex3]) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10039;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                } else {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1003c;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
                {
                    int loopIdx0 = 0;
                    do {
                        if (subgroupElect()) {
                            break;
                        }
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10043;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        loopIdx0++;
                    } while (true);
                }
                break;
            }
        }
    }



}
#version 450 core
#extension GL_KHR_shader_subgroup_ballot : enable
#extension GL_KHR_shader_subgroup_vote : enable
#extension GL_NV_shader_subgroup_partitioned : enable
#extension GL_EXT_subgroup_uniform_control_flow : enable
layout(local_size_x_id = 0, local_size_y_id = 1, local_size_z = 1) in;
layout(set=0, binding=2) coherent buffer OutputC { uint loc[]; } outputC;
layout(set=0, binding=1) coherent buffer OutputB { uvec4 b[]; } outputB;
layout(set=0, binding=0) coherent buffer InputA  { uint  a[]; } inputA;
layout(push_constant) uniform PC {
   // set to the real stride when writing out ballots, or zero when just counting
   int  invocationStride;
   // wildcard fields, for an example the dimensions of rendered area in the case of graphics shaders
   int  width;
   int  height;
   uint primitiveStride;
   uint subgroupStride;
   uint enableInvocationIndex;
};
int outLoc = 0;
bool testBit(uvec4 mask, uint bit) { return ((mask[bit / 32] >> (bit % 32)) & 1) != 0; }
uint elect() { return int(subgroupElect()) + 1; }
layout(constant_id = 10) const uint cmpIndex0 = 0u;
layout(constant_id = 11) const uint cmpIndex1 = 0u;


void main()
[[subgroup_uniform_control_flow]]
{

    for (int loopIdx0 = 0;;loopIdx0++,    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true)) {
        break;
        if (gl_SubgroupInvocationID == loopIdx0) {
            if (inputA.a[3] == 3) {
            } else {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10005;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            }
            if (gl_SubgroupInvocationID == loopIdx0) {
            } else {
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000b;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        } else {
            break;
        }
        if (subgroupElect()) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10011;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            break;
        }
        if (gl_SubgroupInvocationID == loopIdx0) {
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
            }
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10019;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            } else {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001c;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001f;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        } else {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10022;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            if (testBit(uvec4(0x9b54ecd6, 0x8188af72, 0xf3e714de, 0x4343808e), gl_SubgroupInvocationID)) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10025;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            } else {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10025;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002b;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            switch (gl_SubgroupInvocationID & 3) {
                case 0:
                case 1:
                {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002f;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    break;
                }
                case 2:
                case 3:
                {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10033;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    break;
                }
            }
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10038;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        switch (gl_SubgroupInvocationID & 3) {
            case 0:
            {
                switch (gl_SubgroupInvocationID & 3) {
                    case 0:
                    case 1:
                    {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1003e;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        break;
                    }
                    case 2:
                    case 3:
                    {
                        break;
                    }
                }
                break;
            }
            case 1:
            {
                if (testBit(uvec4(0x9b54ecd6, 0x8188af72, 0xf3e714de, 0x4343808e), gl_SubgroupInvocationID)) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10047;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1004a;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                break;
            }
            case 2:
            {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1004e;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                if (subgroupElect()) {
                }
                break;
            }
            case 3:
            {
                for (int loopIdx1 = 0;
                         loopIdx1 < inputA.a[3];
                         loopIdx1++) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10055;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
                break;
            }
        }
    }



}
#version 450 core
#extension GL_KHR_shader_subgroup_ballot : enable
#extension GL_KHR_shader_subgroup_vote : enable
#extension GL_NV_shader_subgroup_partitioned : enable
#extension GL_EXT_subgroup_uniform_control_flow : enable
layout(local_size_x_id = 0, local_size_y_id = 1, local_size_z = 1) in;
layout(set=0, binding=2) coherent buffer OutputC { uint loc[]; } outputC;
layout(set=0, binding=1) coherent buffer OutputB { uvec4 b[]; } outputB;
layout(set=0, binding=0) coherent buffer InputA  { uint  a[]; } inputA;
layout(push_constant) uniform PC {
   // set to the real stride when writing out ballots, or zero when just counting
   int  invocationStride;
   // wildcard fields, for an example the dimensions of rendered area in the case of graphics shaders
   int  width;
   int  height;
   uint primitiveStride;
   uint subgroupStride;
   uint enableInvocationIndex;
};
int outLoc = 0;
bool testBit(uvec4 mask, uint bit) { return ((mask[bit / 32] >> (bit % 32)) & 1) != 0; }
uint elect() { return int(subgroupElect()) + 1; }
layout(constant_id = 10) const uint cmpIndex0 = 0u;
layout(constant_id = 11) const uint cmpIndex1 = 0u;


void main()
[[subgroup_uniform_control_flow]]
{

    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10001;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        {
            int loopIdx0 = 0;
            do {
                {
                    int loopIdx1 = 0;
                    do {
                        loopIdx1++;
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10005;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    } while (loopIdx1 < inputA.a[4]);
                }
                if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10009;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                } else {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000c;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
                if (subgroupElect()) {
                    break;
                }
                if (inputA.a[3] == 3) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10013;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                } else {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10016;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10019;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                switch (gl_SubgroupInvocationID & 3) {
                    case 0:
                    {
                        break;
                    }
                    case 1:
                    {
                        break;
                    }
                    case 2:
                    {
                        break;
                    }
                    case 3:
                    {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10023;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        break;
                    }
                }
                loopIdx0++;
            } while (true);
        }
        {
            int loopIdx0 = 0;
            do {
                loopIdx0++;
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10029;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                switch (gl_SubgroupInvocationID & 3) {
                    case 0:
                    case 1:
                    {
                        break;
                    }
                    case 2:
                    case 3:
                    {
                        break;
                    }
                }
                switch (gl_SubgroupInvocationID & 3) {
                    case 0:
                    case 1:
                    {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10033;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        break;
                    }
                    case 2:
                    case 3:
                    {
                        break;
                    }
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10039;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            } while (loopIdx0 < inputA.a[4]);
        }
    }



}
#version 450 core
#extension GL_KHR_shader_subgroup_ballot : enable
#extension GL_KHR_shader_subgroup_vote : enable
#extension GL_NV_shader_subgroup_partitioned : enable
#extension GL_EXT_subgroup_uniform_control_flow : enable
layout(local_size_x_id = 0, local_size_y_id = 1, local_size_z = 1) in;
layout(set=0, binding=2) coherent buffer OutputC { uint loc[]; } outputC;
layout(set=0, binding=1) coherent buffer OutputB { uvec4 b[]; } outputB;
layout(set=0, binding=0) coherent buffer InputA  { uint  a[]; } inputA;
layout(push_constant) uniform PC {
   // set to the real stride when writing out ballots, or zero when just counting
   int  invocationStride;
   // wildcard fields, for an example the dimensions of rendered area in the case of graphics shaders
   int  width;
   int  height;
   uint primitiveStride;
   uint subgroupStride;
   uint enableInvocationIndex;
};
int outLoc = 0;
bool testBit(uvec4 mask, uint bit) { return ((mask[bit / 32] >> (bit % 32)) & 1) != 0; }
uint elect() { return int(subgroupElect()) + 1; }
layout(constant_id = 10) const uint cmpIndex0 = 0u;
layout(constant_id = 11) const uint cmpIndex1 = 0u;
layout(constant_id = 12) const uint cmpIndex2 = 0u;
layout(constant_id = 13) const uint cmpIndex3 = 0u;


void main()
[[subgroup_uniform_control_flow]]
{

    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10000;
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
    if (inputA.a[0] == 0) {
        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
            if (testBit(uvec4(0xf77511fe, 0x9ecaa8ed, 0x511db92f, 0x8ad08538), gl_SubgroupInvocationID)) {
            } else {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10006;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10009;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            {
                int loopIdx0 = 0;
                do {
                    if (subgroupElect()) {
                        break;
                    }
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000f;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    loopIdx0++;
                } while (true);
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10012;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10015;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        if (subgroupElect()) {
            if (subgroupElect()) {
            }
        }
    } else {
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001c;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        if (testBit(uvec4(0x9e19d960, 0xdc84f6e8, 0x5cf95d28, 0x1058dec4), gl_SubgroupInvocationID)) {
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10020;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            } else {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10020;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10026;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex2]) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10029;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            } else {
            }
        } else {
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex3]) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002f;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10032;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            switch (gl_SubgroupInvocationID & 3) {
                case 0:
                case 1:
                {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10036;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    break;
                }
                case 2:
                case 3:
                {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1003a;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    break;
                }
            }
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1003f;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        for (int loopIdx0 = 0;
                 loopIdx0 < inputA.a[2];
                 loopIdx0++) {
            for (int loopIdx1 = 0;
                     loopIdx1 < gl_SubgroupInvocationID + 1;
                     loopIdx1++) {
            }
            if (inputA.a[0] == 0) {
            }
        }
    }



}
#version 450 core
#extension GL_KHR_shader_subgroup_ballot : enable
#extension GL_KHR_shader_subgroup_vote : enable
#extension GL_NV_shader_subgroup_partitioned : enable
#extension GL_EXT_subgroup_uniform_control_flow : enable
layout(local_size_x_id = 0, local_size_y_id = 1, local_size_z = 1) in;
layout(set=0, binding=2) coherent buffer OutputC { uint loc[]; } outputC;
layout(set=0, binding=1) coherent buffer OutputB { uvec4 b[]; } outputB;
layout(set=0, binding=0) coherent buffer InputA  { uint  a[]; } inputA;
layout(push_constant) uniform PC {
   // set to the real stride when writing out ballots, or zero when just counting
   int  invocationStride;
   // wildcard fields, for an example the dimensions of rendered area in the case of graphics shaders
   int  width;
   int  height;
   uint primitiveStride;
   uint subgroupStride;
   uint enableInvocationIndex;
};
int outLoc = 0;
bool testBit(uvec4 mask, uint bit) { return ((mask[bit / 32] >> (bit % 32)) & 1) != 0; }
uint elect() { return int(subgroupElect()) + 1; }
layout(constant_id = 10) const uint cmpIndex0 = 0u;
layout(constant_id = 11) const uint cmpIndex1 = 0u;
layout(constant_id = 12) const uint cmpIndex2 = 0u;
layout(constant_id = 13) const uint cmpIndex3 = 0u;


void main()
[[subgroup_uniform_control_flow]]
{

    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10000;
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
    switch (inputA.a[2]) {
        case 3:
        {
            if (subgroupElect()) {
                {
                    int loopIdx0 = 0;
                    do {
                        loopIdx0++;
                    } while (loopIdx0 < inputA.a[3]);
                }
                if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10008;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                } else {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10008;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000f;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            break;
        }
        case 2:
        {
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
                if (inputA.a[3] == 3) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10015;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                } else {
                }
                if (gl_LocalInvocationIndex >= inputA.a[cmpIndex2]) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001a;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
            }
            if (testBit(uvec4(0xe6163c7e, 0x3dd7ce3b, 0xf9c3ed9c, 0xcc6299f6), gl_SubgroupInvocationID)) {
                if (gl_LocalInvocationIndex >= inputA.a[cmpIndex3]) {
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10021;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10024;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            break;
        }
        case 4:
        {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10028;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            if (subgroupElect()) {
                {
                    int loopIdx0 = 0;
                    do {
                        loopIdx0++;
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002c;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    } while (loopIdx0 < inputA.a[1]);
                }
            }
            break;
        }
    }



}
#version 450 core
#extension GL_KHR_shader_subgroup_ballot : enable
#extension GL_KHR_shader_subgroup_vote : enable
#extension GL_NV_shader_subgroup_partitioned : enable
#extension GL_EXT_subgroup_uniform_control_flow : enable
layout(local_size_x_id = 0, local_size_y_id = 1, local_size_z = 1) in;
layout(set=0, binding=2) coherent buffer OutputC { uint loc[]; } outputC;
layout(set=0, binding=1) coherent buffer OutputB { uvec4 b[]; } outputB;
layout(set=0, binding=0) coherent buffer InputA  { uint  a[]; } inputA;
layout(push_constant) uniform PC {
   // set to the real stride when writing out ballots, or zero when just counting
   int  invocationStride;
   // wildcard fields, for an example the dimensions of rendered area in the case of graphics shaders
   int  width;
   int  height;
   uint primitiveStride;
   uint subgroupStride;
   uint enableInvocationIndex;
};
int outLoc = 0;
bool testBit(uvec4 mask, uint bit) { return ((mask[bit / 32] >> (bit % 32)) & 1) != 0; }
uint elect() { return int(subgroupElect()) + 1; }
layout(constant_id = 10) const uint cmpIndex0 = 0u;
layout(constant_id = 11) const uint cmpIndex1 = 0u;


void main()
[[subgroup_uniform_control_flow]]
{

    if (testBit(uvec4(0x3750d52a, 0x1615a8dd, 0x4c4903d2, 0x4c9741dd), gl_SubgroupInvocationID)) {
        return;
        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10003;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10006;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
    } else {
        if (testBit(uvec4(0xca3d6b2e, 0x914630b3, 0xb676d508, 0x160db633), gl_SubgroupInvocationID)) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000a;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            {
                int loopIdx0 = 0;
                do {
                    if (subgroupElect()) {
                        break;
                    }
                    loopIdx0++;
                } while (true);
            }
        } else {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000a;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            {
                int loopIdx0 = 0;
                do {
                    if (subgroupElect()) {
                        break;
                    }
                    loopIdx0++;
                } while (true);
            }
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001a;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
    }
    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
        if (subgroupElect()) {
            if (inputA.a[1] == 1) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10020;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            } else {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10020;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            }
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10027;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
    } else {
        if (subgroupElect()) {
            if (inputA.a[0] == 0) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10020;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            } else {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10020;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            }
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10027;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
    }
    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10036;
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);



}
#version 450 core
#extension GL_KHR_shader_subgroup_ballot : enable
#extension GL_KHR_shader_subgroup_vote : enable
#extension GL_NV_shader_subgroup_partitioned : enable
#extension GL_EXT_subgroup_uniform_control_flow : enable
layout(local_size_x_id = 0, local_size_y_id = 1, local_size_z = 1) in;
layout(set=0, binding=2) coherent buffer OutputC { uint loc[]; } outputC;
layout(set=0, binding=1) coherent buffer OutputB { uvec4 b[]; } outputB;
layout(set=0, binding=0) coherent buffer InputA  { uint  a[]; } inputA;
layout(push_constant) uniform PC {
   // set to the real stride when writing out ballots, or zero when just counting
   int  invocationStride;
   // wildcard fields, for an example the dimensions of rendered area in the case of graphics shaders
   int  width;
   int  height;
   uint primitiveStride;
   uint subgroupStride;
   uint enableInvocationIndex;
};
int outLoc = 0;
bool testBit(uvec4 mask, uint bit) { return ((mask[bit / 32] >> (bit % 32)) & 1) != 0; }
uint elect() { return int(subgroupElect()) + 1; }


void main()
[[subgroup_uniform_control_flow]]
{

    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10000;
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
    if (testBit(uvec4(0x5e7c62c7, 0x70aa04d5, 0xd5ac6041, 0xab1a9911), gl_SubgroupInvocationID)) {
        if (subgroupElect()) {
            if (testBit(uvec4(0x5e7c62c7, 0x70aa04d5, 0xd5ac6041, 0xab1a9911), gl_SubgroupInvocationID)) {
                for (int loopIdx0 = 0;
                         loopIdx0 < inputA.a[1];
                         loopIdx0++) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10006;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10009;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                {
                    int loopIdx0 = 0;
                    do {
                        loopIdx0++;
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000c;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    } while (loopIdx0 < inputA.a[3]);
                }
            } else {
                {
                    int loopIdx0 = 0;
                    do {
                        loopIdx0++;
                    } while (loopIdx0 < inputA.a[2]);
                }
                switch (gl_SubgroupInvocationID & 3) {
                    case 0:
                    {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10014;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        break;
                    }
                    case 1:
                    {
                        break;
                    }
                    case 2:
                    {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001a;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        break;
                    }
                    case 3:
                    {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001e;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        break;
                    }
                }
            }
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10024;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
    }
    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10027;
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);



}
#version 450 core
#extension GL_KHR_shader_subgroup_ballot : enable
#extension GL_KHR_shader_subgroup_vote : enable
#extension GL_NV_shader_subgroup_partitioned : enable
#extension GL_EXT_subgroup_uniform_control_flow : enable
layout(local_size_x_id = 0, local_size_y_id = 1, local_size_z = 1) in;
layout(set=0, binding=2) coherent buffer OutputC { uint loc[]; } outputC;
layout(set=0, binding=1) coherent buffer OutputB { uvec4 b[]; } outputB;
layout(set=0, binding=0) coherent buffer InputA  { uint  a[]; } inputA;
layout(push_constant) uniform PC {
   // set to the real stride when writing out ballots, or zero when just counting
   int  invocationStride;
   // wildcard fields, for an example the dimensions of rendered area in the case of graphics shaders
   int  width;
   int  height;
   uint primitiveStride;
   uint subgroupStride;
   uint enableInvocationIndex;
};
int outLoc = 0;
bool testBit(uvec4 mask, uint bit) { return ((mask[bit / 32] >> (bit % 32)) & 1) != 0; }
uint elect() { return int(subgroupElect()) + 1; }
layout(constant_id = 10) const uint cmpIndex0 = 0u;
layout(constant_id = 11) const uint cmpIndex1 = 0u;
layout(constant_id = 12) const uint cmpIndex2 = 0u;
layout(constant_id = 13) const uint cmpIndex3 = 0u;
layout(constant_id = 14) const uint cmpIndex4 = 0u;
layout(constant_id = 15) const uint cmpIndex5 = 0u;
layout(constant_id = 16) const uint cmpIndex6 = 0u;


void main()
[[subgroup_uniform_control_flow]]
{

    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
        switch (gl_SubgroupInvocationID & 3) {
            case 0:
            case 1:
            {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10003;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                if (inputA.a[2] == 2) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10006;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    if (testBit(uvec4(0xd4333cb6, 0x37e22ba5, 0xbf5155f0, 0x67d1e6d4), gl_SubgroupInvocationID)) {
                    }
                    if (inputA.a[0] == 0) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000b;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    } else {
                    }
                }
                break;
            }
            case 2:
            case 3:
            {
                if (inputA.a[3] == 3) {
                    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10014;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    } else {
                    }
                    if (subgroupElect()) {
                    }
                } else {
                    if (testBit(uvec4(0xd4333cb6, 0x37e22ba5, 0xbf5155f0, 0x67d1e6d4), gl_SubgroupInvocationID)) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001c;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    } else {
                    }
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10020;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    if (subgroupElect()) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10023;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    }
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10026;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
                for (int loopIdx0 = 0;;loopIdx0++,                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true)) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002a;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    break;
                    if (subgroupElect()) {
                        while (!subgroupElect()) {}
                        if (testBit(uvec4(0x579965e, 0xdcab3315, 0xc6e61baa, 0x8b38dac5), gl_SubgroupInvocationID)) {
                            break;
                        } else {
                            break;
                        }
                    }
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10035;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    if (subgroupElect()) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10038;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    }
                    if (gl_SubgroupInvocationID == loopIdx0) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1003c;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    }
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10040;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                break;
            }
        }
    } else {
        {
            int loopIdx0 = 0;
            do {
                switch (gl_SubgroupInvocationID & 3) {
                    case 0:
                    {
                        if (testBit(uvec4(0xd4333cb6, 0x37e22ba5, 0xbf5155f0, 0x67d1e6d4), gl_SubgroupInvocationID)) {
                        }
                        break;
                    }
                    case 1:
                    {
                        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex2]) {
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1004d;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        } else {
                        }
                        break;
                    }
                    case 2:
                    {
                        {
                            int loopIdx1 = 0;
                            do {
                                outputC.loc[gl_LocalInvocationIndex]++;
                                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10054;
                                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                                if (subgroupElect()) {
                                    outputC.loc[gl_LocalInvocationIndex]++;
                                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10057;
                                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                                    break;
                                }
                                outputC.loc[gl_LocalInvocationIndex]++;
                                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1005b;
                                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                                loopIdx1++;
                            } while (true);
                        }
                        break;
                    }
                    case 3:
                    {
                        switch (inputA.a[3]) {
                            case 4:
                            {
                                break;
                            }
                            case 3:
                            {
                                outputC.loc[gl_LocalInvocationIndex]++;
                                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10064;
                                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                                break;
                            }
                            case 5:
                            {
                                outputC.loc[gl_LocalInvocationIndex]++;
                                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10068;
                                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                                break;
                            }
                        }
                        break;
                    }
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1006e;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                if (gl_LocalInvocationIndex >= inputA.a[cmpIndex3]) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10071;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex4]) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10074;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    } else {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10077;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    }
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1007a;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    if (gl_SubgroupInvocationID == loopIdx0) {
                    }
                }
                if (subgroupElect()) {
                    break;
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10082;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                if (testBit(uvec4(0xedc86e76, 0xf7f5097c, 0x70d87a0d, 0xa26827a3), gl_SubgroupInvocationID)) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10085;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    {
                        int loopIdx1 = 0;
                        do {
                            loopIdx1++;
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10088;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        } while (loopIdx1 < inputA.a[1]);
                    }
                    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex5]) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1008c;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    }
                }
                loopIdx0++;
            } while (true);
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10091;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        for (int loopIdx0 = 0;;loopIdx0++,        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true)) {
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex6]) {
                {
                    int loopIdx1 = 0;
                    do {
                        loopIdx1++;
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10096;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    } while (loopIdx1 < inputA.a[2]);
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10099;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                {
                    int loopIdx1 = 0;
                    do {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1009c;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        if (subgroupElect()) {
                            break;
                        }
                        loopIdx1++;
                    } while (true);
                }
            }
            if (subgroupElect()) {
                for (int loopIdx1 = 0;
                         loopIdx1 < gl_SubgroupInvocationID + 1;
                         loopIdx1++) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x100a5;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
                break;
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x100a9;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            }
            if (subgroupElect()) {
                break;
            }
            switch (gl_SubgroupInvocationID & 3) {
                case 0:
                {
                    if (gl_SubgroupInvocationID == loopIdx0) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x100b2;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    }
                    break;
                }
                case 1:
                {
                    switch (loopIdx0) {
                        case 1: {
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x100b9;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                            break;
                        }
                        case 2: {
                            break;
                        }
                        default: {
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x100bf;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                            break;
                        }
                    }
                    break;
                }
                case 2:
                {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x100c5;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    if (inputA.a[0] == 0) {
                    }
                    break;
                }
                case 3:
                {
                    if (testBit(uvec4(0x812c43cc, 0x2f392383, 0xd1212f39, 0x629a3975), gl_SubgroupInvocationID)) {
                    }
                    break;
                }
            }
        }
    }



}
#version 450 core
#extension GL_KHR_shader_subgroup_ballot : enable
#extension GL_KHR_shader_subgroup_vote : enable
#extension GL_NV_shader_subgroup_partitioned : enable
#extension GL_EXT_subgroup_uniform_control_flow : enable
layout(local_size_x_id = 0, local_size_y_id = 1, local_size_z = 1) in;
layout(set=0, binding=2) coherent buffer OutputC { uint loc[]; } outputC;
layout(set=0, binding=1) coherent buffer OutputB { uvec4 b[]; } outputB;
layout(set=0, binding=0) coherent buffer InputA  { uint  a[]; } inputA;
layout(push_constant) uniform PC {
   // set to the real stride when writing out ballots, or zero when just counting
   int  invocationStride;
   // wildcard fields, for an example the dimensions of rendered area in the case of graphics shaders
   int  width;
   int  height;
   uint primitiveStride;
   uint subgroupStride;
   uint enableInvocationIndex;
};
int outLoc = 0;
bool testBit(uvec4 mask, uint bit) { return ((mask[bit / 32] >> (bit % 32)) & 1) != 0; }
uint elect() { return int(subgroupElect()) + 1; }
layout(constant_id = 10) const uint cmpIndex0 = 0u;
layout(constant_id = 11) const uint cmpIndex1 = 0u;
layout(constant_id = 12) const uint cmpIndex2 = 0u;
layout(constant_id = 13) const uint cmpIndex3 = 0u;
layout(constant_id = 14) const uint cmpIndex4 = 0u;
layout(constant_id = 15) const uint cmpIndex5 = 0u;
layout(constant_id = 16) const uint cmpIndex6 = 0u;
layout(constant_id = 17) const uint cmpIndex7 = 0u;
layout(constant_id = 18) const uint cmpIndex8 = 0u;
layout(constant_id = 19) const uint cmpIndex9 = 0u;
layout(constant_id = 20) const uint cmpIndex10 = 0u;
layout(constant_id = 21) const uint cmpIndex11 = 0u;
layout(constant_id = 22) const uint cmpIndex12 = 0u;
layout(constant_id = 23) const uint cmpIndex13 = 0u;
layout(constant_id = 24) const uint cmpIndex14 = 0u;
layout(constant_id = 25) const uint cmpIndex15 = 0u;
layout(constant_id = 26) const uint cmpIndex16 = 0u;


void main()
[[subgroup_uniform_control_flow]]
{

    {
        int loopIdx0 = 0;
        do {
            loopIdx0++;
            return;
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10002;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        } while (loopIdx0 < inputA.a[5]);
    }
    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10006;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        if (testBit(uvec4(0x91b3bcd8, 0x6a4b0e01, 0x2033a7ef, 0xef82cc51), gl_SubgroupInvocationID)) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10009;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
                {
                    int loopIdx0 = 0;
                    do {
                        loopIdx0++;
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000d;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    } while (loopIdx0 < inputA.a[5]);
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10010;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                if (gl_LocalInvocationIndex >= inputA.a[cmpIndex2]) {
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10014;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            } else {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10017;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                if (gl_LocalInvocationIndex >= inputA.a[cmpIndex3]) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001a;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001d;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                if (inputA.a[2] == 2) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10020;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
            }
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex4]) {
                for (int loopIdx0 = 0;
                         loopIdx0 < inputA.a[1];
                         loopIdx0++) {
                }
                while (!subgroupElect()) {}
                {
                    int loopIdx0 = 0;
                    do {
                        if (subgroupElect()) {
                            break;
                        }
                        loopIdx0++;
                    } while (true);
                }
            } else {
                if (gl_LocalInvocationIndex >= inputA.a[cmpIndex5]) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002f;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                } else {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10032;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
                switch (gl_SubgroupInvocationID & 3) {
                    case 0:
                    case 1:
                    {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10037;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        break;
                    }
                    case 2:
                    case 3:
                    {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1003b;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        break;
                    }
                }
            }
        } else {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10009;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex6]) {
                {
                    int loopIdx0 = 0;
                    do {
                        loopIdx0++;
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000d;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    } while (loopIdx0 < inputA.a[5]);
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10010;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                if (gl_LocalInvocationIndex >= inputA.a[cmpIndex7]) {
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10014;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            } else {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10017;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                if (gl_LocalInvocationIndex >= inputA.a[cmpIndex8]) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001a;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001d;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                if (inputA.a[0] == 0) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10020;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
            }
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex9]) {
                for (int loopIdx0 = 0;
                         loopIdx0 < inputA.a[1];
                         loopIdx0++) {
                }
                while (!subgroupElect()) {}
                {
                    int loopIdx0 = 0;
                    do {
                        if (subgroupElect()) {
                            break;
                        }
                        loopIdx0++;
                    } while (true);
                }
            } else {
                if (gl_LocalInvocationIndex >= inputA.a[cmpIndex10]) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002f;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                } else {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10032;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
                switch (gl_SubgroupInvocationID & 3) {
                    case 0:
                    case 1:
                    {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10037;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        break;
                    }
                    case 2:
                    case 3:
                    {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1003b;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        break;
                    }
                }
            }
        }
        {
            int loopIdx0 = 0;
            do {
                if (gl_LocalInvocationIndex >= inputA.a[cmpIndex11]) {
                    for (int loopIdx1 = 0;
                             loopIdx1 < gl_SubgroupInvocationID + 1;
                             loopIdx1++) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1007c;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    }
                } else {
                    for (int loopIdx1 = 0;
                             loopIdx1 < gl_SubgroupInvocationID + 1;
                             loopIdx1++) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1007c;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    }
                }
                if (gl_SubgroupInvocationID == loopIdx0) {
                    if (testBit(uvec4(0xede2dc2c, 0xdcb30010, 0x2ebc3846, 0x63a3bd92), gl_SubgroupInvocationID)) {
                        break;
                    } else {
                        break;
                    }
                    if (inputA.a[0] == 0) {
                    }
                }
                if (subgroupElect()) {
                    break;
                }
                if (testBit(uvec4(0x1e63b50d, 0x123a9eee, 0x5acbdd0b, 0xe77a12d4), gl_SubgroupInvocationID)) {
                    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex12]) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10093;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    } else {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10096;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    }
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10099;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    if (gl_SubgroupInvocationID == loopIdx0) {
                    } else {
                    }
                } else {
                    if (gl_SubgroupInvocationID == loopIdx0) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x100a0;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    } else {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x100a3;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    }
                    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex13]) {
                    }
                }
                {
                    int loopIdx1 = 0;
                    do {
                        break;
                        for (int loopIdx2 = 0;
                                 loopIdx2 < inputA.a[4];
                                 loopIdx2++) {
                        }
                        if (subgroupElect()) {
                            break;
                        }
                        if (gl_SubgroupInvocationID == loopIdx1) {
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x100b1;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        }
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x100b4;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        if (testBit(uvec4(0x1e63b50d, 0x123a9eee, 0x5acbdd0b, 0xe77a12d4), gl_SubgroupInvocationID)) {
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x100b7;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        }
                        loopIdx1++;
                    } while (true);
                }
                loopIdx0++;
            } while (true);
        }
    } else {
        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex14]) {
            for (int loopIdx0 = 0;
                     loopIdx0 < gl_SubgroupInvocationID + 1;
                     loopIdx0++) {
                switch (gl_SubgroupInvocationID & 3) {
                    case 0:
                    case 1:
                    {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x100c1;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        break;
                    }
                    case 2:
                    case 3:
                    {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x100c5;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        break;
                    }
                }
                switch (loopIdx0) {
                    case 1: {
                        break;
                    }
                    case 2: {
                        break;
                    }
                    default: {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x100cf;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        break;
                    }
                }
            }
            if (inputA.a[2] == 2) {
                if (gl_LocalInvocationIndex >= inputA.a[cmpIndex15]) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x100d6;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                } else {
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x100da;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            }
        } else {
            if (testBit(uvec4(0x1e63b50d, 0x123a9eee, 0x5acbdd0b, 0xe77a12d4), gl_SubgroupInvocationID)) {
                if (gl_LocalInvocationIndex >= inputA.a[cmpIndex16]) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x100e0;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
                {
                    int loopIdx0 = 0;
                    do {
                        if (subgroupElect()) {
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x100e5;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                            if (testBit(uvec4(0xede2dc2c, 0xdcb30010, 0x2ebc3846, 0x63a3bd92), gl_SubgroupInvocationID)) {
                                break;
                            } else {
                                break;
                            }
                        }
                        loopIdx0++;
                    } while (true);
                }
            }
        }
    }



}
#version 450 core
#extension GL_KHR_shader_subgroup_ballot : enable
#extension GL_KHR_shader_subgroup_vote : enable
#extension GL_NV_shader_subgroup_partitioned : enable
#extension GL_EXT_subgroup_uniform_control_flow : enable
layout(local_size_x_id = 0, local_size_y_id = 1, local_size_z = 1) in;
layout(set=0, binding=2) coherent buffer OutputC { uint loc[]; } outputC;
layout(set=0, binding=1) coherent buffer OutputB { uvec4 b[]; } outputB;
layout(set=0, binding=0) coherent buffer InputA  { uint  a[]; } inputA;
layout(push_constant) uniform PC {
   // set to the real stride when writing out ballots, or zero when just counting
   int  invocationStride;
   // wildcard fields, for an example the dimensions of rendered area in the case of graphics shaders
   int  width;
   int  height;
   uint primitiveStride;
   uint subgroupStride;
   uint enableInvocationIndex;
};
int outLoc = 0;
bool testBit(uvec4 mask, uint bit) { return ((mask[bit / 32] >> (bit % 32)) & 1) != 0; }
uint elect() { return int(subgroupElect()) + 1; }


void main()
[[subgroup_uniform_control_flow]]
{

    for (int loopIdx0 = 0;;loopIdx0++,    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true)) {
        break;
        if (gl_SubgroupInvocationID == loopIdx0) {
            if (inputA.a[3] == 3) {
                if (testBit(uvec4(0xe3e6077b, 0x934d4176, 0x44df3f14, 0x16bfbe39), gl_SubgroupInvocationID)) {
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10006;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                for (int loopIdx1 = 0;
                         loopIdx1 < inputA.a[2];
                         loopIdx1++) {
                }
            } else {
                if (gl_SubgroupInvocationID == loopIdx0) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000c;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                } else {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000f;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10013;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            if (inputA.a[3] == 3) {
                break;
                {
                    int loopIdx1 = 0;
                    do {
                        loopIdx1++;
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10018;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    } while (loopIdx1 < inputA.a[3]);
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001b;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            }
        } else {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001f;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            if (gl_SubgroupInvocationID == loopIdx0) {
                if (testBit(uvec4(0xbdeae9f, 0x37d0c6ef, 0x9f4cb738, 0x54c6189a), gl_SubgroupInvocationID)) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10023;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
                if (inputA.a[2] == 2) {
                } else {
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10029;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            } else {
                if (inputA.a[0] == 12345) {
                    while (true) {
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    }
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002d;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                if (testBit(uvec4(0xe3e6077b, 0x934d4176, 0x44df3f14, 0x16bfbe39), gl_SubgroupInvocationID)) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10030;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10033;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10036;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        }
        if (subgroupElect()) {
            break;
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1003c;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        break;
    }



}
#version 450 core
#extension GL_KHR_shader_subgroup_ballot : enable
#extension GL_KHR_shader_subgroup_vote : enable
#extension GL_NV_shader_subgroup_partitioned : enable
#extension GL_EXT_subgroup_uniform_control_flow : enable
layout(local_size_x_id = 0, local_size_y_id = 1, local_size_z = 1) in;
layout(set=0, binding=2) coherent buffer OutputC { uint loc[]; } outputC;
layout(set=0, binding=1) coherent buffer OutputB { uvec4 b[]; } outputB;
layout(set=0, binding=0) coherent buffer InputA  { uint  a[]; } inputA;
layout(push_constant) uniform PC {
   // set to the real stride when writing out ballots, or zero when just counting
   int  invocationStride;
   // wildcard fields, for an example the dimensions of rendered area in the case of graphics shaders
   int  width;
   int  height;
   uint primitiveStride;
   uint subgroupStride;
   uint enableInvocationIndex;
};
int outLoc = 0;
bool testBit(uvec4 mask, uint bit) { return ((mask[bit / 32] >> (bit % 32)) & 1) != 0; }
uint elect() { return int(subgroupElect()) + 1; }
layout(constant_id = 10) const uint cmpIndex0 = 0u;
layout(constant_id = 11) const uint cmpIndex1 = 0u;
layout(constant_id = 12) const uint cmpIndex2 = 0u;
layout(constant_id = 13) const uint cmpIndex3 = 0u;
layout(constant_id = 14) const uint cmpIndex4 = 0u;


void main()
[[subgroup_uniform_control_flow]]
{

    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10001;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        {
            int loopIdx0 = 0;
            do {
                {
                    int loopIdx1 = 0;
                    do {
                        loopIdx1++;
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10005;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        break;
                        if (inputA.a[0] == 0) {
                        } else {
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000a;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        }
                    } while (loopIdx1 < inputA.a[4]);
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000e;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                if (gl_SubgroupInvocationID == loopIdx0) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10011;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10014;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    } else {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10017;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    }
                }
                if (subgroupElect()) {
                    break;
                }
                if (inputA.a[0] == 0) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001f;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    for (int loopIdx1 = 0;
                             loopIdx1 < inputA.a[1];
                             loopIdx1++) {
                    }
                } else {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10024;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    switch (loopIdx0) {
                        case 1: {
                            break;
                        }
                        case 2: {
                            break;
                        }
                        default: {
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002c;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                            break;
                        }
                    }
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10031;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                if (testBit(uvec4(0xb0caba39, 0xdcbca1e5, 0x73e934e7, 0x3e8bc839), gl_SubgroupInvocationID)) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10034;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    if (subgroupElect()) {
                    }
                } else {
                    {
                        int loopIdx1 = 0;
                        do {
                            if (subgroupElect()) {
                                outputC.loc[gl_LocalInvocationIndex]++;
                                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1003b;
                                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                                break;
                            }
                            loopIdx1++;
                        } while (true);
                    }
                }
                loopIdx0++;
            } while (true);
        }
        if (inputA.a[3] == 3) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10043;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            for (int loopIdx0 = 0;;loopIdx0++,            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true)) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10046;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                if (subgroupElect()) {
                    break;
                }
                for (int loopIdx1 = 0;
                         loopIdx1 < gl_SubgroupInvocationID + 1;
                         loopIdx1++) {
                }
                break;
            }
        } else {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10050;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10053;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
    } else {
        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex2]) {
            if (inputA.a[2] == 2) {
                if (subgroupElect()) {
                }
                {
                    int loopIdx0 = 0;
                    do {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1005b;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        if (subgroupElect()) {
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1005e;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                            break;
                        }
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10062;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        loopIdx0++;
                    } while (true);
                }
            }
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex3]) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10067;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                if (gl_LocalInvocationIndex >= inputA.a[cmpIndex4]) {
                } else {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1006b;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
            }
        }
    }



}
#version 450 core
#extension GL_KHR_shader_subgroup_ballot : enable
#extension GL_KHR_shader_subgroup_vote : enable
#extension GL_NV_shader_subgroup_partitioned : enable
#extension GL_EXT_subgroup_uniform_control_flow : enable
layout(local_size_x_id = 0, local_size_y_id = 1, local_size_z = 1) in;
layout(set=0, binding=2) coherent buffer OutputC { uint loc[]; } outputC;
layout(set=0, binding=1) coherent buffer OutputB { uvec4 b[]; } outputB;
layout(set=0, binding=0) coherent buffer InputA  { uint  a[]; } inputA;
layout(push_constant) uniform PC {
   // set to the real stride when writing out ballots, or zero when just counting
   int  invocationStride;
   // wildcard fields, for an example the dimensions of rendered area in the case of graphics shaders
   int  width;
   int  height;
   uint primitiveStride;
   uint subgroupStride;
   uint enableInvocationIndex;
};
int outLoc = 0;
bool testBit(uvec4 mask, uint bit) { return ((mask[bit / 32] >> (bit % 32)) & 1) != 0; }
uint elect() { return int(subgroupElect()) + 1; }
layout(constant_id = 10) const uint cmpIndex0 = 0u;
layout(constant_id = 11) const uint cmpIndex1 = 0u;
layout(constant_id = 12) const uint cmpIndex2 = 0u;
layout(constant_id = 13) const uint cmpIndex3 = 0u;


void main()
[[subgroup_uniform_control_flow]]
{

    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10000;
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
    if (inputA.a[0] == 0) {
        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
            if (testBit(uvec4(0xf77511fe, 0x9ecaa8ed, 0x511db92f, 0x8ad08538), gl_SubgroupInvocationID)) {
                if (subgroupElect()) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10006;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
                switch (gl_SubgroupInvocationID & 3) {
                    case 0:
                    {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000b;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        break;
                    }
                    case 1:
                    {
                        break;
                    }
                    case 2:
                    {
                        break;
                    }
                    case 3:
                    {
                        break;
                    }
                }
            } else {
                for (int loopIdx0 = 0;
                         loopIdx0 < gl_SubgroupInvocationID + 1;
                         loopIdx0++) {
                    if (inputA.a[0] == 12345) {
                        while (true) {
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        }
                    }
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10019;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                if (subgroupElect()) {
                }
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001e;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        } else {
            if (testBit(uvec4(0xf77511fe, 0x9ecaa8ed, 0x511db92f, 0x8ad08538), gl_SubgroupInvocationID)) {
                if (subgroupElect()) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10006;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
                switch (gl_SubgroupInvocationID & 3) {
                    case 0:
                    {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000b;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        break;
                    }
                    case 1:
                    {
                        break;
                    }
                    case 2:
                    {
                        break;
                    }
                    case 3:
                    {
                        break;
                    }
                }
            } else {
                for (int loopIdx0 = 0;
                         loopIdx0 < gl_SubgroupInvocationID + 1;
                         loopIdx0++) {
                    if (inputA.a[0] == 12345) {
                        while (true) {
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        }
                    }
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10019;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                if (subgroupElect()) {
                }
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001e;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1003e;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
    } else {
        if (subgroupElect()) {
            switch (inputA.a[3]) {
                case 4:
                {
                    if (subgroupElect()) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10045;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    }
                    break;
                }
                case 3:
                {
                    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1004b;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    } else {
                    }
                    return;
                    break;
                }
                case 5:
                {
                    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex2]) {
                    } else {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10054;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    }
                    break;
                }
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10059;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            for (int loopIdx0 = 0;
                     loopIdx0 < inputA.a[2];
                     loopIdx0++) {
                for (int loopIdx1 = 0;
                         loopIdx1 < gl_SubgroupInvocationID + 1;
                         loopIdx1++) {
                }
                if (inputA.a[3] == 3) {
                }
            }
        }
        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex3]) {
            if (testBit(uvec4(0x9e19d960, 0xdc84f6e8, 0x5cf95d28, 0x1058dec4), gl_SubgroupInvocationID)) {
                if (inputA.a[2] == 2) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10065;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10068;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                switch (gl_SubgroupInvocationID & 3) {
                    case 0:
                    case 1:
                    {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1006c;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        break;
                    }
                    case 2:
                    case 3:
                    {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10070;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        break;
                    }
                }
            }
            switch (gl_SubgroupInvocationID & 3) {
                case 0:
                case 1:
                {
                    if (testBit(uvec4(0xf7b3ccb6, 0xa731d3e9, 0xb74d8b76, 0x21cb827a), gl_SubgroupInvocationID)) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10078;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    }
                    break;
                }
                case 2:
                case 3:
                {
                    for (int loopIdx0 = 0;
                             loopIdx0 < inputA.a[4];
                             loopIdx0++) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1007e;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    }
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10081;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    if (inputA.a[0] == 0) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10084;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    }
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10087;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    break;
                }
            }
        }
    }
    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1008d;
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);



}
#version 450 core
#extension GL_KHR_shader_subgroup_ballot : enable
#extension GL_KHR_shader_subgroup_vote : enable
#extension GL_NV_shader_subgroup_partitioned : enable
#extension GL_EXT_subgroup_uniform_control_flow : enable
layout(local_size_x_id = 0, local_size_y_id = 1, local_size_z = 1) in;
layout(set=0, binding=2) coherent buffer OutputC { uint loc[]; } outputC;
layout(set=0, binding=1) coherent buffer OutputB { uvec4 b[]; } outputB;
layout(set=0, binding=0) coherent buffer InputA  { uint  a[]; } inputA;
layout(push_constant) uniform PC {
   // set to the real stride when writing out ballots, or zero when just counting
   int  invocationStride;
   // wildcard fields, for an example the dimensions of rendered area in the case of graphics shaders
   int  width;
   int  height;
   uint primitiveStride;
   uint subgroupStride;
   uint enableInvocationIndex;
};
int outLoc = 0;
bool testBit(uvec4 mask, uint bit) { return ((mask[bit / 32] >> (bit % 32)) & 1) != 0; }
uint elect() { return int(subgroupElect()) + 1; }
layout(constant_id = 10) const uint cmpIndex0 = 0u;
layout(constant_id = 11) const uint cmpIndex1 = 0u;
layout(constant_id = 12) const uint cmpIndex2 = 0u;
layout(constant_id = 13) const uint cmpIndex3 = 0u;
layout(constant_id = 14) const uint cmpIndex4 = 0u;


void main()
[[subgroup_uniform_control_flow]]
{

    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10000;
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
    switch (inputA.a[2]) {
        case 3:
        {
            if (subgroupElect()) {
                {
                    int loopIdx0 = 0;
                    do {
                        loopIdx0++;
                        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
                        }
                        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10009;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        } else {
                        }
                    } while (loopIdx0 < inputA.a[3]);
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000e;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                {
                    int loopIdx0 = 0;
                    do {
                        if (gl_SubgroupInvocationID == loopIdx0) {
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10012;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        } else {
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10012;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        }
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10018;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        if (subgroupElect()) {
                        }
                        if (subgroupElect()) {
                            break;
                        }
                        if (subgroupElect()) {
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10020;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        }
                        if (testBit(uvec4(0x47437516, 0xdc8cc7ef, 0x85e228f4, 0xc902798b), gl_SubgroupInvocationID)) {
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10024;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        } else {
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10027;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        }
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002a;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        loopIdx0++;
                    } while (true);
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002d;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            }
            break;
        }
        case 2:
        {
            switch (gl_SubgroupInvocationID & 3) {
                case 0:
                {
                    if (subgroupElect()) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10035;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        switch (inputA.a[3]) {
                            case 4:
                            {
                                break;
                            }
                            case 3:
                            {
                                break;
                            }
                            case 5:
                            {
                                break;
                            }
                        }
                    }
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10040;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    break;
                }
                case 1:
                {
                    break;
                }
                case 2:
                {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10046;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    if (testBit(uvec4(0xc8626f10, 0x4b547ee1, 0xd59c011f, 0x36238fad), gl_SubgroupInvocationID)) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10049;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        switch (gl_SubgroupInvocationID & 3) {
                            case 0:
                            case 1:
                            {
                                break;
                            }
                            case 2:
                            case 3:
                            {
                                outputC.loc[gl_LocalInvocationIndex]++;
                                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1004f;
                                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                                break;
                            }
                        }
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10053;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    } else {
                        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex2]) {
                        }
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10058;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    }
                    break;
                }
                case 3:
                {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1005d;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    break;
                }
            }
            {
                int loopIdx0 = 0;
                do {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10062;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    if (subgroupElect()) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10065;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        break;
                    }
                    if (subgroupElect()) {
                        switch (gl_SubgroupInvocationID & 3) {
                            case 0:
                            case 1:
                            {
                                break;
                            }
                            case 2:
                            case 3:
                            {
                                break;
                            }
                        }
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10070;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        break;
                    }
                    if (testBit(uvec4(0x2d447467, 0x7ae64289, 0x13784927, 0xf531f510), gl_SubgroupInvocationID)) {
                        if (inputA.a[0] == 0) {
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10076;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        } else {
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10079;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        }
                        switch (inputA.a[1]) {
                            case 2:
                            {
                                break;
                            }
                            case 1:
                            {
                                outputC.loc[gl_LocalInvocationIndex]++;
                                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10080;
                                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                                break;
                            }
                            case 3:
                            {
                                break;
                            }
                        }
                    } else {
                        break;
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10088;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        if (testBit(uvec4(0xc8626f10, 0x4b547ee1, 0xd59c011f, 0x36238fad), gl_SubgroupInvocationID)) {
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1008b;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        } else {
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1008e;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        }
                    }
                    loopIdx0++;
                } while (true);
            }
            break;
        }
        case 4:
        {
            if (inputA.a[0] == 0) {
                if (gl_LocalInvocationIndex >= inputA.a[cmpIndex3]) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10097;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    {
                        int loopIdx0 = 0;
                        do {
                            loopIdx0++;
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1009a;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        } while (loopIdx0 < inputA.a[4]);
                    }
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1009d;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex4]) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x100a0;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    } else {
                    }
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x100a5;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            }
            break;
        }
    }



}
#version 450 core
#extension GL_KHR_shader_subgroup_ballot : enable
#extension GL_KHR_shader_subgroup_vote : enable
#extension GL_NV_shader_subgroup_partitioned : enable
#extension GL_EXT_subgroup_uniform_control_flow : enable
layout(local_size_x_id = 0, local_size_y_id = 1, local_size_z = 1) in;
layout(set=0, binding=2) coherent buffer OutputC { uint loc[]; } outputC;
layout(set=0, binding=1) coherent buffer OutputB { uvec4 b[]; } outputB;
layout(set=0, binding=0) coherent buffer InputA  { uint  a[]; } inputA;
layout(push_constant) uniform PC {
   // set to the real stride when writing out ballots, or zero when just counting
   int  invocationStride;
   // wildcard fields, for an example the dimensions of rendered area in the case of graphics shaders
   int  width;
   int  height;
   uint primitiveStride;
   uint subgroupStride;
   uint enableInvocationIndex;
};
int outLoc = 0;
bool testBit(uvec4 mask, uint bit) { return ((mask[bit / 32] >> (bit % 32)) & 1) != 0; }
uint elect() { return int(subgroupElect()) + 1; }
layout(constant_id = 10) const uint cmpIndex0 = 0u;
layout(constant_id = 11) const uint cmpIndex1 = 0u;
layout(constant_id = 12) const uint cmpIndex2 = 0u;


void main()
[[subgroup_uniform_control_flow]]
{

    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
        if (testBit(uvec4(0x467d6e76, 0x4b45c110, 0xdc26e53e, 0xc4601a6e), gl_SubgroupInvocationID)) {
            for (int loopIdx0 = 0;;loopIdx0++,            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true)) {
                for (int loopIdx1 = 0;
                         loopIdx1 < inputA.a[5];
                         loopIdx1++) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10004;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
                switch (loopIdx0) {
                    case 1: {
                        break;
                    }
                    case 2: {
                        break;
                    }
                    default: {
                        break;
                    }
                }
                if (subgroupElect()) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10010;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    break;
                }
                if (subgroupElect()) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10015;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
                if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10019;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                } else {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001c;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001f;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            }
        }
    } else {
        if (testBit(uvec4(0x467d6e76, 0x4b45c110, 0xdc26e53e, 0xc4601a6e), gl_SubgroupInvocationID)) {
            for (int loopIdx0 = 0;;loopIdx0++,            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true)) {
                for (int loopIdx1 = 0;
                         loopIdx1 < inputA.a[5];
                         loopIdx1++) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10004;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
                switch (loopIdx0) {
                    case 1: {
                        break;
                    }
                    case 2: {
                        break;
                    }
                    default: {
                        break;
                    }
                }
                if (subgroupElect()) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10010;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    break;
                }
                if (subgroupElect()) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10015;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
                if (gl_LocalInvocationIndex >= inputA.a[cmpIndex2]) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10019;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                } else {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001c;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001f;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            }
        }
    }



}
#version 450 core
#extension GL_KHR_shader_subgroup_ballot : enable
#extension GL_KHR_shader_subgroup_vote : enable
#extension GL_NV_shader_subgroup_partitioned : enable
#extension GL_EXT_subgroup_uniform_control_flow : enable
layout(local_size_x_id = 0, local_size_y_id = 1, local_size_z = 1) in;
layout(set=0, binding=2) coherent buffer OutputC { uint loc[]; } outputC;
layout(set=0, binding=1) coherent buffer OutputB { uvec4 b[]; } outputB;
layout(set=0, binding=0) coherent buffer InputA  { uint  a[]; } inputA;
layout(push_constant) uniform PC {
   // set to the real stride when writing out ballots, or zero when just counting
   int  invocationStride;
   // wildcard fields, for an example the dimensions of rendered area in the case of graphics shaders
   int  width;
   int  height;
   uint primitiveStride;
   uint subgroupStride;
   uint enableInvocationIndex;
};
int outLoc = 0;
bool testBit(uvec4 mask, uint bit) { return ((mask[bit / 32] >> (bit % 32)) & 1) != 0; }
uint elect() { return int(subgroupElect()) + 1; }
layout(constant_id = 10) const uint cmpIndex0 = 0u;
layout(constant_id = 11) const uint cmpIndex1 = 0u;
layout(constant_id = 12) const uint cmpIndex2 = 0u;


void main()
{

    if (inputA.a[2] == 2) {
        for (int loopIdx0 = 0;
                 loopIdx0 < gl_SubgroupInvocationID + 1;
                 loopIdx0++) {
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10003;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        {
            int loopIdx0 = 0;
            do {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10006;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                if (subgroupElect()) {
                    break;
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000b;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                loopIdx0++;
            } while (true);
        }
    } else {
        for (int loopIdx0 = 0;
                 loopIdx0 < inputA.a[3];
                 loopIdx0++) {
        }
        if (testBit(uvec4(0xcfbc2897, 0xfc76d7d0, 0x3a289c17, 0xb008b37a), gl_SubgroupInvocationID)) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10012;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        } else {
        }
    }
    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10017;
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001b;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        }
        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex2]) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001f;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        }
    }



}
#version 450 core
#extension GL_KHR_shader_subgroup_ballot : enable
#extension GL_KHR_shader_subgroup_vote : enable
#extension GL_NV_shader_subgroup_partitioned : enable
#extension GL_EXT_subgroup_uniform_control_flow : enable
layout(local_size_x_id = 0, local_size_y_id = 1, local_size_z = 1) in;
layout(set=0, binding=2) coherent buffer OutputC { uint loc[]; } outputC;
layout(set=0, binding=1) coherent buffer OutputB { uvec4 b[]; } outputB;
layout(set=0, binding=0) coherent buffer InputA  { uint  a[]; } inputA;
layout(push_constant) uniform PC {
   // set to the real stride when writing out ballots, or zero when just counting
   int  invocationStride;
   // wildcard fields, for an example the dimensions of rendered area in the case of graphics shaders
   int  width;
   int  height;
   uint primitiveStride;
   uint subgroupStride;
   uint enableInvocationIndex;
};
int outLoc = 0;
bool testBit(uvec4 mask, uint bit) { return ((mask[bit / 32] >> (bit % 32)) & 1) != 0; }
uint elect() { return int(subgroupElect()) + 1; }
layout(constant_id = 10) const uint cmpIndex0 = 0u;


void main()
{

    if (testBit(uvec4(0x579965e, 0xdcab3315, 0xc6e61baa, 0x8b38dac5), gl_SubgroupInvocationID)) {
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10001;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
    } else {
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10004;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        if (inputA.a[1] == 1) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10007;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        } else {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10007;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        }
        if (inputA.a[1] == 1) {
        }
    }
    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10010;
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
    if (subgroupElect()) {
        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10014;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        } else {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10017;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        }
        for (int loopIdx0 = 0;;loopIdx0++,        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect()) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001b;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            if (subgroupElect()) {
                break;
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10020;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10023;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
    }



}
#version 450 core
#extension GL_KHR_shader_subgroup_ballot : enable
#extension GL_KHR_shader_subgroup_vote : enable
#extension GL_NV_shader_subgroup_partitioned : enable
#extension GL_EXT_subgroup_uniform_control_flow : enable
layout(local_size_x_id = 0, local_size_y_id = 1, local_size_z = 1) in;
layout(set=0, binding=2) coherent buffer OutputC { uint loc[]; } outputC;
layout(set=0, binding=1) coherent buffer OutputB { uvec4 b[]; } outputB;
layout(set=0, binding=0) coherent buffer InputA  { uint  a[]; } inputA;
layout(push_constant) uniform PC {
   // set to the real stride when writing out ballots, or zero when just counting
   int  invocationStride;
   // wildcard fields, for an example the dimensions of rendered area in the case of graphics shaders
   int  width;
   int  height;
   uint primitiveStride;
   uint subgroupStride;
   uint enableInvocationIndex;
};
int outLoc = 0;
bool testBit(uvec4 mask, uint bit) { return ((mask[bit / 32] >> (bit % 32)) & 1) != 0; }
uint elect() { return int(subgroupElect()) + 1; }
layout(constant_id = 10) const uint cmpIndex0 = 0u;
layout(constant_id = 11) const uint cmpIndex1 = 0u;


void main()
{

    {
        int loopIdx0 = 0;
        do {
            loopIdx0++;
            return;
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10002;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        } while (loopIdx0 < inputA.a[5]);
    }
    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10006;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        if (testBit(uvec4(0x91b3bcd8, 0x6a4b0e01, 0x2033a7ef, 0xef82cc51), gl_SubgroupInvocationID)) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10009;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000c;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
    }
    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000f;
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
        {
            int loopIdx0 = 0;
            do {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10013;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                if (subgroupElect()) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10016;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    break;
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001a;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                loopIdx0++;
            } while (true);
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001d;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
    } else {
        {
            int loopIdx0 = 0;
            do {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10013;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                if (subgroupElect()) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10016;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    break;
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001a;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                loopIdx0++;
            } while (true);
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001d;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
    }
    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002e;
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();



}
#version 450 core
#extension GL_KHR_shader_subgroup_ballot : enable
#extension GL_KHR_shader_subgroup_vote : enable
#extension GL_NV_shader_subgroup_partitioned : enable
#extension GL_EXT_subgroup_uniform_control_flow : enable
layout(local_size_x_id = 0, local_size_y_id = 1, local_size_z = 1) in;
layout(set=0, binding=2) coherent buffer OutputC { uint loc[]; } outputC;
layout(set=0, binding=1) coherent buffer OutputB { uvec4 b[]; } outputB;
layout(set=0, binding=0) coherent buffer InputA  { uint  a[]; } inputA;
layout(push_constant) uniform PC {
   // set to the real stride when writing out ballots, or zero when just counting
   int  invocationStride;
   // wildcard fields, for an example the dimensions of rendered area in the case of graphics shaders
   int  width;
   int  height;
   uint primitiveStride;
   uint subgroupStride;
   uint enableInvocationIndex;
};
int outLoc = 0;
bool testBit(uvec4 mask, uint bit) { return ((mask[bit / 32] >> (bit % 32)) & 1) != 0; }
uint elect() { return int(subgroupElect()) + 1; }


void main()
{

    for (int loopIdx0 = 0;;loopIdx0++,    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect()) {
        break;
        if (gl_SubgroupInvocationID == loopIdx0) {
        }
        if (subgroupElect()) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10005;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            break;
        }
        if (testBit(uvec4(0x5664d7eb, 0xdcbb511b, 0x9578e94b, 0xd825b137), gl_SubgroupInvocationID)) {
            break;
        } else {
            break;
        }
        if (subgroupElect()) {
        }
    }
    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10011;
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
    for (int loopIdx0 = 0;
             loopIdx0 < gl_SubgroupInvocationID + 1;
             loopIdx0++) {
        if (inputA.a[3] == 3) {
        }
        switch (loopIdx0) {
            case 1: {
                break;
            }
            case 2: {
                break;
            }
            default: {
                break;
            }
        }
    }



}
#version 450 core
#extension GL_KHR_shader_subgroup_ballot : enable
#extension GL_KHR_shader_subgroup_vote : enable
#extension GL_NV_shader_subgroup_partitioned : enable
#extension GL_EXT_subgroup_uniform_control_flow : enable
layout(local_size_x_id = 0, local_size_y_id = 1, local_size_z = 1) in;
layout(set=0, binding=2) coherent buffer OutputC { uint loc[]; } outputC;
layout(set=0, binding=1) coherent buffer OutputB { uvec4 b[]; } outputB;
layout(set=0, binding=0) coherent buffer InputA  { uint  a[]; } inputA;
layout(push_constant) uniform PC {
   // set to the real stride when writing out ballots, or zero when just counting
   int  invocationStride;
   // wildcard fields, for an example the dimensions of rendered area in the case of graphics shaders
   int  width;
   int  height;
   uint primitiveStride;
   uint subgroupStride;
   uint enableInvocationIndex;
};
int outLoc = 0;
bool testBit(uvec4 mask, uint bit) { return ((mask[bit / 32] >> (bit % 32)) & 1) != 0; }
uint elect() { return int(subgroupElect()) + 1; }
layout(constant_id = 10) const uint cmpIndex0 = 0u;


void main()
{

    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10000;
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
        if (subgroupElect()) {
        }
        {
            int loopIdx0 = 0;
            do {
                if (subgroupElect()) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10007;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    break;
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000b;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                loopIdx0++;
            } while (true);
        }
    }
    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000f;
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
    for (int loopIdx0 = 0;;loopIdx0++,    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect()) {
        switch (gl_SubgroupInvocationID & 3) {
            case 0:
            case 1:
            {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10014;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                break;
            }
            case 2:
            case 3:
            {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10018;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                break;
            }
        }
        for (int loopIdx1 = 0;;loopIdx1++,        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect()) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001d;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            if (subgroupElect()) {
                break;
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10022;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        }
        if (subgroupElect()) {
            break;
        }
        if (subgroupElect()) {
        }
        if (gl_SubgroupInvocationID == loopIdx0) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002b;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        } else {
        }
    }



}
#version 450 core
#extension GL_KHR_shader_subgroup_ballot : enable
#extension GL_KHR_shader_subgroup_vote : enable
#extension GL_NV_shader_subgroup_partitioned : enable
#extension GL_EXT_subgroup_uniform_control_flow : enable
layout(local_size_x_id = 0, local_size_y_id = 1, local_size_z = 1) in;
layout(set=0, binding=2) coherent buffer OutputC { uint loc[]; } outputC;
layout(set=0, binding=1) coherent buffer OutputB { uvec4 b[]; } outputB;
layout(set=0, binding=0) coherent buffer InputA  { uint  a[]; } inputA;
layout(push_constant) uniform PC {
   // set to the real stride when writing out ballots, or zero when just counting
   int  invocationStride;
   // wildcard fields, for an example the dimensions of rendered area in the case of graphics shaders
   int  width;
   int  height;
   uint primitiveStride;
   uint subgroupStride;
   uint enableInvocationIndex;
};
int outLoc = 0;
bool testBit(uvec4 mask, uint bit) { return ((mask[bit / 32] >> (bit % 32)) & 1) != 0; }
uint elect() { return int(subgroupElect()) + 1; }
layout(constant_id = 10) const uint cmpIndex0 = 0u;
layout(constant_id = 11) const uint cmpIndex1 = 0u;
layout(constant_id = 12) const uint cmpIndex2 = 0u;
layout(constant_id = 13) const uint cmpIndex3 = 0u;
layout(constant_id = 14) const uint cmpIndex4 = 0u;


void main()
{

    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10000;
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
    if (inputA.a[2] == 2) {
        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
        } else {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10005;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        }
        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10009;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        }
    } else {
        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex2]) {
        } else {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000f;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        }
        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex3]) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10013;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        } else {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10016;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        }
    }
    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex4]) {
        switch (gl_SubgroupInvocationID & 3) {
            case 0:
            case 1:
            {
                break;
            }
            case 2:
            case 3:
            {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001f;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                break;
            }
        }
    } else {
        for (int loopIdx0 = 0;;loopIdx0++,        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect()) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10025;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            if (subgroupElect()) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10028;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                break;
            }
        }
    }



}
#version 450 core
#extension GL_KHR_shader_subgroup_ballot : enable
#extension GL_KHR_shader_subgroup_vote : enable
#extension GL_NV_shader_subgroup_partitioned : enable
#extension GL_EXT_subgroup_uniform_control_flow : enable
layout(local_size_x_id = 0, local_size_y_id = 1, local_size_z = 1) in;
layout(set=0, binding=2) coherent buffer OutputC { uint loc[]; } outputC;
layout(set=0, binding=1) coherent buffer OutputB { uvec4 b[]; } outputB;
layout(set=0, binding=0) coherent buffer InputA  { uint  a[]; } inputA;
layout(push_constant) uniform PC {
   // set to the real stride when writing out ballots, or zero when just counting
   int  invocationStride;
   // wildcard fields, for an example the dimensions of rendered area in the case of graphics shaders
   int  width;
   int  height;
   uint primitiveStride;
   uint subgroupStride;
   uint enableInvocationIndex;
};
int outLoc = 0;
bool testBit(uvec4 mask, uint bit) { return ((mask[bit / 32] >> (bit % 32)) & 1) != 0; }
uint elect() { return int(subgroupElect()) + 1; }
layout(constant_id = 10) const uint cmpIndex0 = 0u;
layout(constant_id = 11) const uint cmpIndex1 = 0u;
layout(constant_id = 12) const uint cmpIndex2 = 0u;
layout(constant_id = 13) const uint cmpIndex3 = 0u;


void main()
{

    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10000;
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
    switch (inputA.a[2]) {
        case 3:
        {
            if (subgroupElect()) {
            }
            break;
        }
        case 2:
        {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10008;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            switch (gl_SubgroupInvocationID & 3) {
                case 0:
                case 1:
                {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000c;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    break;
                }
                case 2:
                case 3:
                {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10010;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    break;
                }
            }
            break;
        }
        case 4:
        {
            if (subgroupElect()) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10017;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            }
            break;
        }
    }
    if (testBit(uvec4(0x47437516, 0xdc8cc7ef, 0x85e228f4, 0xc902798b), gl_SubgroupInvocationID)) {
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001d;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10020;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        } else {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10020;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        }
        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
        }
    } else {
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001d;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex2]) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10020;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        } else {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10020;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        }
        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex3]) {
        }
    }



}
#version 450 core
#extension GL_KHR_shader_subgroup_ballot : enable
#extension GL_KHR_shader_subgroup_vote : enable
#extension GL_NV_shader_subgroup_partitioned : enable
#extension GL_EXT_subgroup_uniform_control_flow : enable
layout(local_size_x_id = 0, local_size_y_id = 1, local_size_z = 1) in;
layout(set=0, binding=2) coherent buffer OutputC { uint loc[]; } outputC;
layout(set=0, binding=1) coherent buffer OutputB { uvec4 b[]; } outputB;
layout(set=0, binding=0) coherent buffer InputA  { uint  a[]; } inputA;
layout(push_constant) uniform PC {
   // set to the real stride when writing out ballots, or zero when just counting
   int  invocationStride;
   // wildcard fields, for an example the dimensions of rendered area in the case of graphics shaders
   int  width;
   int  height;
   uint primitiveStride;
   uint subgroupStride;
   uint enableInvocationIndex;
};
int outLoc = 0;
bool testBit(uvec4 mask, uint bit) { return ((mask[bit / 32] >> (bit % 32)) & 1) != 0; }
uint elect() { return int(subgroupElect()) + 1; }
layout(constant_id = 10) const uint cmpIndex0 = 0u;


void main()
{

    if (testBit(uvec4(0x467d6e76, 0x4b45c110, 0xdc26e53e, 0xc4601a6e), gl_SubgroupInvocationID)) {
        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
        }
    } else {
        if (testBit(uvec4(0x467d6e76, 0x4b45c110, 0xdc26e53e, 0xc4601a6e), gl_SubgroupInvocationID)) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10005;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        }
        switch (gl_SubgroupInvocationID & 3) {
            case 0:
            case 1:
            {
                break;
            }
            case 2:
            case 3:
            {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000c;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                break;
            }
        }
    }
    switch (gl_SubgroupInvocationID & 3) {
        case 0:
        case 1:
        {
            switch (gl_SubgroupInvocationID & 3) {
                case 0:
                {
                    break;
                }
                case 1:
                {
                    break;
                }
                case 2:
                {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10019;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    break;
                }
                case 3:
                {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001d;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    break;
                }
            }
            break;
        }
        case 2:
        case 3:
        {
            for (int loopIdx0 = 0;;loopIdx0++,            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect()) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10024;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                if (subgroupElect()) {
                    break;
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10029;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            }
            break;
        }
    }
    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002e;
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();



}
#version 450 core
#extension GL_KHR_shader_subgroup_ballot : enable
#extension GL_KHR_shader_subgroup_vote : enable
#extension GL_NV_shader_subgroup_partitioned : enable
#extension GL_EXT_subgroup_uniform_control_flow : enable
layout(local_size_x_id = 0, local_size_y_id = 1, local_size_z = 1) in;
layout(set=0, binding=2) coherent buffer OutputC { uint loc[]; } outputC;
layout(set=0, binding=1) coherent buffer OutputB { uvec4 b[]; } outputB;
layout(set=0, binding=0) coherent buffer InputA  { uint  a[]; } inputA;
layout(push_constant) uniform PC {
   // set to the real stride when writing out ballots, or zero when just counting
   int  invocationStride;
   // wildcard fields, for an example the dimensions of rendered area in the case of graphics shaders
   int  width;
   int  height;
   uint primitiveStride;
   uint subgroupStride;
   uint enableInvocationIndex;
};
int outLoc = 0;
bool testBit(uvec4 mask, uint bit) { return ((mask[bit / 32] >> (bit % 32)) & 1) != 0; }
uint elect() { return int(subgroupElect()) + 1; }
layout(constant_id = 10) const uint cmpIndex0 = 0u;
layout(constant_id = 11) const uint cmpIndex1 = 0u;


void main()
{

    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10001;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10004;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        } else {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10004;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000a;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
    }
    for (int loopIdx0 = 0;
             loopIdx0 < gl_SubgroupInvocationID + 1;
             loopIdx0++) {
        switch (gl_SubgroupInvocationID & 3) {
            case 0:
            case 1:
            {
                break;
            }
            case 2:
            case 3:
            {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10012;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                break;
            }
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10016;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
    }
    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10019;
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
    if (testBit(uvec4(0xca3d6b2e, 0x914630b3, 0xb676d508, 0x160db633), gl_SubgroupInvocationID)) {
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001c;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        {
            int loopIdx0 = 0;
            do {
                if (subgroupElect()) {
                    break;
                }
                loopIdx0++;
            } while (true);
        }
    } else {
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001c;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        {
            int loopIdx0 = 0;
            do {
                if (subgroupElect()) {
                    break;
                }
                loopIdx0++;
            } while (true);
        }
    }



}
#version 450 core
#extension GL_KHR_shader_subgroup_ballot : enable
#extension GL_KHR_shader_subgroup_vote : enable
#extension GL_NV_shader_subgroup_partitioned : enable
#extension GL_EXT_subgroup_uniform_control_flow : enable
layout(local_size_x_id = 0, local_size_y_id = 1, local_size_z = 1) in;
layout(set=0, binding=2) coherent buffer OutputC { uint loc[]; } outputC;
layout(set=0, binding=1) coherent buffer OutputB { uvec4 b[]; } outputB;
layout(set=0, binding=0) coherent buffer InputA  { uint  a[]; } inputA;
layout(push_constant) uniform PC {
   // set to the real stride when writing out ballots, or zero when just counting
   int  invocationStride;
   // wildcard fields, for an example the dimensions of rendered area in the case of graphics shaders
   int  width;
   int  height;
   uint primitiveStride;
   uint subgroupStride;
   uint enableInvocationIndex;
};
int outLoc = 0;
bool testBit(uvec4 mask, uint bit) { return ((mask[bit / 32] >> (bit % 32)) & 1) != 0; }
uint elect() { return int(subgroupElect()) + 1; }


void main()
{

    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10000;
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
    if (testBit(uvec4(0x5e7c62c7, 0x70aa04d5, 0xd5ac6041, 0xab1a9911), gl_SubgroupInvocationID)) {
        if (subgroupElect()) {
            if (testBit(uvec4(0x5e7c62c7, 0x70aa04d5, 0xd5ac6041, 0xab1a9911), gl_SubgroupInvocationID)) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10005;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            } else {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10008;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000b;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        }
        if (inputA.a[1] == 1) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000f;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            for (int loopIdx0 = 0;;loopIdx0++,            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect()) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10012;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                if (subgroupElect()) {
                    break;
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10017;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001a;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            if (subgroupElect()) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001d;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            }
        } else {
            switch (gl_SubgroupInvocationID & 3) {
                case 0:
                case 1:
                {
                    break;
                }
                case 2:
                case 3:
                {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10025;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    break;
                }
            }
            if (subgroupElect()) {
            }
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002c;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
    } else {
        if (subgroupElect()) {
            if (subgroupElect()) {
            }
            if (inputA.a[1] == 1) {
            }
        }
    }



}
#version 450 core
#extension GL_KHR_shader_subgroup_ballot : enable
#extension GL_KHR_shader_subgroup_vote : enable
#extension GL_NV_shader_subgroup_partitioned : enable
#extension GL_EXT_subgroup_uniform_control_flow : enable
layout(local_size_x_id = 0, local_size_y_id = 1, local_size_z = 1) in;
layout(set=0, binding=2) coherent buffer OutputC { uint loc[]; } outputC;
layout(set=0, binding=1) coherent buffer OutputB { uvec4 b[]; } outputB;
layout(set=0, binding=0) coherent buffer InputA  { uint  a[]; } inputA;
layout(push_constant) uniform PC {
   // set to the real stride when writing out ballots, or zero when just counting
   int  invocationStride;
   // wildcard fields, for an example the dimensions of rendered area in the case of graphics shaders
   int  width;
   int  height;
   uint primitiveStride;
   uint subgroupStride;
   uint enableInvocationIndex;
};
int outLoc = 0;
bool testBit(uvec4 mask, uint bit) { return ((mask[bit / 32] >> (bit % 32)) & 1) != 0; }
uint elect() { return int(subgroupElect()) + 1; }
layout(constant_id = 10) const uint cmpIndex0 = 0u;
layout(constant_id = 11) const uint cmpIndex1 = 0u;


void main()
{

    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
        switch (gl_SubgroupInvocationID & 3) {
            case 0:
            case 1:
            {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10003;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                if (inputA.a[1] == 1) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10006;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                } else {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10009;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                }
                break;
            }
            case 2:
            case 3:
            {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000e;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10011;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                }
                break;
            }
        }
    } else {
        {
            int loopIdx0 = 0;
            do {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10018;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                {
                    int loopIdx1 = 0;
                    do {
                        loopIdx1++;
                    } while (loopIdx1 < inputA.a[1]);
                }
                if (inputA.a[3] == 3) {
                }
                if (subgroupElect()) {
                    break;
                }
                if (testBit(uvec4(0x812c43cc, 0x2f392383, 0xd1212f39, 0x629a3975), gl_SubgroupInvocationID)) {
                } else {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10023;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                }
                switch (gl_SubgroupInvocationID & 3) {
                    case 0:
                    {
                        break;
                    }
                    case 1:
                    {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002a;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                        break;
                    }
                    case 2:
                    {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002e;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                        break;
                    }
                    case 3:
                    {
                        break;
                    }
                }
                loopIdx0++;
            } while (true);
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10035;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
    }
    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10038;
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();



}
#version 450 core
#extension GL_KHR_shader_subgroup_ballot : enable
#extension GL_KHR_shader_subgroup_vote : enable
#extension GL_NV_shader_subgroup_partitioned : enable
#extension GL_EXT_subgroup_uniform_control_flow : enable
layout(local_size_x_id = 0, local_size_y_id = 1, local_size_z = 1) in;
layout(set=0, binding=2) coherent buffer OutputC { uint loc[]; } outputC;
layout(set=0, binding=1) coherent buffer OutputB { uvec4 b[]; } outputB;
layout(set=0, binding=0) coherent buffer InputA  { uint  a[]; } inputA;
layout(push_constant) uniform PC {
   // set to the real stride when writing out ballots, or zero when just counting
   int  invocationStride;
   // wildcard fields, for an example the dimensions of rendered area in the case of graphics shaders
   int  width;
   int  height;
   uint primitiveStride;
   uint subgroupStride;
   uint enableInvocationIndex;
};
int outLoc = 0;
bool testBit(uvec4 mask, uint bit) { return ((mask[bit / 32] >> (bit % 32)) & 1) != 0; }
uint elect() { return int(subgroupElect()) + 1; }
layout(constant_id = 10) const uint cmpIndex0 = 0u;
layout(constant_id = 11) const uint cmpIndex1 = 0u;
layout(constant_id = 12) const uint cmpIndex2 = 0u;
layout(constant_id = 13) const uint cmpIndex3 = 0u;


void main()
{

    {
        int loopIdx0 = 0;
        do {
            loopIdx0++;
            return;
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10002;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        } while (loopIdx0 < inputA.a[5]);
    }
    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10006;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        if (testBit(uvec4(0x91b3bcd8, 0x6a4b0e01, 0x2033a7ef, 0xef82cc51), gl_SubgroupInvocationID)) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10009;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000c;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            } else {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000c;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10012;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        } else {
            switch (gl_SubgroupInvocationID & 3) {
                case 0:
                case 1:
                {
                    break;
                }
                case 2:
                case 3:
                {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10019;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    break;
                }
            }
            if (inputA.a[2] == 2) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001e;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            } else {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10021;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            }
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10025;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        switch (gl_SubgroupInvocationID & 3) {
            case 0:
            case 1:
            {
                if (gl_LocalInvocationIndex >= inputA.a[cmpIndex2]) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002a;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002d;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                {
                    int loopIdx0 = 0;
                    do {
                        if (subgroupElect()) {
                            break;
                        }
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10033;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                        loopIdx0++;
                    } while (true);
                }
                break;
            }
            case 2:
            case 3:
            {
                if (gl_LocalInvocationIndex >= inputA.a[cmpIndex3]) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10039;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                } else {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1003c;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                }
                {
                    int loopIdx0 = 0;
                    do {
                        if (subgroupElect()) {
                            break;
                        }
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10043;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                        loopIdx0++;
                    } while (true);
                }
                break;
            }
        }
    }



}
#version 450 core
#extension GL_KHR_shader_subgroup_ballot : enable
#extension GL_KHR_shader_subgroup_vote : enable
#extension GL_NV_shader_subgroup_partitioned : enable
#extension GL_EXT_subgroup_uniform_control_flow : enable
layout(local_size_x_id = 0, local_size_y_id = 1, local_size_z = 1) in;
layout(set=0, binding=2) coherent buffer OutputC { uint loc[]; } outputC;
layout(set=0, binding=1) coherent buffer OutputB { uvec4 b[]; } outputB;
layout(set=0, binding=0) coherent buffer InputA  { uint  a[]; } inputA;
layout(push_constant) uniform PC {
   // set to the real stride when writing out ballots, or zero when just counting
   int  invocationStride;
   // wildcard fields, for an example the dimensions of rendered area in the case of graphics shaders
   int  width;
   int  height;
   uint primitiveStride;
   uint subgroupStride;
   uint enableInvocationIndex;
};
int outLoc = 0;
bool testBit(uvec4 mask, uint bit) { return ((mask[bit / 32] >> (bit % 32)) & 1) != 0; }
uint elect() { return int(subgroupElect()) + 1; }
layout(constant_id = 10) const uint cmpIndex0 = 0u;
layout(constant_id = 11) const uint cmpIndex1 = 0u;


void main()
{

    for (int loopIdx0 = 0;;loopIdx0++,    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect()) {
        break;
        if (gl_SubgroupInvocationID == loopIdx0) {
            if (inputA.a[3] == 3) {
            } else {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10005;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            }
            if (gl_SubgroupInvocationID == loopIdx0) {
            } else {
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000b;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        } else {
            break;
        }
        if (subgroupElect()) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10011;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            break;
        }
        if (gl_SubgroupInvocationID == loopIdx0) {
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
            }
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10019;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            } else {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001c;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001f;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        } else {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10022;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            if (testBit(uvec4(0x9b54ecd6, 0x8188af72, 0xf3e714de, 0x4343808e), gl_SubgroupInvocationID)) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10025;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            } else {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10025;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002b;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            switch (gl_SubgroupInvocationID & 3) {
                case 0:
                case 1:
                {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002f;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    break;
                }
                case 2:
                case 3:
                {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10033;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    break;
                }
            }
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10038;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        switch (gl_SubgroupInvocationID & 3) {
            case 0:
            {
                switch (gl_SubgroupInvocationID & 3) {
                    case 0:
                    case 1:
                    {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1003e;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                        break;
                    }
                    case 2:
                    case 3:
                    {
                        break;
                    }
                }
                break;
            }
            case 1:
            {
                if (testBit(uvec4(0x9b54ecd6, 0x8188af72, 0xf3e714de, 0x4343808e), gl_SubgroupInvocationID)) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10047;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1004a;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                break;
            }
            case 2:
            {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1004e;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                if (subgroupElect()) {
                }
                break;
            }
            case 3:
            {
                for (int loopIdx1 = 0;
                         loopIdx1 < inputA.a[3];
                         loopIdx1++) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10055;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                }
                break;
            }
        }
    }



}
#version 450 core
#extension GL_KHR_shader_subgroup_ballot : enable
#extension GL_KHR_shader_subgroup_vote : enable
#extension GL_NV_shader_subgroup_partitioned : enable
#extension GL_EXT_subgroup_uniform_control_flow : enable
layout(local_size_x_id = 0, local_size_y_id = 1, local_size_z = 1) in;
layout(set=0, binding=2) coherent buffer OutputC { uint loc[]; } outputC;
layout(set=0, binding=1) coherent buffer OutputB { uvec4 b[]; } outputB;
layout(set=0, binding=0) coherent buffer InputA  { uint  a[]; } inputA;
layout(push_constant) uniform PC {
   // set to the real stride when writing out ballots, or zero when just counting
   int  invocationStride;
   // wildcard fields, for an example the dimensions of rendered area in the case of graphics shaders
   int  width;
   int  height;
   uint primitiveStride;
   uint subgroupStride;
   uint enableInvocationIndex;
};
int outLoc = 0;
bool testBit(uvec4 mask, uint bit) { return ((mask[bit / 32] >> (bit % 32)) & 1) != 0; }
uint elect() { return int(subgroupElect()) + 1; }
layout(constant_id = 10) const uint cmpIndex0 = 0u;
layout(constant_id = 11) const uint cmpIndex1 = 0u;


void main()
{

    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10001;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        {
            int loopIdx0 = 0;
            do {
                {
                    int loopIdx1 = 0;
                    do {
                        loopIdx1++;
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10005;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    } while (loopIdx1 < inputA.a[4]);
                }
                if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10009;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                } else {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000c;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                }
                if (subgroupElect()) {
                    break;
                }
                if (inputA.a[3] == 3) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10013;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                } else {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10016;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10019;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                switch (gl_SubgroupInvocationID & 3) {
                    case 0:
                    {
                        break;
                    }
                    case 1:
                    {
                        break;
                    }
                    case 2:
                    {
                        break;
                    }
                    case 3:
                    {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10023;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                        break;
                    }
                }
                loopIdx0++;
            } while (true);
        }
        {
            int loopIdx0 = 0;
            do {
                loopIdx0++;
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10029;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                switch (gl_SubgroupInvocationID & 3) {
                    case 0:
                    case 1:
                    {
                        break;
                    }
                    case 2:
                    case 3:
                    {
                        break;
                    }
                }
                switch (gl_SubgroupInvocationID & 3) {
                    case 0:
                    case 1:
                    {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10033;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                        break;
                    }
                    case 2:
                    case 3:
                    {
                        break;
                    }
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10039;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            } while (loopIdx0 < inputA.a[4]);
        }
    }



}
#version 450 core
#extension GL_KHR_shader_subgroup_ballot : enable
#extension GL_KHR_shader_subgroup_vote : enable
#extension GL_NV_shader_subgroup_partitioned : enable
#extension GL_EXT_subgroup_uniform_control_flow : enable
layout(local_size_x_id = 0, local_size_y_id = 1, local_size_z = 1) in;
layout(set=0, binding=2) coherent buffer OutputC { uint loc[]; } outputC;
layout(set=0, binding=1) coherent buffer OutputB { uvec4 b[]; } outputB;
layout(set=0, binding=0) coherent buffer InputA  { uint  a[]; } inputA;
layout(push_constant) uniform PC {
   // set to the real stride when writing out ballots, or zero when just counting
   int  invocationStride;
   // wildcard fields, for an example the dimensions of rendered area in the case of graphics shaders
   int  width;
   int  height;
   uint primitiveStride;
   uint subgroupStride;
   uint enableInvocationIndex;
};
int outLoc = 0;
bool testBit(uvec4 mask, uint bit) { return ((mask[bit / 32] >> (bit % 32)) & 1) != 0; }
uint elect() { return int(subgroupElect()) + 1; }
layout(constant_id = 10) const uint cmpIndex0 = 0u;
layout(constant_id = 11) const uint cmpIndex1 = 0u;
layout(constant_id = 12) const uint cmpIndex2 = 0u;
layout(constant_id = 13) const uint cmpIndex3 = 0u;


void main()
{

    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10000;
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
    if (inputA.a[0] == 0) {
        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
            if (testBit(uvec4(0xf77511fe, 0x9ecaa8ed, 0x511db92f, 0x8ad08538), gl_SubgroupInvocationID)) {
            } else {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10006;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10009;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            {
                int loopIdx0 = 0;
                do {
                    if (subgroupElect()) {
                        break;
                    }
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000f;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    loopIdx0++;
                } while (true);
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10012;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10015;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        if (subgroupElect()) {
            if (subgroupElect()) {
            }
        }
    } else {
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001c;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        if (testBit(uvec4(0x9e19d960, 0xdc84f6e8, 0x5cf95d28, 0x1058dec4), gl_SubgroupInvocationID)) {
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10020;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            } else {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10020;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10026;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex2]) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10029;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            } else {
            }
        } else {
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex3]) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002f;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10032;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            switch (gl_SubgroupInvocationID & 3) {
                case 0:
                case 1:
                {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10036;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    break;
                }
                case 2:
                case 3:
                {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1003a;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    break;
                }
            }
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1003f;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        for (int loopIdx0 = 0;
                 loopIdx0 < inputA.a[2];
                 loopIdx0++) {
            for (int loopIdx1 = 0;
                     loopIdx1 < gl_SubgroupInvocationID + 1;
                     loopIdx1++) {
            }
            if (inputA.a[0] == 0) {
            }
        }
    }



}
#version 450 core
#extension GL_KHR_shader_subgroup_ballot : enable
#extension GL_KHR_shader_subgroup_vote : enable
#extension GL_NV_shader_subgroup_partitioned : enable
#extension GL_EXT_subgroup_uniform_control_flow : enable
layout(local_size_x_id = 0, local_size_y_id = 1, local_size_z = 1) in;
layout(set=0, binding=2) coherent buffer OutputC { uint loc[]; } outputC;
layout(set=0, binding=1) coherent buffer OutputB { uvec4 b[]; } outputB;
layout(set=0, binding=0) coherent buffer InputA  { uint  a[]; } inputA;
layout(push_constant) uniform PC {
   // set to the real stride when writing out ballots, or zero when just counting
   int  invocationStride;
   // wildcard fields, for an example the dimensions of rendered area in the case of graphics shaders
   int  width;
   int  height;
   uint primitiveStride;
   uint subgroupStride;
   uint enableInvocationIndex;
};
int outLoc = 0;
bool testBit(uvec4 mask, uint bit) { return ((mask[bit / 32] >> (bit % 32)) & 1) != 0; }
uint elect() { return int(subgroupElect()) + 1; }
layout(constant_id = 10) const uint cmpIndex0 = 0u;
layout(constant_id = 11) const uint cmpIndex1 = 0u;
layout(constant_id = 12) const uint cmpIndex2 = 0u;
layout(constant_id = 13) const uint cmpIndex3 = 0u;


void main()
{

    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10000;
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
    switch (inputA.a[2]) {
        case 3:
        {
            if (subgroupElect()) {
                {
                    int loopIdx0 = 0;
                    do {
                        loopIdx0++;
                    } while (loopIdx0 < inputA.a[3]);
                }
                if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10008;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                } else {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10008;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                }
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000f;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            break;
        }
        case 2:
        {
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
                if (inputA.a[3] == 3) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10015;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                } else {
                }
                if (gl_LocalInvocationIndex >= inputA.a[cmpIndex2]) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001a;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                }
            }
            if (testBit(uvec4(0xe6163c7e, 0x3dd7ce3b, 0xf9c3ed9c, 0xcc6299f6), gl_SubgroupInvocationID)) {
                if (gl_LocalInvocationIndex >= inputA.a[cmpIndex3]) {
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10021;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10024;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            break;
        }
        case 4:
        {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10028;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            if (subgroupElect()) {
                {
                    int loopIdx0 = 0;
                    do {
                        loopIdx0++;
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002c;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    } while (loopIdx0 < inputA.a[1]);
                }
            }
            break;
        }
    }



}
#version 450 core
#extension GL_KHR_shader_subgroup_ballot : enable
#extension GL_KHR_shader_subgroup_vote : enable
#extension GL_NV_shader_subgroup_partitioned : enable
#extension GL_EXT_subgroup_uniform_control_flow : enable
layout(local_size_x_id = 0, local_size_y_id = 1, local_size_z = 1) in;
layout(set=0, binding=2) coherent buffer OutputC { uint loc[]; } outputC;
layout(set=0, binding=1) coherent buffer OutputB { uvec4 b[]; } outputB;
layout(set=0, binding=0) coherent buffer InputA  { uint  a[]; } inputA;
layout(push_constant) uniform PC {
   // set to the real stride when writing out ballots, or zero when just counting
   int  invocationStride;
   // wildcard fields, for an example the dimensions of rendered area in the case of graphics shaders
   int  width;
   int  height;
   uint primitiveStride;
   uint subgroupStride;
   uint enableInvocationIndex;
};
int outLoc = 0;
bool testBit(uvec4 mask, uint bit) { return ((mask[bit / 32] >> (bit % 32)) & 1) != 0; }
uint elect() { return int(subgroupElect()) + 1; }
layout(constant_id = 10) const uint cmpIndex0 = 0u;
layout(constant_id = 11) const uint cmpIndex1 = 0u;


void main()
{

    if (testBit(uvec4(0x3750d52a, 0x1615a8dd, 0x4c4903d2, 0x4c9741dd), gl_SubgroupInvocationID)) {
        return;
        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10003;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10006;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
    } else {
        if (testBit(uvec4(0xca3d6b2e, 0x914630b3, 0xb676d508, 0x160db633), gl_SubgroupInvocationID)) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000a;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            {
                int loopIdx0 = 0;
                do {
                    if (subgroupElect()) {
                        break;
                    }
                    loopIdx0++;
                } while (true);
            }
        } else {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000a;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            {
                int loopIdx0 = 0;
                do {
                    if (subgroupElect()) {
                        break;
                    }
                    loopIdx0++;
                } while (true);
            }
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001a;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
    }
    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
        if (subgroupElect()) {
            if (inputA.a[1] == 1) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10020;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            } else {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10020;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            }
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10027;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
    } else {
        if (subgroupElect()) {
            if (inputA.a[0] == 0) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10020;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            } else {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10020;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            }
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10027;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
    }
    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10036;
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();



}
#version 450 core
#extension GL_KHR_shader_subgroup_ballot : enable
#extension GL_KHR_shader_subgroup_vote : enable
#extension GL_NV_shader_subgroup_partitioned : enable
#extension GL_EXT_subgroup_uniform_control_flow : enable
layout(local_size_x_id = 0, local_size_y_id = 1, local_size_z = 1) in;
layout(set=0, binding=2) coherent buffer OutputC { uint loc[]; } outputC;
layout(set=0, binding=1) coherent buffer OutputB { uvec4 b[]; } outputB;
layout(set=0, binding=0) coherent buffer InputA  { uint  a[]; } inputA;
layout(push_constant) uniform PC {
   // set to the real stride when writing out ballots, or zero when just counting
   int  invocationStride;
   // wildcard fields, for an example the dimensions of rendered area in the case of graphics shaders
   int  width;
   int  height;
   uint primitiveStride;
   uint subgroupStride;
   uint enableInvocationIndex;
};
int outLoc = 0;
bool testBit(uvec4 mask, uint bit) { return ((mask[bit / 32] >> (bit % 32)) & 1) != 0; }
uint elect() { return int(subgroupElect()) + 1; }


void main()
{

    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10000;
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
    if (testBit(uvec4(0x5e7c62c7, 0x70aa04d5, 0xd5ac6041, 0xab1a9911), gl_SubgroupInvocationID)) {
        if (subgroupElect()) {
            if (testBit(uvec4(0x5e7c62c7, 0x70aa04d5, 0xd5ac6041, 0xab1a9911), gl_SubgroupInvocationID)) {
                for (int loopIdx0 = 0;
                         loopIdx0 < inputA.a[1];
                         loopIdx0++) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10006;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10009;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                {
                    int loopIdx0 = 0;
                    do {
                        loopIdx0++;
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000c;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    } while (loopIdx0 < inputA.a[3]);
                }
            } else {
                {
                    int loopIdx0 = 0;
                    do {
                        loopIdx0++;
                    } while (loopIdx0 < inputA.a[2]);
                }
                switch (gl_SubgroupInvocationID & 3) {
                    case 0:
                    {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10014;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                        break;
                    }
                    case 1:
                    {
                        break;
                    }
                    case 2:
                    {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001a;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                        break;
                    }
                    case 3:
                    {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001e;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                        break;
                    }
                }
            }
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10024;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
    }
    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10027;
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();



}
#version 450 core
#extension GL_KHR_shader_subgroup_ballot : enable
#extension GL_KHR_shader_subgroup_vote : enable
#extension GL_NV_shader_subgroup_partitioned : enable
#extension GL_EXT_subgroup_uniform_control_flow : enable
layout(local_size_x_id = 0, local_size_y_id = 1, local_size_z = 1) in;
layout(set=0, binding=2) coherent buffer OutputC { uint loc[]; } outputC;
layout(set=0, binding=1) coherent buffer OutputB { uvec4 b[]; } outputB;
layout(set=0, binding=0) coherent buffer InputA  { uint  a[]; } inputA;
layout(push_constant) uniform PC {
   // set to the real stride when writing out ballots, or zero when just counting
   int  invocationStride;
   // wildcard fields, for an example the dimensions of rendered area in the case of graphics shaders
   int  width;
   int  height;
   uint primitiveStride;
   uint subgroupStride;
   uint enableInvocationIndex;
};
int outLoc = 0;
bool testBit(uvec4 mask, uint bit) { return ((mask[bit / 32] >> (bit % 32)) & 1) != 0; }
uint elect() { return int(subgroupElect()) + 1; }
layout(constant_id = 10) const uint cmpIndex0 = 0u;
layout(constant_id = 11) const uint cmpIndex1 = 0u;
layout(constant_id = 12) const uint cmpIndex2 = 0u;
layout(constant_id = 13) const uint cmpIndex3 = 0u;
layout(constant_id = 14) const uint cmpIndex4 = 0u;
layout(constant_id = 15) const uint cmpIndex5 = 0u;
layout(constant_id = 16) const uint cmpIndex6 = 0u;


void main()
{

    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
        switch (gl_SubgroupInvocationID & 3) {
            case 0:
            case 1:
            {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10003;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                if (inputA.a[2] == 2) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10006;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    if (testBit(uvec4(0xd4333cb6, 0x37e22ba5, 0xbf5155f0, 0x67d1e6d4), gl_SubgroupInvocationID)) {
                    }
                    if (inputA.a[0] == 0) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000b;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    } else {
                    }
                }
                break;
            }
            case 2:
            case 3:
            {
                if (inputA.a[3] == 3) {
                    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10014;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    } else {
                    }
                    if (subgroupElect()) {
                    }
                } else {
                    if (testBit(uvec4(0xd4333cb6, 0x37e22ba5, 0xbf5155f0, 0x67d1e6d4), gl_SubgroupInvocationID)) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001c;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    } else {
                    }
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10020;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    if (subgroupElect()) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10023;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    }
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10026;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                }
                for (int loopIdx0 = 0;;loopIdx0++,                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect()) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002a;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    break;
                    if (subgroupElect()) {
                        while (!subgroupElect()) {}
                        if (testBit(uvec4(0x579965e, 0xdcab3315, 0xc6e61baa, 0x8b38dac5), gl_SubgroupInvocationID)) {
                            break;
                        } else {
                            break;
                        }
                    }
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10035;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    if (subgroupElect()) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10038;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    }
                    if (gl_SubgroupInvocationID == loopIdx0) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1003c;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    }
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10040;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                break;
            }
        }
    } else {
        {
            int loopIdx0 = 0;
            do {
                switch (gl_SubgroupInvocationID & 3) {
                    case 0:
                    {
                        if (testBit(uvec4(0xd4333cb6, 0x37e22ba5, 0xbf5155f0, 0x67d1e6d4), gl_SubgroupInvocationID)) {
                        }
                        break;
                    }
                    case 1:
                    {
                        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex2]) {
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1004d;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                        } else {
                        }
                        break;
                    }
                    case 2:
                    {
                        {
                            int loopIdx1 = 0;
                            do {
                                outputC.loc[gl_LocalInvocationIndex]++;
                                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10054;
                                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                                if (subgroupElect()) {
                                    outputC.loc[gl_LocalInvocationIndex]++;
                                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10057;
                                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                                    break;
                                }
                                outputC.loc[gl_LocalInvocationIndex]++;
                                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1005b;
                                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                                loopIdx1++;
                            } while (true);
                        }
                        break;
                    }
                    case 3:
                    {
                        switch (inputA.a[3]) {
                            case 4:
                            {
                                break;
                            }
                            case 3:
                            {
                                outputC.loc[gl_LocalInvocationIndex]++;
                                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10064;
                                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                                break;
                            }
                            case 5:
                            {
                                outputC.loc[gl_LocalInvocationIndex]++;
                                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10068;
                                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                                break;
                            }
                        }
                        break;
                    }
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1006e;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                if (gl_LocalInvocationIndex >= inputA.a[cmpIndex3]) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10071;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex4]) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10074;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    } else {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10077;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    }
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1007a;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    if (gl_SubgroupInvocationID == loopIdx0) {
                    }
                }
                if (subgroupElect()) {
                    break;
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10082;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                if (testBit(uvec4(0xedc86e76, 0xf7f5097c, 0x70d87a0d, 0xa26827a3), gl_SubgroupInvocationID)) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10085;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    {
                        int loopIdx1 = 0;
                        do {
                            loopIdx1++;
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10088;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                        } while (loopIdx1 < inputA.a[1]);
                    }
                    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex5]) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1008c;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    }
                }
                loopIdx0++;
            } while (true);
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10091;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        for (int loopIdx0 = 0;;loopIdx0++,        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect()) {
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex6]) {
                {
                    int loopIdx1 = 0;
                    do {
                        loopIdx1++;
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10096;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    } while (loopIdx1 < inputA.a[2]);
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10099;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                {
                    int loopIdx1 = 0;
                    do {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1009c;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                        if (subgroupElect()) {
                            break;
                        }
                        loopIdx1++;
                    } while (true);
                }
            }
            if (subgroupElect()) {
                for (int loopIdx1 = 0;
                         loopIdx1 < gl_SubgroupInvocationID + 1;
                         loopIdx1++) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x100a5;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                }
                break;
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x100a9;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            }
            if (subgroupElect()) {
                break;
            }
            switch (gl_SubgroupInvocationID & 3) {
                case 0:
                {
                    if (gl_SubgroupInvocationID == loopIdx0) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x100b2;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    }
                    break;
                }
                case 1:
                {
                    switch (loopIdx0) {
                        case 1: {
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x100b9;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                            break;
                        }
                        case 2: {
                            break;
                        }
                        default: {
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x100bf;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                            break;
                        }
                    }
                    break;
                }
                case 2:
                {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x100c5;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    if (inputA.a[0] == 0) {
                    }
                    break;
                }
                case 3:
                {
                    if (testBit(uvec4(0x812c43cc, 0x2f392383, 0xd1212f39, 0x629a3975), gl_SubgroupInvocationID)) {
                    }
                    break;
                }
            }
        }
    }



}
#version 450 core
#extension GL_KHR_shader_subgroup_ballot : enable
#extension GL_KHR_shader_subgroup_vote : enable
#extension GL_NV_shader_subgroup_partitioned : enable
#extension GL_EXT_subgroup_uniform_control_flow : enable
layout(local_size_x_id = 0, local_size_y_id = 1, local_size_z = 1) in;
layout(set=0, binding=2) coherent buffer OutputC { uint loc[]; } outputC;
layout(set=0, binding=1) coherent buffer OutputB { uvec4 b[]; } outputB;
layout(set=0, binding=0) coherent buffer InputA  { uint  a[]; } inputA;
layout(push_constant) uniform PC {
   // set to the real stride when writing out ballots, or zero when just counting
   int  invocationStride;
   // wildcard fields, for an example the dimensions of rendered area in the case of graphics shaders
   int  width;
   int  height;
   uint primitiveStride;
   uint subgroupStride;
   uint enableInvocationIndex;
};
int outLoc = 0;
bool testBit(uvec4 mask, uint bit) { return ((mask[bit / 32] >> (bit % 32)) & 1) != 0; }
uint elect() { return int(subgroupElect()) + 1; }
layout(constant_id = 10) const uint cmpIndex0 = 0u;
layout(constant_id = 11) const uint cmpIndex1 = 0u;
layout(constant_id = 12) const uint cmpIndex2 = 0u;
layout(constant_id = 13) const uint cmpIndex3 = 0u;
layout(constant_id = 14) const uint cmpIndex4 = 0u;
layout(constant_id = 15) const uint cmpIndex5 = 0u;
layout(constant_id = 16) const uint cmpIndex6 = 0u;
layout(constant_id = 17) const uint cmpIndex7 = 0u;
layout(constant_id = 18) const uint cmpIndex8 = 0u;
layout(constant_id = 19) const uint cmpIndex9 = 0u;
layout(constant_id = 20) const uint cmpIndex10 = 0u;
layout(constant_id = 21) const uint cmpIndex11 = 0u;
layout(constant_id = 22) const uint cmpIndex12 = 0u;
layout(constant_id = 23) const uint cmpIndex13 = 0u;
layout(constant_id = 24) const uint cmpIndex14 = 0u;
layout(constant_id = 25) const uint cmpIndex15 = 0u;
layout(constant_id = 26) const uint cmpIndex16 = 0u;


void main()
{

    {
        int loopIdx0 = 0;
        do {
            loopIdx0++;
            return;
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10002;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        } while (loopIdx0 < inputA.a[5]);
    }
    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10006;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        if (testBit(uvec4(0x91b3bcd8, 0x6a4b0e01, 0x2033a7ef, 0xef82cc51), gl_SubgroupInvocationID)) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10009;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
                {
                    int loopIdx0 = 0;
                    do {
                        loopIdx0++;
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000d;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    } while (loopIdx0 < inputA.a[5]);
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10010;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                if (gl_LocalInvocationIndex >= inputA.a[cmpIndex2]) {
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10014;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            } else {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10017;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                if (gl_LocalInvocationIndex >= inputA.a[cmpIndex3]) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001a;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001d;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                if (inputA.a[2] == 2) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10020;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                }
            }
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex4]) {
                for (int loopIdx0 = 0;
                         loopIdx0 < inputA.a[1];
                         loopIdx0++) {
                }
                while (!subgroupElect()) {}
                {
                    int loopIdx0 = 0;
                    do {
                        if (subgroupElect()) {
                            break;
                        }
                        loopIdx0++;
                    } while (true);
                }
            } else {
                if (gl_LocalInvocationIndex >= inputA.a[cmpIndex5]) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002f;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                } else {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10032;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                }
                switch (gl_SubgroupInvocationID & 3) {
                    case 0:
                    case 1:
                    {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10037;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                        break;
                    }
                    case 2:
                    case 3:
                    {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1003b;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                        break;
                    }
                }
            }
        } else {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10009;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex6]) {
                {
                    int loopIdx0 = 0;
                    do {
                        loopIdx0++;
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000d;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    } while (loopIdx0 < inputA.a[5]);
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10010;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                if (gl_LocalInvocationIndex >= inputA.a[cmpIndex7]) {
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10014;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            } else {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10017;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                if (gl_LocalInvocationIndex >= inputA.a[cmpIndex8]) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001a;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001d;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                if (inputA.a[0] == 0) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10020;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                }
            }
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex9]) {
                for (int loopIdx0 = 0;
                         loopIdx0 < inputA.a[1];
                         loopIdx0++) {
                }
                while (!subgroupElect()) {}
                {
                    int loopIdx0 = 0;
                    do {
                        if (subgroupElect()) {
                            break;
                        }
                        loopIdx0++;
                    } while (true);
                }
            } else {
                if (gl_LocalInvocationIndex >= inputA.a[cmpIndex10]) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002f;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                } else {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10032;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                }
                switch (gl_SubgroupInvocationID & 3) {
                    case 0:
                    case 1:
                    {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10037;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                        break;
                    }
                    case 2:
                    case 3:
                    {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1003b;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                        break;
                    }
                }
            }
        }
        {
            int loopIdx0 = 0;
            do {
                if (gl_LocalInvocationIndex >= inputA.a[cmpIndex11]) {
                    for (int loopIdx1 = 0;
                             loopIdx1 < gl_SubgroupInvocationID + 1;
                             loopIdx1++) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1007c;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    }
                } else {
                    for (int loopIdx1 = 0;
                             loopIdx1 < gl_SubgroupInvocationID + 1;
                             loopIdx1++) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1007c;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    }
                }
                if (gl_SubgroupInvocationID == loopIdx0) {
                    if (testBit(uvec4(0xede2dc2c, 0xdcb30010, 0x2ebc3846, 0x63a3bd92), gl_SubgroupInvocationID)) {
                        break;
                    } else {
                        break;
                    }
                    if (inputA.a[0] == 0) {
                    }
                }
                if (subgroupElect()) {
                    break;
                }
                if (testBit(uvec4(0x1e63b50d, 0x123a9eee, 0x5acbdd0b, 0xe77a12d4), gl_SubgroupInvocationID)) {
                    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex12]) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10093;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    } else {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10096;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    }
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10099;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    if (gl_SubgroupInvocationID == loopIdx0) {
                    } else {
                    }
                } else {
                    if (gl_SubgroupInvocationID == loopIdx0) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x100a0;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    } else {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x100a3;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    }
                    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex13]) {
                    }
                }
                {
                    int loopIdx1 = 0;
                    do {
                        break;
                        for (int loopIdx2 = 0;
                                 loopIdx2 < inputA.a[4];
                                 loopIdx2++) {
                        }
                        if (subgroupElect()) {
                            break;
                        }
                        if (gl_SubgroupInvocationID == loopIdx1) {
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x100b1;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                        }
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x100b4;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                        if (testBit(uvec4(0x1e63b50d, 0x123a9eee, 0x5acbdd0b, 0xe77a12d4), gl_SubgroupInvocationID)) {
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x100b7;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                        }
                        loopIdx1++;
                    } while (true);
                }
                loopIdx0++;
            } while (true);
        }
    } else {
        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex14]) {
            for (int loopIdx0 = 0;
                     loopIdx0 < gl_SubgroupInvocationID + 1;
                     loopIdx0++) {
                switch (gl_SubgroupInvocationID & 3) {
                    case 0:
                    case 1:
                    {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x100c1;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                        break;
                    }
                    case 2:
                    case 3:
                    {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x100c5;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                        break;
                    }
                }
                switch (loopIdx0) {
                    case 1: {
                        break;
                    }
                    case 2: {
                        break;
                    }
                    default: {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x100cf;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                        break;
                    }
                }
            }
            if (inputA.a[2] == 2) {
                if (gl_LocalInvocationIndex >= inputA.a[cmpIndex15]) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x100d6;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                } else {
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x100da;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            }
        } else {
            if (testBit(uvec4(0x1e63b50d, 0x123a9eee, 0x5acbdd0b, 0xe77a12d4), gl_SubgroupInvocationID)) {
                if (gl_LocalInvocationIndex >= inputA.a[cmpIndex16]) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x100e0;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                }
                {
                    int loopIdx0 = 0;
                    do {
                        if (subgroupElect()) {
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x100e5;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                            if (testBit(uvec4(0xede2dc2c, 0xdcb30010, 0x2ebc3846, 0x63a3bd92), gl_SubgroupInvocationID)) {
                                break;
                            } else {
                                break;
                            }
                        }
                        loopIdx0++;
                    } while (true);
                }
            }
        }
    }



}
#version 450 core
#extension GL_KHR_shader_subgroup_ballot : enable
#extension GL_KHR_shader_subgroup_vote : enable
#extension GL_NV_shader_subgroup_partitioned : enable
#extension GL_EXT_subgroup_uniform_control_flow : enable
layout(local_size_x_id = 0, local_size_y_id = 1, local_size_z = 1) in;
layout(set=0, binding=2) coherent buffer OutputC { uint loc[]; } outputC;
layout(set=0, binding=1) coherent buffer OutputB { uvec4 b[]; } outputB;
layout(set=0, binding=0) coherent buffer InputA  { uint  a[]; } inputA;
layout(push_constant) uniform PC {
   // set to the real stride when writing out ballots, or zero when just counting
   int  invocationStride;
   // wildcard fields, for an example the dimensions of rendered area in the case of graphics shaders
   int  width;
   int  height;
   uint primitiveStride;
   uint subgroupStride;
   uint enableInvocationIndex;
};
int outLoc = 0;
bool testBit(uvec4 mask, uint bit) { return ((mask[bit / 32] >> (bit % 32)) & 1) != 0; }
uint elect() { return int(subgroupElect()) + 1; }


void main()
{

    for (int loopIdx0 = 0;;loopIdx0++,    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect()) {
        break;
        if (gl_SubgroupInvocationID == loopIdx0) {
            if (inputA.a[3] == 3) {
                if (testBit(uvec4(0xe3e6077b, 0x934d4176, 0x44df3f14, 0x16bfbe39), gl_SubgroupInvocationID)) {
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10006;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                for (int loopIdx1 = 0;
                         loopIdx1 < inputA.a[2];
                         loopIdx1++) {
                }
            } else {
                if (gl_SubgroupInvocationID == loopIdx0) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000c;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                } else {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000f;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                }
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10013;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            if (inputA.a[3] == 3) {
                break;
                {
                    int loopIdx1 = 0;
                    do {
                        loopIdx1++;
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10018;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    } while (loopIdx1 < inputA.a[3]);
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001b;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            }
        } else {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001f;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            if (gl_SubgroupInvocationID == loopIdx0) {
                if (testBit(uvec4(0xbdeae9f, 0x37d0c6ef, 0x9f4cb738, 0x54c6189a), gl_SubgroupInvocationID)) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10023;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                }
                if (inputA.a[2] == 2) {
                } else {
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10029;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            } else {
                if (inputA.a[0] == 12345) {
                    while (true) {
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    }
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002d;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                if (testBit(uvec4(0xe3e6077b, 0x934d4176, 0x44df3f14, 0x16bfbe39), gl_SubgroupInvocationID)) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10030;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10033;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10036;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        }
        if (subgroupElect()) {
            break;
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1003c;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        break;
    }



}
#version 450 core
#extension GL_KHR_shader_subgroup_ballot : enable
#extension GL_KHR_shader_subgroup_vote : enable
#extension GL_NV_shader_subgroup_partitioned : enable
#extension GL_EXT_subgroup_uniform_control_flow : enable
layout(local_size_x_id = 0, local_size_y_id = 1, local_size_z = 1) in;
layout(set=0, binding=2) coherent buffer OutputC { uint loc[]; } outputC;
layout(set=0, binding=1) coherent buffer OutputB { uvec4 b[]; } outputB;
layout(set=0, binding=0) coherent buffer InputA  { uint  a[]; } inputA;
layout(push_constant) uniform PC {
   // set to the real stride when writing out ballots, or zero when just counting
   int  invocationStride;
   // wildcard fields, for an example the dimensions of rendered area in the case of graphics shaders
   int  width;
   int  height;
   uint primitiveStride;
   uint subgroupStride;
   uint enableInvocationIndex;
};
int outLoc = 0;
bool testBit(uvec4 mask, uint bit) { return ((mask[bit / 32] >> (bit % 32)) & 1) != 0; }
uint elect() { return int(subgroupElect()) + 1; }
layout(constant_id = 10) const uint cmpIndex0 = 0u;
layout(constant_id = 11) const uint cmpIndex1 = 0u;
layout(constant_id = 12) const uint cmpIndex2 = 0u;
layout(constant_id = 13) const uint cmpIndex3 = 0u;
layout(constant_id = 14) const uint cmpIndex4 = 0u;


void main()
{

    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10001;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        {
            int loopIdx0 = 0;
            do {
                {
                    int loopIdx1 = 0;
                    do {
                        loopIdx1++;
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10005;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                        break;
                        if (inputA.a[0] == 0) {
                        } else {
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000a;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                        }
                    } while (loopIdx1 < inputA.a[4]);
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000e;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                if (gl_SubgroupInvocationID == loopIdx0) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10011;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10014;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    } else {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10017;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    }
                }
                if (subgroupElect()) {
                    break;
                }
                if (inputA.a[0] == 0) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001f;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    for (int loopIdx1 = 0;
                             loopIdx1 < inputA.a[1];
                             loopIdx1++) {
                    }
                } else {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10024;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    switch (loopIdx0) {
                        case 1: {
                            break;
                        }
                        case 2: {
                            break;
                        }
                        default: {
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002c;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                            break;
                        }
                    }
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10031;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                if (testBit(uvec4(0xb0caba39, 0xdcbca1e5, 0x73e934e7, 0x3e8bc839), gl_SubgroupInvocationID)) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10034;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    if (subgroupElect()) {
                    }
                } else {
                    {
                        int loopIdx1 = 0;
                        do {
                            if (subgroupElect()) {
                                outputC.loc[gl_LocalInvocationIndex]++;
                                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1003b;
                                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                                break;
                            }
                            loopIdx1++;
                        } while (true);
                    }
                }
                loopIdx0++;
            } while (true);
        }
        if (inputA.a[3] == 3) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10043;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            for (int loopIdx0 = 0;;loopIdx0++,            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect()) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10046;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                if (subgroupElect()) {
                    break;
                }
                for (int loopIdx1 = 0;
                         loopIdx1 < gl_SubgroupInvocationID + 1;
                         loopIdx1++) {
                }
                break;
            }
        } else {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10050;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10053;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
    } else {
        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex2]) {
            if (inputA.a[2] == 2) {
                if (subgroupElect()) {
                }
                {
                    int loopIdx0 = 0;
                    do {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1005b;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                        if (subgroupElect()) {
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1005e;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                            break;
                        }
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10062;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                        loopIdx0++;
                    } while (true);
                }
            }
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex3]) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10067;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                if (gl_LocalInvocationIndex >= inputA.a[cmpIndex4]) {
                } else {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1006b;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                }
            }
        }
    }



}
#version 450 core
#extension GL_KHR_shader_subgroup_ballot : enable
#extension GL_KHR_shader_subgroup_vote : enable
#extension GL_NV_shader_subgroup_partitioned : enable
#extension GL_EXT_subgroup_uniform_control_flow : enable
layout(local_size_x_id = 0, local_size_y_id = 1, local_size_z = 1) in;
layout(set=0, binding=2) coherent buffer OutputC { uint loc[]; } outputC;
layout(set=0, binding=1) coherent buffer OutputB { uvec4 b[]; } outputB;
layout(set=0, binding=0) coherent buffer InputA  { uint  a[]; } inputA;
layout(push_constant) uniform PC {
   // set to the real stride when writing out ballots, or zero when just counting
   int  invocationStride;
   // wildcard fields, for an example the dimensions of rendered area in the case of graphics shaders
   int  width;
   int  height;
   uint primitiveStride;
   uint subgroupStride;
   uint enableInvocationIndex;
};
int outLoc = 0;
bool testBit(uvec4 mask, uint bit) { return ((mask[bit / 32] >> (bit % 32)) & 1) != 0; }
uint elect() { return int(subgroupElect()) + 1; }
layout(constant_id = 10) const uint cmpIndex0 = 0u;
layout(constant_id = 11) const uint cmpIndex1 = 0u;
layout(constant_id = 12) const uint cmpIndex2 = 0u;
layout(constant_id = 13) const uint cmpIndex3 = 0u;


void main()
{

    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10000;
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
    if (inputA.a[0] == 0) {
        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
            if (testBit(uvec4(0xf77511fe, 0x9ecaa8ed, 0x511db92f, 0x8ad08538), gl_SubgroupInvocationID)) {
                if (subgroupElect()) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10006;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                }
                switch (gl_SubgroupInvocationID & 3) {
                    case 0:
                    {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000b;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                        break;
                    }
                    case 1:
                    {
                        break;
                    }
                    case 2:
                    {
                        break;
                    }
                    case 3:
                    {
                        break;
                    }
                }
            } else {
                for (int loopIdx0 = 0;
                         loopIdx0 < gl_SubgroupInvocationID + 1;
                         loopIdx0++) {
                    if (inputA.a[0] == 12345) {
                        while (true) {
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                        }
                    }
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10019;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                if (subgroupElect()) {
                }
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001e;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        } else {
            if (testBit(uvec4(0xf77511fe, 0x9ecaa8ed, 0x511db92f, 0x8ad08538), gl_SubgroupInvocationID)) {
                if (subgroupElect()) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10006;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                }
                switch (gl_SubgroupInvocationID & 3) {
                    case 0:
                    {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000b;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                        break;
                    }
                    case 1:
                    {
                        break;
                    }
                    case 2:
                    {
                        break;
                    }
                    case 3:
                    {
                        break;
                    }
                }
            } else {
                for (int loopIdx0 = 0;
                         loopIdx0 < gl_SubgroupInvocationID + 1;
                         loopIdx0++) {
                    if (inputA.a[0] == 12345) {
                        while (true) {
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                        }
                    }
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10019;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                if (subgroupElect()) {
                }
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001e;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1003e;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
    } else {
        if (subgroupElect()) {
            switch (inputA.a[3]) {
                case 4:
                {
                    if (subgroupElect()) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10045;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    }
                    break;
                }
                case 3:
                {
                    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1004b;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    } else {
                    }
                    return;
                    break;
                }
                case 5:
                {
                    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex2]) {
                    } else {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10054;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    }
                    break;
                }
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10059;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            for (int loopIdx0 = 0;
                     loopIdx0 < inputA.a[2];
                     loopIdx0++) {
                for (int loopIdx1 = 0;
                         loopIdx1 < gl_SubgroupInvocationID + 1;
                         loopIdx1++) {
                }
                if (inputA.a[3] == 3) {
                }
            }
        }
        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex3]) {
            if (testBit(uvec4(0x9e19d960, 0xdc84f6e8, 0x5cf95d28, 0x1058dec4), gl_SubgroupInvocationID)) {
                if (inputA.a[2] == 2) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10065;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10068;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                switch (gl_SubgroupInvocationID & 3) {
                    case 0:
                    case 1:
                    {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1006c;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                        break;
                    }
                    case 2:
                    case 3:
                    {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10070;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                        break;
                    }
                }
            }
            switch (gl_SubgroupInvocationID & 3) {
                case 0:
                case 1:
                {
                    if (testBit(uvec4(0xf7b3ccb6, 0xa731d3e9, 0xb74d8b76, 0x21cb827a), gl_SubgroupInvocationID)) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10078;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    }
                    break;
                }
                case 2:
                case 3:
                {
                    for (int loopIdx0 = 0;
                             loopIdx0 < inputA.a[4];
                             loopIdx0++) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1007e;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    }
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10081;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    if (inputA.a[0] == 0) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10084;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    }
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10087;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    break;
                }
            }
        }
    }
    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1008d;
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();



}
#version 450 core
#extension GL_KHR_shader_subgroup_ballot : enable
#extension GL_KHR_shader_subgroup_vote : enable
#extension GL_NV_shader_subgroup_partitioned : enable
#extension GL_EXT_subgroup_uniform_control_flow : enable
layout(local_size_x_id = 0, local_size_y_id = 1, local_size_z = 1) in;
layout(set=0, binding=2) coherent buffer OutputC { uint loc[]; } outputC;
layout(set=0, binding=1) coherent buffer OutputB { uvec4 b[]; } outputB;
layout(set=0, binding=0) coherent buffer InputA  { uint  a[]; } inputA;
layout(push_constant) uniform PC {
   // set to the real stride when writing out ballots, or zero when just counting
   int  invocationStride;
   // wildcard fields, for an example the dimensions of rendered area in the case of graphics shaders
   int  width;
   int  height;
   uint primitiveStride;
   uint subgroupStride;
   uint enableInvocationIndex;
};
int outLoc = 0;
bool testBit(uvec4 mask, uint bit) { return ((mask[bit / 32] >> (bit % 32)) & 1) != 0; }
uint elect() { return int(subgroupElect()) + 1; }
layout(constant_id = 10) const uint cmpIndex0 = 0u;
layout(constant_id = 11) const uint cmpIndex1 = 0u;
layout(constant_id = 12) const uint cmpIndex2 = 0u;
layout(constant_id = 13) const uint cmpIndex3 = 0u;
layout(constant_id = 14) const uint cmpIndex4 = 0u;


void main()
{

    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10000;
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
    switch (inputA.a[2]) {
        case 3:
        {
            if (subgroupElect()) {
                {
                    int loopIdx0 = 0;
                    do {
                        loopIdx0++;
                        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
                        }
                        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10009;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                        } else {
                        }
                    } while (loopIdx0 < inputA.a[3]);
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000e;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                {
                    int loopIdx0 = 0;
                    do {
                        if (gl_SubgroupInvocationID == loopIdx0) {
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10012;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                        } else {
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10012;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                        }
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10018;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                        if (subgroupElect()) {
                        }
                        if (subgroupElect()) {
                            break;
                        }
                        if (subgroupElect()) {
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10020;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                        }
                        if (testBit(uvec4(0x47437516, 0xdc8cc7ef, 0x85e228f4, 0xc902798b), gl_SubgroupInvocationID)) {
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10024;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                        } else {
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10027;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                        }
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002a;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                        loopIdx0++;
                    } while (true);
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002d;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            }
            break;
        }
        case 2:
        {
            switch (gl_SubgroupInvocationID & 3) {
                case 0:
                {
                    if (subgroupElect()) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10035;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                        switch (inputA.a[3]) {
                            case 4:
                            {
                                break;
                            }
                            case 3:
                            {
                                break;
                            }
                            case 5:
                            {
                                break;
                            }
                        }
                    }
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10040;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    break;
                }
                case 1:
                {
                    break;
                }
                case 2:
                {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10046;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    if (testBit(uvec4(0xc8626f10, 0x4b547ee1, 0xd59c011f, 0x36238fad), gl_SubgroupInvocationID)) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10049;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                        switch (gl_SubgroupInvocationID & 3) {
                            case 0:
                            case 1:
                            {
                                break;
                            }
                            case 2:
                            case 3:
                            {
                                outputC.loc[gl_LocalInvocationIndex]++;
                                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1004f;
                                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                                break;
                            }
                        }
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10053;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    } else {
                        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex2]) {
                        }
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10058;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    }
                    break;
                }
                case 3:
                {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1005d;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    break;
                }
            }
            {
                int loopIdx0 = 0;
                do {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10062;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    if (subgroupElect()) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10065;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                        break;
                    }
                    if (subgroupElect()) {
                        switch (gl_SubgroupInvocationID & 3) {
                            case 0:
                            case 1:
                            {
                                break;
                            }
                            case 2:
                            case 3:
                            {
                                break;
                            }
                        }
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10070;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                        break;
                    }
                    if (testBit(uvec4(0x2d447467, 0x7ae64289, 0x13784927, 0xf531f510), gl_SubgroupInvocationID)) {
                        if (inputA.a[0] == 0) {
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10076;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                        } else {
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10079;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                        }
                        switch (inputA.a[1]) {
                            case 2:
                            {
                                break;
                            }
                            case 1:
                            {
                                outputC.loc[gl_LocalInvocationIndex]++;
                                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10080;
                                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                                break;
                            }
                            case 3:
                            {
                                break;
                            }
                        }
                    } else {
                        break;
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10088;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                        if (testBit(uvec4(0xc8626f10, 0x4b547ee1, 0xd59c011f, 0x36238fad), gl_SubgroupInvocationID)) {
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1008b;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                        } else {
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1008e;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                        }
                    }
                    loopIdx0++;
                } while (true);
            }
            break;
        }
        case 4:
        {
            if (inputA.a[0] == 0) {
                if (gl_LocalInvocationIndex >= inputA.a[cmpIndex3]) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10097;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    {
                        int loopIdx0 = 0;
                        do {
                            loopIdx0++;
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1009a;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                        } while (loopIdx0 < inputA.a[4]);
                    }
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1009d;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex4]) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x100a0;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    } else {
                    }
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x100a5;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            }
            break;
        }
    }



}
#version 450 core
#extension GL_KHR_shader_subgroup_ballot : enable
#extension GL_KHR_shader_subgroup_vote : enable
#extension GL_NV_shader_subgroup_partitioned : enable
#extension GL_EXT_subgroup_uniform_control_flow : enable
layout(local_size_x_id = 0, local_size_y_id = 1, local_size_z = 1) in;
layout(set=0, binding=2) coherent buffer OutputC { uint loc[]; } outputC;
layout(set=0, binding=1) coherent buffer OutputB { uvec4 b[]; } outputB;
layout(set=0, binding=0) coherent buffer InputA  { uint  a[]; } inputA;
layout(push_constant) uniform PC {
   // set to the real stride when writing out ballots, or zero when just counting
   int  invocationStride;
   // wildcard fields, for an example the dimensions of rendered area in the case of graphics shaders
   int  width;
   int  height;
   uint primitiveStride;
   uint subgroupStride;
   uint enableInvocationIndex;
};
int outLoc = 0;
bool testBit(uvec4 mask, uint bit) { return ((mask[bit / 32] >> (bit % 32)) & 1) != 0; }
uint elect() { return int(subgroupElect()) + 1; }
layout(constant_id = 10) const uint cmpIndex0 = 0u;
layout(constant_id = 11) const uint cmpIndex1 = 0u;
layout(constant_id = 12) const uint cmpIndex2 = 0u;


void main()
{

    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
        if (testBit(uvec4(0x467d6e76, 0x4b45c110, 0xdc26e53e, 0xc4601a6e), gl_SubgroupInvocationID)) {
            for (int loopIdx0 = 0;;loopIdx0++,            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect()) {
                for (int loopIdx1 = 0;
                         loopIdx1 < inputA.a[5];
                         loopIdx1++) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10004;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                }
                switch (loopIdx0) {
                    case 1: {
                        break;
                    }
                    case 2: {
                        break;
                    }
                    default: {
                        break;
                    }
                }
                if (subgroupElect()) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10010;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    break;
                }
                if (subgroupElect()) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10015;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                }
                if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10019;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                } else {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001c;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001f;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            }
        }
    } else {
        if (testBit(uvec4(0x467d6e76, 0x4b45c110, 0xdc26e53e, 0xc4601a6e), gl_SubgroupInvocationID)) {
            for (int loopIdx0 = 0;;loopIdx0++,            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect()) {
                for (int loopIdx1 = 0;
                         loopIdx1 < inputA.a[5];
                         loopIdx1++) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10004;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                }
                switch (loopIdx0) {
                    case 1: {
                        break;
                    }
                    case 2: {
                        break;
                    }
                    default: {
                        break;
                    }
                }
                if (subgroupElect()) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10010;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    break;
                }
                if (subgroupElect()) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10015;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                }
                if (gl_LocalInvocationIndex >= inputA.a[cmpIndex2]) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10019;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                } else {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001c;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001f;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            }
        }
    }



}
#version 450 core
#extension GL_KHR_shader_subgroup_ballot : enable
#extension GL_KHR_shader_subgroup_vote : enable
#extension GL_NV_shader_subgroup_partitioned : enable
#extension GL_EXT_subgroup_uniform_control_flow : enable
layout(local_size_x_id = 0, local_size_y_id = 1, local_size_z = 1) in;
layout(set=0, binding=2) coherent buffer OutputC { uint loc[]; } outputC;
layout(set=0, binding=1) coherent buffer OutputB { uvec4 b[]; } outputB;
layout(set=0, binding=0) coherent buffer InputA  { uint  a[]; } inputA;
layout(push_constant) uniform PC {
   // set to the real stride when writing out ballots, or zero when just counting
   int  invocationStride;
   // wildcard fields, for an example the dimensions of rendered area in the case of graphics shaders
   int  width;
   int  height;
   uint primitiveStride;
   uint subgroupStride;
   uint enableInvocationIndex;
};
int outLoc = 0;
bool testBit(uvec4 mask, uint bit) { return ((mask[bit / 32] >> (bit % 32)) & 1) != 0; }
uint elect() { return int(subgroupElect()) + 1; }
layout(constant_id = 10) const uint cmpIndex0 = 0u;
layout(constant_id = 11) const uint cmpIndex1 = 0u;
layout(constant_id = 12) const uint cmpIndex2 = 0u;


void main()
{

    if (inputA.a[2] == 2) {
        for (int loopIdx0 = 0;
                 loopIdx0 < gl_SubgroupInvocationID + 1;
                 loopIdx0++) {
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10003;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        {
            int loopIdx0 = 0;
            do {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10006;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                if (subgroupElect()) {
                    break;
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000b;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                loopIdx0++;
            } while (true);
        }
    } else {
        for (int loopIdx0 = 0;
                 loopIdx0 < inputA.a[3];
                 loopIdx0++) {
        }
        if (testBit(uvec4(0xcfbc2897, 0xfc76d7d0, 0x3a289c17, 0xb008b37a), gl_SubgroupInvocationID)) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10012;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        } else {
        }
    }
    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10017;
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001b;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        }
        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex2]) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001f;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        }
    }



}
#version 450 core
#extension GL_KHR_shader_subgroup_ballot : enable
#extension GL_KHR_shader_subgroup_vote : enable
#extension GL_NV_shader_subgroup_partitioned : enable
#extension GL_EXT_subgroup_uniform_control_flow : enable
layout(local_size_x_id = 0, local_size_y_id = 1, local_size_z = 1) in;
layout(set=0, binding=2) coherent buffer OutputC { uint loc[]; } outputC;
layout(set=0, binding=1) coherent buffer OutputB { uvec4 b[]; } outputB;
layout(set=0, binding=0) coherent buffer InputA  { uint  a[]; } inputA;
layout(push_constant) uniform PC {
   // set to the real stride when writing out ballots, or zero when just counting
   int  invocationStride;
   // wildcard fields, for an example the dimensions of rendered area in the case of graphics shaders
   int  width;
   int  height;
   uint primitiveStride;
   uint subgroupStride;
   uint enableInvocationIndex;
};
int outLoc = 0;
bool testBit(uvec4 mask, uint bit) { return ((mask[bit / 32] >> (bit % 32)) & 1) != 0; }
uint elect() { return int(subgroupElect()) + 1; }
layout(constant_id = 10) const uint cmpIndex0 = 0u;


void main()
{

    if (testBit(uvec4(0x579965e, 0xdcab3315, 0xc6e61baa, 0x8b38dac5), gl_SubgroupInvocationID)) {
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10001;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
    } else {
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10004;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        if (inputA.a[1] == 1) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10007;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        } else {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10007;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        }
        if (inputA.a[1] == 1) {
        }
    }
    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10010;
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
    if (subgroupElect()) {
        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10014;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        } else {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10017;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        }
        for (int loopIdx0 = 0;;loopIdx0++,        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true)) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001b;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            if (subgroupElect()) {
                break;
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10020;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10023;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
    }



}
#version 450 core
#extension GL_KHR_shader_subgroup_ballot : enable
#extension GL_KHR_shader_subgroup_vote : enable
#extension GL_NV_shader_subgroup_partitioned : enable
#extension GL_EXT_subgroup_uniform_control_flow : enable
layout(local_size_x_id = 0, local_size_y_id = 1, local_size_z = 1) in;
layout(set=0, binding=2) coherent buffer OutputC { uint loc[]; } outputC;
layout(set=0, binding=1) coherent buffer OutputB { uvec4 b[]; } outputB;
layout(set=0, binding=0) coherent buffer InputA  { uint  a[]; } inputA;
layout(push_constant) uniform PC {
   // set to the real stride when writing out ballots, or zero when just counting
   int  invocationStride;
   // wildcard fields, for an example the dimensions of rendered area in the case of graphics shaders
   int  width;
   int  height;
   uint primitiveStride;
   uint subgroupStride;
   uint enableInvocationIndex;
};
int outLoc = 0;
bool testBit(uvec4 mask, uint bit) { return ((mask[bit / 32] >> (bit % 32)) & 1) != 0; }
uint elect() { return int(subgroupElect()) + 1; }
layout(constant_id = 10) const uint cmpIndex0 = 0u;
layout(constant_id = 11) const uint cmpIndex1 = 0u;


void main()
{

    {
        int loopIdx0 = 0;
        do {
            loopIdx0++;
            return;
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10002;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        } while (loopIdx0 < inputA.a[5]);
    }
    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10006;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        if (testBit(uvec4(0x91b3bcd8, 0x6a4b0e01, 0x2033a7ef, 0xef82cc51), gl_SubgroupInvocationID)) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10009;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000c;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
    }
    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000f;
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
        {
            int loopIdx0 = 0;
            do {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10013;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                if (subgroupElect()) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10016;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    break;
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001a;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                loopIdx0++;
            } while (true);
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001d;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
    } else {
        {
            int loopIdx0 = 0;
            do {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10013;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                if (subgroupElect()) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10016;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    break;
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001a;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                loopIdx0++;
            } while (true);
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001d;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
    }
    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002e;
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);



}
#version 450 core
#extension GL_KHR_shader_subgroup_ballot : enable
#extension GL_KHR_shader_subgroup_vote : enable
#extension GL_NV_shader_subgroup_partitioned : enable
#extension GL_EXT_subgroup_uniform_control_flow : enable
layout(local_size_x_id = 0, local_size_y_id = 1, local_size_z = 1) in;
layout(set=0, binding=2) coherent buffer OutputC { uint loc[]; } outputC;
layout(set=0, binding=1) coherent buffer OutputB { uvec4 b[]; } outputB;
layout(set=0, binding=0) coherent buffer InputA  { uint  a[]; } inputA;
layout(push_constant) uniform PC {
   // set to the real stride when writing out ballots, or zero when just counting
   int  invocationStride;
   // wildcard fields, for an example the dimensions of rendered area in the case of graphics shaders
   int  width;
   int  height;
   uint primitiveStride;
   uint subgroupStride;
   uint enableInvocationIndex;
};
int outLoc = 0;
bool testBit(uvec4 mask, uint bit) { return ((mask[bit / 32] >> (bit % 32)) & 1) != 0; }
uint elect() { return int(subgroupElect()) + 1; }


void main()
{

    for (int loopIdx0 = 0;;loopIdx0++,    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true)) {
        break;
        if (gl_SubgroupInvocationID == loopIdx0) {
        }
        if (subgroupElect()) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10005;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            break;
        }
        if (testBit(uvec4(0x5664d7eb, 0xdcbb511b, 0x9578e94b, 0xd825b137), gl_SubgroupInvocationID)) {
            break;
        } else {
            break;
        }
        if (subgroupElect()) {
        }
    }
    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10011;
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
    for (int loopIdx0 = 0;
             loopIdx0 < gl_SubgroupInvocationID + 1;
             loopIdx0++) {
        if (inputA.a[3] == 3) {
        }
        switch (loopIdx0) {
            case 1: {
                break;
            }
            case 2: {
                break;
            }
            default: {
                break;
            }
        }
    }



}
#version 450 core
#extension GL_KHR_shader_subgroup_ballot : enable
#extension GL_KHR_shader_subgroup_vote : enable
#extension GL_NV_shader_subgroup_partitioned : enable
#extension GL_EXT_subgroup_uniform_control_flow : enable
layout(local_size_x_id = 0, local_size_y_id = 1, local_size_z = 1) in;
layout(set=0, binding=2) coherent buffer OutputC { uint loc[]; } outputC;
layout(set=0, binding=1) coherent buffer OutputB { uvec4 b[]; } outputB;
layout(set=0, binding=0) coherent buffer InputA  { uint  a[]; } inputA;
layout(push_constant) uniform PC {
   // set to the real stride when writing out ballots, or zero when just counting
   int  invocationStride;
   // wildcard fields, for an example the dimensions of rendered area in the case of graphics shaders
   int  width;
   int  height;
   uint primitiveStride;
   uint subgroupStride;
   uint enableInvocationIndex;
};
int outLoc = 0;
bool testBit(uvec4 mask, uint bit) { return ((mask[bit / 32] >> (bit % 32)) & 1) != 0; }
uint elect() { return int(subgroupElect()) + 1; }
layout(constant_id = 10) const uint cmpIndex0 = 0u;


void main()
{

    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10000;
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
        if (subgroupElect()) {
        }
        {
            int loopIdx0 = 0;
            do {
                if (subgroupElect()) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10007;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    break;
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000b;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                loopIdx0++;
            } while (true);
        }
    }
    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000f;
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
    for (int loopIdx0 = 0;;loopIdx0++,    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true)) {
        switch (gl_SubgroupInvocationID & 3) {
            case 0:
            case 1:
            {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10014;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                break;
            }
            case 2:
            case 3:
            {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10018;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                break;
            }
        }
        for (int loopIdx1 = 0;;loopIdx1++,        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true)) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001d;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            if (subgroupElect()) {
                break;
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10022;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        }
        if (subgroupElect()) {
            break;
        }
        if (subgroupElect()) {
        }
        if (gl_SubgroupInvocationID == loopIdx0) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002b;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        } else {
        }
    }



}
#version 450 core
#extension GL_KHR_shader_subgroup_ballot : enable
#extension GL_KHR_shader_subgroup_vote : enable
#extension GL_NV_shader_subgroup_partitioned : enable
#extension GL_EXT_subgroup_uniform_control_flow : enable
layout(local_size_x_id = 0, local_size_y_id = 1, local_size_z = 1) in;
layout(set=0, binding=2) coherent buffer OutputC { uint loc[]; } outputC;
layout(set=0, binding=1) coherent buffer OutputB { uvec4 b[]; } outputB;
layout(set=0, binding=0) coherent buffer InputA  { uint  a[]; } inputA;
layout(push_constant) uniform PC {
   // set to the real stride when writing out ballots, or zero when just counting
   int  invocationStride;
   // wildcard fields, for an example the dimensions of rendered area in the case of graphics shaders
   int  width;
   int  height;
   uint primitiveStride;
   uint subgroupStride;
   uint enableInvocationIndex;
};
int outLoc = 0;
bool testBit(uvec4 mask, uint bit) { return ((mask[bit / 32] >> (bit % 32)) & 1) != 0; }
uint elect() { return int(subgroupElect()) + 1; }
layout(constant_id = 10) const uint cmpIndex0 = 0u;
layout(constant_id = 11) const uint cmpIndex1 = 0u;
layout(constant_id = 12) const uint cmpIndex2 = 0u;
layout(constant_id = 13) const uint cmpIndex3 = 0u;
layout(constant_id = 14) const uint cmpIndex4 = 0u;


void main()
{

    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10000;
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
    if (inputA.a[2] == 2) {
        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
        } else {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10005;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        }
        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10009;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        }
    } else {
        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex2]) {
        } else {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000f;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        }
        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex3]) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10013;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        } else {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10016;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        }
    }
    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex4]) {
        switch (gl_SubgroupInvocationID & 3) {
            case 0:
            case 1:
            {
                break;
            }
            case 2:
            case 3:
            {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001f;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                break;
            }
        }
    } else {
        for (int loopIdx0 = 0;;loopIdx0++,        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true)) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10025;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            if (subgroupElect()) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10028;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                break;
            }
        }
    }



}
#version 450 core
#extension GL_KHR_shader_subgroup_ballot : enable
#extension GL_KHR_shader_subgroup_vote : enable
#extension GL_NV_shader_subgroup_partitioned : enable
#extension GL_EXT_subgroup_uniform_control_flow : enable
layout(local_size_x_id = 0, local_size_y_id = 1, local_size_z = 1) in;
layout(set=0, binding=2) coherent buffer OutputC { uint loc[]; } outputC;
layout(set=0, binding=1) coherent buffer OutputB { uvec4 b[]; } outputB;
layout(set=0, binding=0) coherent buffer InputA  { uint  a[]; } inputA;
layout(push_constant) uniform PC {
   // set to the real stride when writing out ballots, or zero when just counting
   int  invocationStride;
   // wildcard fields, for an example the dimensions of rendered area in the case of graphics shaders
   int  width;
   int  height;
   uint primitiveStride;
   uint subgroupStride;
   uint enableInvocationIndex;
};
int outLoc = 0;
bool testBit(uvec4 mask, uint bit) { return ((mask[bit / 32] >> (bit % 32)) & 1) != 0; }
uint elect() { return int(subgroupElect()) + 1; }
layout(constant_id = 10) const uint cmpIndex0 = 0u;
layout(constant_id = 11) const uint cmpIndex1 = 0u;
layout(constant_id = 12) const uint cmpIndex2 = 0u;
layout(constant_id = 13) const uint cmpIndex3 = 0u;


void main()
{

    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10000;
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
    switch (inputA.a[2]) {
        case 3:
        {
            if (subgroupElect()) {
            }
            break;
        }
        case 2:
        {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10008;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            switch (gl_SubgroupInvocationID & 3) {
                case 0:
                case 1:
                {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000c;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    break;
                }
                case 2:
                case 3:
                {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10010;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    break;
                }
            }
            break;
        }
        case 4:
        {
            if (subgroupElect()) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10017;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            }
            break;
        }
    }
    if (testBit(uvec4(0x47437516, 0xdc8cc7ef, 0x85e228f4, 0xc902798b), gl_SubgroupInvocationID)) {
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001d;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10020;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        } else {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10020;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        }
        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
        }
    } else {
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001d;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex2]) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10020;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        } else {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10020;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        }
        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex3]) {
        }
    }



}
#version 450 core
#extension GL_KHR_shader_subgroup_ballot : enable
#extension GL_KHR_shader_subgroup_vote : enable
#extension GL_NV_shader_subgroup_partitioned : enable
#extension GL_EXT_subgroup_uniform_control_flow : enable
layout(local_size_x_id = 0, local_size_y_id = 1, local_size_z = 1) in;
layout(set=0, binding=2) coherent buffer OutputC { uint loc[]; } outputC;
layout(set=0, binding=1) coherent buffer OutputB { uvec4 b[]; } outputB;
layout(set=0, binding=0) coherent buffer InputA  { uint  a[]; } inputA;
layout(push_constant) uniform PC {
   // set to the real stride when writing out ballots, or zero when just counting
   int  invocationStride;
   // wildcard fields, for an example the dimensions of rendered area in the case of graphics shaders
   int  width;
   int  height;
   uint primitiveStride;
   uint subgroupStride;
   uint enableInvocationIndex;
};
int outLoc = 0;
bool testBit(uvec4 mask, uint bit) { return ((mask[bit / 32] >> (bit % 32)) & 1) != 0; }
uint elect() { return int(subgroupElect()) + 1; }
layout(constant_id = 10) const uint cmpIndex0 = 0u;


void main()
{

    if (testBit(uvec4(0x467d6e76, 0x4b45c110, 0xdc26e53e, 0xc4601a6e), gl_SubgroupInvocationID)) {
        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
        }
    } else {
        if (testBit(uvec4(0x467d6e76, 0x4b45c110, 0xdc26e53e, 0xc4601a6e), gl_SubgroupInvocationID)) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10005;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        }
        switch (gl_SubgroupInvocationID & 3) {
            case 0:
            case 1:
            {
                break;
            }
            case 2:
            case 3:
            {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000c;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                break;
            }
        }
    }
    switch (gl_SubgroupInvocationID & 3) {
        case 0:
        case 1:
        {
            switch (gl_SubgroupInvocationID & 3) {
                case 0:
                {
                    break;
                }
                case 1:
                {
                    break;
                }
                case 2:
                {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10019;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    break;
                }
                case 3:
                {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001d;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    break;
                }
            }
            break;
        }
        case 2:
        case 3:
        {
            for (int loopIdx0 = 0;;loopIdx0++,            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true)) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10024;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                if (subgroupElect()) {
                    break;
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10029;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            }
            break;
        }
    }
    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002e;
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);



}
#version 450 core
#extension GL_KHR_shader_subgroup_ballot : enable
#extension GL_KHR_shader_subgroup_vote : enable
#extension GL_NV_shader_subgroup_partitioned : enable
#extension GL_EXT_subgroup_uniform_control_flow : enable
layout(local_size_x_id = 0, local_size_y_id = 1, local_size_z = 1) in;
layout(set=0, binding=2) coherent buffer OutputC { uint loc[]; } outputC;
layout(set=0, binding=1) coherent buffer OutputB { uvec4 b[]; } outputB;
layout(set=0, binding=0) coherent buffer InputA  { uint  a[]; } inputA;
layout(push_constant) uniform PC {
   // set to the real stride when writing out ballots, or zero when just counting
   int  invocationStride;
   // wildcard fields, for an example the dimensions of rendered area in the case of graphics shaders
   int  width;
   int  height;
   uint primitiveStride;
   uint subgroupStride;
   uint enableInvocationIndex;
};
int outLoc = 0;
bool testBit(uvec4 mask, uint bit) { return ((mask[bit / 32] >> (bit % 32)) & 1) != 0; }
uint elect() { return int(subgroupElect()) + 1; }
layout(constant_id = 10) const uint cmpIndex0 = 0u;
layout(constant_id = 11) const uint cmpIndex1 = 0u;


void main()
{

    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10001;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10004;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        } else {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10004;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000a;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
    }
    for (int loopIdx0 = 0;
             loopIdx0 < gl_SubgroupInvocationID + 1;
             loopIdx0++) {
        switch (gl_SubgroupInvocationID & 3) {
            case 0:
            case 1:
            {
                break;
            }
            case 2:
            case 3:
            {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10012;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                break;
            }
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10016;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
    }
    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10019;
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
    if (testBit(uvec4(0xca3d6b2e, 0x914630b3, 0xb676d508, 0x160db633), gl_SubgroupInvocationID)) {
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001c;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        {
            int loopIdx0 = 0;
            do {
                if (subgroupElect()) {
                    break;
                }
                loopIdx0++;
            } while (true);
        }
    } else {
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001c;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        {
            int loopIdx0 = 0;
            do {
                if (subgroupElect()) {
                    break;
                }
                loopIdx0++;
            } while (true);
        }
    }



}
#version 450 core
#extension GL_KHR_shader_subgroup_ballot : enable
#extension GL_KHR_shader_subgroup_vote : enable
#extension GL_NV_shader_subgroup_partitioned : enable
#extension GL_EXT_subgroup_uniform_control_flow : enable
layout(local_size_x_id = 0, local_size_y_id = 1, local_size_z = 1) in;
layout(set=0, binding=2) coherent buffer OutputC { uint loc[]; } outputC;
layout(set=0, binding=1) coherent buffer OutputB { uvec4 b[]; } outputB;
layout(set=0, binding=0) coherent buffer InputA  { uint  a[]; } inputA;
layout(push_constant) uniform PC {
   // set to the real stride when writing out ballots, or zero when just counting
   int  invocationStride;
   // wildcard fields, for an example the dimensions of rendered area in the case of graphics shaders
   int  width;
   int  height;
   uint primitiveStride;
   uint subgroupStride;
   uint enableInvocationIndex;
};
int outLoc = 0;
bool testBit(uvec4 mask, uint bit) { return ((mask[bit / 32] >> (bit % 32)) & 1) != 0; }
uint elect() { return int(subgroupElect()) + 1; }


void main()
{

    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10000;
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
    if (testBit(uvec4(0x5e7c62c7, 0x70aa04d5, 0xd5ac6041, 0xab1a9911), gl_SubgroupInvocationID)) {
        if (subgroupElect()) {
            if (testBit(uvec4(0x5e7c62c7, 0x70aa04d5, 0xd5ac6041, 0xab1a9911), gl_SubgroupInvocationID)) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10005;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            } else {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10008;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000b;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        }
        if (inputA.a[1] == 1) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000f;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            for (int loopIdx0 = 0;;loopIdx0++,            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true)) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10012;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                if (subgroupElect()) {
                    break;
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10017;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001a;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            if (subgroupElect()) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001d;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            }
        } else {
            switch (gl_SubgroupInvocationID & 3) {
                case 0:
                case 1:
                {
                    break;
                }
                case 2:
                case 3:
                {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10025;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    break;
                }
            }
            if (subgroupElect()) {
            }
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002c;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
    } else {
        if (subgroupElect()) {
            if (subgroupElect()) {
            }
            if (inputA.a[1] == 1) {
            }
        }
    }



}
#version 450 core
#extension GL_KHR_shader_subgroup_ballot : enable
#extension GL_KHR_shader_subgroup_vote : enable
#extension GL_NV_shader_subgroup_partitioned : enable
#extension GL_EXT_subgroup_uniform_control_flow : enable
layout(local_size_x_id = 0, local_size_y_id = 1, local_size_z = 1) in;
layout(set=0, binding=2) coherent buffer OutputC { uint loc[]; } outputC;
layout(set=0, binding=1) coherent buffer OutputB { uvec4 b[]; } outputB;
layout(set=0, binding=0) coherent buffer InputA  { uint  a[]; } inputA;
layout(push_constant) uniform PC {
   // set to the real stride when writing out ballots, or zero when just counting
   int  invocationStride;
   // wildcard fields, for an example the dimensions of rendered area in the case of graphics shaders
   int  width;
   int  height;
   uint primitiveStride;
   uint subgroupStride;
   uint enableInvocationIndex;
};
int outLoc = 0;
bool testBit(uvec4 mask, uint bit) { return ((mask[bit / 32] >> (bit % 32)) & 1) != 0; }
uint elect() { return int(subgroupElect()) + 1; }
layout(constant_id = 10) const uint cmpIndex0 = 0u;
layout(constant_id = 11) const uint cmpIndex1 = 0u;


void main()
{

    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
        switch (gl_SubgroupInvocationID & 3) {
            case 0:
            case 1:
            {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10003;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                if (inputA.a[1] == 1) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10006;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                } else {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10009;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
                break;
            }
            case 2:
            case 3:
            {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000e;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10011;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
                break;
            }
        }
    } else {
        {
            int loopIdx0 = 0;
            do {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10018;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                {
                    int loopIdx1 = 0;
                    do {
                        loopIdx1++;
                    } while (loopIdx1 < inputA.a[1]);
                }
                if (inputA.a[3] == 3) {
                }
                if (subgroupElect()) {
                    break;
                }
                if (testBit(uvec4(0x812c43cc, 0x2f392383, 0xd1212f39, 0x629a3975), gl_SubgroupInvocationID)) {
                } else {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10023;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
                switch (gl_SubgroupInvocationID & 3) {
                    case 0:
                    {
                        break;
                    }
                    case 1:
                    {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002a;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        break;
                    }
                    case 2:
                    {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002e;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        break;
                    }
                    case 3:
                    {
                        break;
                    }
                }
                loopIdx0++;
            } while (true);
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10035;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
    }
    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10038;
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);



}
#version 450 core
#extension GL_KHR_shader_subgroup_ballot : enable
#extension GL_KHR_shader_subgroup_vote : enable
#extension GL_NV_shader_subgroup_partitioned : enable
#extension GL_EXT_subgroup_uniform_control_flow : enable
layout(local_size_x_id = 0, local_size_y_id = 1, local_size_z = 1) in;
layout(set=0, binding=2) coherent buffer OutputC { uint loc[]; } outputC;
layout(set=0, binding=1) coherent buffer OutputB { uvec4 b[]; } outputB;
layout(set=0, binding=0) coherent buffer InputA  { uint  a[]; } inputA;
layout(push_constant) uniform PC {
   // set to the real stride when writing out ballots, or zero when just counting
   int  invocationStride;
   // wildcard fields, for an example the dimensions of rendered area in the case of graphics shaders
   int  width;
   int  height;
   uint primitiveStride;
   uint subgroupStride;
   uint enableInvocationIndex;
};
int outLoc = 0;
bool testBit(uvec4 mask, uint bit) { return ((mask[bit / 32] >> (bit % 32)) & 1) != 0; }
uint elect() { return int(subgroupElect()) + 1; }
layout(constant_id = 10) const uint cmpIndex0 = 0u;
layout(constant_id = 11) const uint cmpIndex1 = 0u;
layout(constant_id = 12) const uint cmpIndex2 = 0u;
layout(constant_id = 13) const uint cmpIndex3 = 0u;


void main()
{

    {
        int loopIdx0 = 0;
        do {
            loopIdx0++;
            return;
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10002;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        } while (loopIdx0 < inputA.a[5]);
    }
    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10006;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        if (testBit(uvec4(0x91b3bcd8, 0x6a4b0e01, 0x2033a7ef, 0xef82cc51), gl_SubgroupInvocationID)) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10009;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000c;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            } else {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000c;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10012;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        } else {
            switch (gl_SubgroupInvocationID & 3) {
                case 0:
                case 1:
                {
                    break;
                }
                case 2:
                case 3:
                {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10019;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    break;
                }
            }
            if (inputA.a[2] == 2) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001e;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            } else {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10021;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            }
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10025;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        switch (gl_SubgroupInvocationID & 3) {
            case 0:
            case 1:
            {
                if (gl_LocalInvocationIndex >= inputA.a[cmpIndex2]) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002a;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002d;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                {
                    int loopIdx0 = 0;
                    do {
                        if (subgroupElect()) {
                            break;
                        }
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10033;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        loopIdx0++;
                    } while (true);
                }
                break;
            }
            case 2:
            case 3:
            {
                if (gl_LocalInvocationIndex >= inputA.a[cmpIndex3]) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10039;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                } else {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1003c;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
                {
                    int loopIdx0 = 0;
                    do {
                        if (subgroupElect()) {
                            break;
                        }
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10043;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        loopIdx0++;
                    } while (true);
                }
                break;
            }
        }
    }



}
#version 450 core
#extension GL_KHR_shader_subgroup_ballot : enable
#extension GL_KHR_shader_subgroup_vote : enable
#extension GL_NV_shader_subgroup_partitioned : enable
#extension GL_EXT_subgroup_uniform_control_flow : enable
layout(local_size_x_id = 0, local_size_y_id = 1, local_size_z = 1) in;
layout(set=0, binding=2) coherent buffer OutputC { uint loc[]; } outputC;
layout(set=0, binding=1) coherent buffer OutputB { uvec4 b[]; } outputB;
layout(set=0, binding=0) coherent buffer InputA  { uint  a[]; } inputA;
layout(push_constant) uniform PC {
   // set to the real stride when writing out ballots, or zero when just counting
   int  invocationStride;
   // wildcard fields, for an example the dimensions of rendered area in the case of graphics shaders
   int  width;
   int  height;
   uint primitiveStride;
   uint subgroupStride;
   uint enableInvocationIndex;
};
int outLoc = 0;
bool testBit(uvec4 mask, uint bit) { return ((mask[bit / 32] >> (bit % 32)) & 1) != 0; }
uint elect() { return int(subgroupElect()) + 1; }
layout(constant_id = 10) const uint cmpIndex0 = 0u;
layout(constant_id = 11) const uint cmpIndex1 = 0u;


void main()
{

    for (int loopIdx0 = 0;;loopIdx0++,    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true)) {
        break;
        if (gl_SubgroupInvocationID == loopIdx0) {
            if (inputA.a[3] == 3) {
            } else {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10005;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            }
            if (gl_SubgroupInvocationID == loopIdx0) {
            } else {
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000b;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        } else {
            break;
        }
        if (subgroupElect()) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10011;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            break;
        }
        if (gl_SubgroupInvocationID == loopIdx0) {
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
            }
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10019;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            } else {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001c;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001f;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        } else {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10022;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            if (testBit(uvec4(0x9b54ecd6, 0x8188af72, 0xf3e714de, 0x4343808e), gl_SubgroupInvocationID)) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10025;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            } else {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10025;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002b;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            switch (gl_SubgroupInvocationID & 3) {
                case 0:
                case 1:
                {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002f;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    break;
                }
                case 2:
                case 3:
                {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10033;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    break;
                }
            }
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10038;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        switch (gl_SubgroupInvocationID & 3) {
            case 0:
            {
                switch (gl_SubgroupInvocationID & 3) {
                    case 0:
                    case 1:
                    {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1003e;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        break;
                    }
                    case 2:
                    case 3:
                    {
                        break;
                    }
                }
                break;
            }
            case 1:
            {
                if (testBit(uvec4(0x9b54ecd6, 0x8188af72, 0xf3e714de, 0x4343808e), gl_SubgroupInvocationID)) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10047;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1004a;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                break;
            }
            case 2:
            {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1004e;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                if (subgroupElect()) {
                }
                break;
            }
            case 3:
            {
                for (int loopIdx1 = 0;
                         loopIdx1 < inputA.a[3];
                         loopIdx1++) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10055;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
                break;
            }
        }
    }



}
#version 450 core
#extension GL_KHR_shader_subgroup_ballot : enable
#extension GL_KHR_shader_subgroup_vote : enable
#extension GL_NV_shader_subgroup_partitioned : enable
#extension GL_EXT_subgroup_uniform_control_flow : enable
layout(local_size_x_id = 0, local_size_y_id = 1, local_size_z = 1) in;
layout(set=0, binding=2) coherent buffer OutputC { uint loc[]; } outputC;
layout(set=0, binding=1) coherent buffer OutputB { uvec4 b[]; } outputB;
layout(set=0, binding=0) coherent buffer InputA  { uint  a[]; } inputA;
layout(push_constant) uniform PC {
   // set to the real stride when writing out ballots, or zero when just counting
   int  invocationStride;
   // wildcard fields, for an example the dimensions of rendered area in the case of graphics shaders
   int  width;
   int  height;
   uint primitiveStride;
   uint subgroupStride;
   uint enableInvocationIndex;
};
int outLoc = 0;
bool testBit(uvec4 mask, uint bit) { return ((mask[bit / 32] >> (bit % 32)) & 1) != 0; }
uint elect() { return int(subgroupElect()) + 1; }
layout(constant_id = 10) const uint cmpIndex0 = 0u;
layout(constant_id = 11) const uint cmpIndex1 = 0u;


void main()
{

    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10001;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        {
            int loopIdx0 = 0;
            do {
                {
                    int loopIdx1 = 0;
                    do {
                        loopIdx1++;
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10005;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    } while (loopIdx1 < inputA.a[4]);
                }
                if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10009;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                } else {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000c;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
                if (subgroupElect()) {
                    break;
                }
                if (inputA.a[3] == 3) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10013;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                } else {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10016;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10019;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                switch (gl_SubgroupInvocationID & 3) {
                    case 0:
                    {
                        break;
                    }
                    case 1:
                    {
                        break;
                    }
                    case 2:
                    {
                        break;
                    }
                    case 3:
                    {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10023;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        break;
                    }
                }
                loopIdx0++;
            } while (true);
        }
        {
            int loopIdx0 = 0;
            do {
                loopIdx0++;
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10029;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                switch (gl_SubgroupInvocationID & 3) {
                    case 0:
                    case 1:
                    {
                        break;
                    }
                    case 2:
                    case 3:
                    {
                        break;
                    }
                }
                switch (gl_SubgroupInvocationID & 3) {
                    case 0:
                    case 1:
                    {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10033;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        break;
                    }
                    case 2:
                    case 3:
                    {
                        break;
                    }
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10039;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            } while (loopIdx0 < inputA.a[4]);
        }
    }



}
#version 450 core
#extension GL_KHR_shader_subgroup_ballot : enable
#extension GL_KHR_shader_subgroup_vote : enable
#extension GL_NV_shader_subgroup_partitioned : enable
#extension GL_EXT_subgroup_uniform_control_flow : enable
layout(local_size_x_id = 0, local_size_y_id = 1, local_size_z = 1) in;
layout(set=0, binding=2) coherent buffer OutputC { uint loc[]; } outputC;
layout(set=0, binding=1) coherent buffer OutputB { uvec4 b[]; } outputB;
layout(set=0, binding=0) coherent buffer InputA  { uint  a[]; } inputA;
layout(push_constant) uniform PC {
   // set to the real stride when writing out ballots, or zero when just counting
   int  invocationStride;
   // wildcard fields, for an example the dimensions of rendered area in the case of graphics shaders
   int  width;
   int  height;
   uint primitiveStride;
   uint subgroupStride;
   uint enableInvocationIndex;
};
int outLoc = 0;
bool testBit(uvec4 mask, uint bit) { return ((mask[bit / 32] >> (bit % 32)) & 1) != 0; }
uint elect() { return int(subgroupElect()) + 1; }
layout(constant_id = 10) const uint cmpIndex0 = 0u;
layout(constant_id = 11) const uint cmpIndex1 = 0u;
layout(constant_id = 12) const uint cmpIndex2 = 0u;
layout(constant_id = 13) const uint cmpIndex3 = 0u;


void main()
{

    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10000;
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
    if (inputA.a[0] == 0) {
        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
            if (testBit(uvec4(0xf77511fe, 0x9ecaa8ed, 0x511db92f, 0x8ad08538), gl_SubgroupInvocationID)) {
            } else {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10006;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10009;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            {
                int loopIdx0 = 0;
                do {
                    if (subgroupElect()) {
                        break;
                    }
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000f;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    loopIdx0++;
                } while (true);
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10012;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10015;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        if (subgroupElect()) {
            if (subgroupElect()) {
            }
        }
    } else {
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001c;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        if (testBit(uvec4(0x9e19d960, 0xdc84f6e8, 0x5cf95d28, 0x1058dec4), gl_SubgroupInvocationID)) {
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10020;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            } else {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10020;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10026;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex2]) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10029;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            } else {
            }
        } else {
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex3]) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002f;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10032;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            switch (gl_SubgroupInvocationID & 3) {
                case 0:
                case 1:
                {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10036;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    break;
                }
                case 2:
                case 3:
                {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1003a;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    break;
                }
            }
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1003f;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        for (int loopIdx0 = 0;
                 loopIdx0 < inputA.a[2];
                 loopIdx0++) {
            for (int loopIdx1 = 0;
                     loopIdx1 < gl_SubgroupInvocationID + 1;
                     loopIdx1++) {
            }
            if (inputA.a[0] == 0) {
            }
        }
    }



}
#version 450 core
#extension GL_KHR_shader_subgroup_ballot : enable
#extension GL_KHR_shader_subgroup_vote : enable
#extension GL_NV_shader_subgroup_partitioned : enable
#extension GL_EXT_subgroup_uniform_control_flow : enable
layout(local_size_x_id = 0, local_size_y_id = 1, local_size_z = 1) in;
layout(set=0, binding=2) coherent buffer OutputC { uint loc[]; } outputC;
layout(set=0, binding=1) coherent buffer OutputB { uvec4 b[]; } outputB;
layout(set=0, binding=0) coherent buffer InputA  { uint  a[]; } inputA;
layout(push_constant) uniform PC {
   // set to the real stride when writing out ballots, or zero when just counting
   int  invocationStride;
   // wildcard fields, for an example the dimensions of rendered area in the case of graphics shaders
   int  width;
   int  height;
   uint primitiveStride;
   uint subgroupStride;
   uint enableInvocationIndex;
};
int outLoc = 0;
bool testBit(uvec4 mask, uint bit) { return ((mask[bit / 32] >> (bit % 32)) & 1) != 0; }
uint elect() { return int(subgroupElect()) + 1; }
layout(constant_id = 10) const uint cmpIndex0 = 0u;
layout(constant_id = 11) const uint cmpIndex1 = 0u;
layout(constant_id = 12) const uint cmpIndex2 = 0u;
layout(constant_id = 13) const uint cmpIndex3 = 0u;


void main()
{

    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10000;
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
    switch (inputA.a[2]) {
        case 3:
        {
            if (subgroupElect()) {
                {
                    int loopIdx0 = 0;
                    do {
                        loopIdx0++;
                    } while (loopIdx0 < inputA.a[3]);
                }
                if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10008;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                } else {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10008;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000f;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            break;
        }
        case 2:
        {
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
                if (inputA.a[3] == 3) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10015;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                } else {
                }
                if (gl_LocalInvocationIndex >= inputA.a[cmpIndex2]) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001a;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
            }
            if (testBit(uvec4(0xe6163c7e, 0x3dd7ce3b, 0xf9c3ed9c, 0xcc6299f6), gl_SubgroupInvocationID)) {
                if (gl_LocalInvocationIndex >= inputA.a[cmpIndex3]) {
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10021;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10024;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            break;
        }
        case 4:
        {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10028;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            if (subgroupElect()) {
                {
                    int loopIdx0 = 0;
                    do {
                        loopIdx0++;
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002c;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    } while (loopIdx0 < inputA.a[1]);
                }
            }
            break;
        }
    }



}
#version 450 core
#extension GL_KHR_shader_subgroup_ballot : enable
#extension GL_KHR_shader_subgroup_vote : enable
#extension GL_NV_shader_subgroup_partitioned : enable
#extension GL_EXT_subgroup_uniform_control_flow : enable
layout(local_size_x_id = 0, local_size_y_id = 1, local_size_z = 1) in;
layout(set=0, binding=2) coherent buffer OutputC { uint loc[]; } outputC;
layout(set=0, binding=1) coherent buffer OutputB { uvec4 b[]; } outputB;
layout(set=0, binding=0) coherent buffer InputA  { uint  a[]; } inputA;
layout(push_constant) uniform PC {
   // set to the real stride when writing out ballots, or zero when just counting
   int  invocationStride;
   // wildcard fields, for an example the dimensions of rendered area in the case of graphics shaders
   int  width;
   int  height;
   uint primitiveStride;
   uint subgroupStride;
   uint enableInvocationIndex;
};
int outLoc = 0;
bool testBit(uvec4 mask, uint bit) { return ((mask[bit / 32] >> (bit % 32)) & 1) != 0; }
uint elect() { return int(subgroupElect()) + 1; }
layout(constant_id = 10) const uint cmpIndex0 = 0u;
layout(constant_id = 11) const uint cmpIndex1 = 0u;


void main()
{

    if (testBit(uvec4(0x3750d52a, 0x1615a8dd, 0x4c4903d2, 0x4c9741dd), gl_SubgroupInvocationID)) {
        return;
        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10003;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10006;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
    } else {
        if (testBit(uvec4(0xca3d6b2e, 0x914630b3, 0xb676d508, 0x160db633), gl_SubgroupInvocationID)) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000a;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            {
                int loopIdx0 = 0;
                do {
                    if (subgroupElect()) {
                        break;
                    }
                    loopIdx0++;
                } while (true);
            }
        } else {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000a;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            {
                int loopIdx0 = 0;
                do {
                    if (subgroupElect()) {
                        break;
                    }
                    loopIdx0++;
                } while (true);
            }
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001a;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
    }
    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
        if (subgroupElect()) {
            if (inputA.a[1] == 1) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10020;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            } else {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10020;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            }
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10027;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
    } else {
        if (subgroupElect()) {
            if (inputA.a[0] == 0) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10020;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            } else {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10020;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            }
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10027;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
    }
    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10036;
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);



}
#version 450 core
#extension GL_KHR_shader_subgroup_ballot : enable
#extension GL_KHR_shader_subgroup_vote : enable
#extension GL_NV_shader_subgroup_partitioned : enable
#extension GL_EXT_subgroup_uniform_control_flow : enable
layout(local_size_x_id = 0, local_size_y_id = 1, local_size_z = 1) in;
layout(set=0, binding=2) coherent buffer OutputC { uint loc[]; } outputC;
layout(set=0, binding=1) coherent buffer OutputB { uvec4 b[]; } outputB;
layout(set=0, binding=0) coherent buffer InputA  { uint  a[]; } inputA;
layout(push_constant) uniform PC {
   // set to the real stride when writing out ballots, or zero when just counting
   int  invocationStride;
   // wildcard fields, for an example the dimensions of rendered area in the case of graphics shaders
   int  width;
   int  height;
   uint primitiveStride;
   uint subgroupStride;
   uint enableInvocationIndex;
};
int outLoc = 0;
bool testBit(uvec4 mask, uint bit) { return ((mask[bit / 32] >> (bit % 32)) & 1) != 0; }
uint elect() { return int(subgroupElect()) + 1; }


void main()
{

    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10000;
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
    if (testBit(uvec4(0x5e7c62c7, 0x70aa04d5, 0xd5ac6041, 0xab1a9911), gl_SubgroupInvocationID)) {
        if (subgroupElect()) {
            if (testBit(uvec4(0x5e7c62c7, 0x70aa04d5, 0xd5ac6041, 0xab1a9911), gl_SubgroupInvocationID)) {
                for (int loopIdx0 = 0;
                         loopIdx0 < inputA.a[1];
                         loopIdx0++) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10006;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10009;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                {
                    int loopIdx0 = 0;
                    do {
                        loopIdx0++;
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000c;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    } while (loopIdx0 < inputA.a[3]);
                }
            } else {
                {
                    int loopIdx0 = 0;
                    do {
                        loopIdx0++;
                    } while (loopIdx0 < inputA.a[2]);
                }
                switch (gl_SubgroupInvocationID & 3) {
                    case 0:
                    {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10014;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        break;
                    }
                    case 1:
                    {
                        break;
                    }
                    case 2:
                    {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001a;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        break;
                    }
                    case 3:
                    {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001e;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        break;
                    }
                }
            }
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10024;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
    }
    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10027;
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);



}
#version 450 core
#extension GL_KHR_shader_subgroup_ballot : enable
#extension GL_KHR_shader_subgroup_vote : enable
#extension GL_NV_shader_subgroup_partitioned : enable
#extension GL_EXT_subgroup_uniform_control_flow : enable
layout(local_size_x_id = 0, local_size_y_id = 1, local_size_z = 1) in;
layout(set=0, binding=2) coherent buffer OutputC { uint loc[]; } outputC;
layout(set=0, binding=1) coherent buffer OutputB { uvec4 b[]; } outputB;
layout(set=0, binding=0) coherent buffer InputA  { uint  a[]; } inputA;
layout(push_constant) uniform PC {
   // set to the real stride when writing out ballots, or zero when just counting
   int  invocationStride;
   // wildcard fields, for an example the dimensions of rendered area in the case of graphics shaders
   int  width;
   int  height;
   uint primitiveStride;
   uint subgroupStride;
   uint enableInvocationIndex;
};
int outLoc = 0;
bool testBit(uvec4 mask, uint bit) { return ((mask[bit / 32] >> (bit % 32)) & 1) != 0; }
uint elect() { return int(subgroupElect()) + 1; }
layout(constant_id = 10) const uint cmpIndex0 = 0u;
layout(constant_id = 11) const uint cmpIndex1 = 0u;
layout(constant_id = 12) const uint cmpIndex2 = 0u;
layout(constant_id = 13) const uint cmpIndex3 = 0u;
layout(constant_id = 14) const uint cmpIndex4 = 0u;
layout(constant_id = 15) const uint cmpIndex5 = 0u;
layout(constant_id = 16) const uint cmpIndex6 = 0u;


void main()
{

    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
        switch (gl_SubgroupInvocationID & 3) {
            case 0:
            case 1:
            {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10003;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                if (inputA.a[2] == 2) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10006;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    if (testBit(uvec4(0xd4333cb6, 0x37e22ba5, 0xbf5155f0, 0x67d1e6d4), gl_SubgroupInvocationID)) {
                    }
                    if (inputA.a[0] == 0) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000b;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    } else {
                    }
                }
                break;
            }
            case 2:
            case 3:
            {
                if (inputA.a[3] == 3) {
                    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10014;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    } else {
                    }
                    if (subgroupElect()) {
                    }
                } else {
                    if (testBit(uvec4(0xd4333cb6, 0x37e22ba5, 0xbf5155f0, 0x67d1e6d4), gl_SubgroupInvocationID)) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001c;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    } else {
                    }
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10020;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    if (subgroupElect()) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10023;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    }
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10026;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
                for (int loopIdx0 = 0;;loopIdx0++,                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true)) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002a;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    break;
                    if (subgroupElect()) {
                        while (!subgroupElect()) {}
                        if (testBit(uvec4(0x579965e, 0xdcab3315, 0xc6e61baa, 0x8b38dac5), gl_SubgroupInvocationID)) {
                            break;
                        } else {
                            break;
                        }
                    }
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10035;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    if (subgroupElect()) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10038;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    }
                    if (gl_SubgroupInvocationID == loopIdx0) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1003c;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    }
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10040;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                break;
            }
        }
    } else {
        {
            int loopIdx0 = 0;
            do {
                switch (gl_SubgroupInvocationID & 3) {
                    case 0:
                    {
                        if (testBit(uvec4(0xd4333cb6, 0x37e22ba5, 0xbf5155f0, 0x67d1e6d4), gl_SubgroupInvocationID)) {
                        }
                        break;
                    }
                    case 1:
                    {
                        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex2]) {
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1004d;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        } else {
                        }
                        break;
                    }
                    case 2:
                    {
                        {
                            int loopIdx1 = 0;
                            do {
                                outputC.loc[gl_LocalInvocationIndex]++;
                                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10054;
                                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                                if (subgroupElect()) {
                                    outputC.loc[gl_LocalInvocationIndex]++;
                                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10057;
                                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                                    break;
                                }
                                outputC.loc[gl_LocalInvocationIndex]++;
                                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1005b;
                                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                                loopIdx1++;
                            } while (true);
                        }
                        break;
                    }
                    case 3:
                    {
                        switch (inputA.a[3]) {
                            case 4:
                            {
                                break;
                            }
                            case 3:
                            {
                                outputC.loc[gl_LocalInvocationIndex]++;
                                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10064;
                                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                                break;
                            }
                            case 5:
                            {
                                outputC.loc[gl_LocalInvocationIndex]++;
                                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10068;
                                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                                break;
                            }
                        }
                        break;
                    }
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1006e;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                if (gl_LocalInvocationIndex >= inputA.a[cmpIndex3]) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10071;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex4]) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10074;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    } else {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10077;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    }
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1007a;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    if (gl_SubgroupInvocationID == loopIdx0) {
                    }
                }
                if (subgroupElect()) {
                    break;
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10082;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                if (testBit(uvec4(0xedc86e76, 0xf7f5097c, 0x70d87a0d, 0xa26827a3), gl_SubgroupInvocationID)) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10085;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    {
                        int loopIdx1 = 0;
                        do {
                            loopIdx1++;
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10088;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        } while (loopIdx1 < inputA.a[1]);
                    }
                    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex5]) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1008c;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    }
                }
                loopIdx0++;
            } while (true);
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10091;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        for (int loopIdx0 = 0;;loopIdx0++,        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true)) {
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex6]) {
                {
                    int loopIdx1 = 0;
                    do {
                        loopIdx1++;
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10096;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    } while (loopIdx1 < inputA.a[2]);
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10099;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                {
                    int loopIdx1 = 0;
                    do {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1009c;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        if (subgroupElect()) {
                            break;
                        }
                        loopIdx1++;
                    } while (true);
                }
            }
            if (subgroupElect()) {
                for (int loopIdx1 = 0;
                         loopIdx1 < gl_SubgroupInvocationID + 1;
                         loopIdx1++) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x100a5;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
                break;
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x100a9;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            }
            if (subgroupElect()) {
                break;
            }
            switch (gl_SubgroupInvocationID & 3) {
                case 0:
                {
                    if (gl_SubgroupInvocationID == loopIdx0) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x100b2;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    }
                    break;
                }
                case 1:
                {
                    switch (loopIdx0) {
                        case 1: {
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x100b9;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                            break;
                        }
                        case 2: {
                            break;
                        }
                        default: {
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x100bf;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                            break;
                        }
                    }
                    break;
                }
                case 2:
                {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x100c5;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    if (inputA.a[0] == 0) {
                    }
                    break;
                }
                case 3:
                {
                    if (testBit(uvec4(0x812c43cc, 0x2f392383, 0xd1212f39, 0x629a3975), gl_SubgroupInvocationID)) {
                    }
                    break;
                }
            }
        }
    }



}
#version 450 core
#extension GL_KHR_shader_subgroup_ballot : enable
#extension GL_KHR_shader_subgroup_vote : enable
#extension GL_NV_shader_subgroup_partitioned : enable
#extension GL_EXT_subgroup_uniform_control_flow : enable
layout(local_size_x_id = 0, local_size_y_id = 1, local_size_z = 1) in;
layout(set=0, binding=2) coherent buffer OutputC { uint loc[]; } outputC;
layout(set=0, binding=1) coherent buffer OutputB { uvec4 b[]; } outputB;
layout(set=0, binding=0) coherent buffer InputA  { uint  a[]; } inputA;
layout(push_constant) uniform PC {
   // set to the real stride when writing out ballots, or zero when just counting
   int  invocationStride;
   // wildcard fields, for an example the dimensions of rendered area in the case of graphics shaders
   int  width;
   int  height;
   uint primitiveStride;
   uint subgroupStride;
   uint enableInvocationIndex;
};
int outLoc = 0;
bool testBit(uvec4 mask, uint bit) { return ((mask[bit / 32] >> (bit % 32)) & 1) != 0; }
uint elect() { return int(subgroupElect()) + 1; }
layout(constant_id = 10) const uint cmpIndex0 = 0u;
layout(constant_id = 11) const uint cmpIndex1 = 0u;
layout(constant_id = 12) const uint cmpIndex2 = 0u;
layout(constant_id = 13) const uint cmpIndex3 = 0u;
layout(constant_id = 14) const uint cmpIndex4 = 0u;
layout(constant_id = 15) const uint cmpIndex5 = 0u;
layout(constant_id = 16) const uint cmpIndex6 = 0u;
layout(constant_id = 17) const uint cmpIndex7 = 0u;
layout(constant_id = 18) const uint cmpIndex8 = 0u;
layout(constant_id = 19) const uint cmpIndex9 = 0u;
layout(constant_id = 20) const uint cmpIndex10 = 0u;
layout(constant_id = 21) const uint cmpIndex11 = 0u;
layout(constant_id = 22) const uint cmpIndex12 = 0u;
layout(constant_id = 23) const uint cmpIndex13 = 0u;
layout(constant_id = 24) const uint cmpIndex14 = 0u;
layout(constant_id = 25) const uint cmpIndex15 = 0u;
layout(constant_id = 26) const uint cmpIndex16 = 0u;


void main()
{

    {
        int loopIdx0 = 0;
        do {
            loopIdx0++;
            return;
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10002;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        } while (loopIdx0 < inputA.a[5]);
    }
    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10006;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        if (testBit(uvec4(0x91b3bcd8, 0x6a4b0e01, 0x2033a7ef, 0xef82cc51), gl_SubgroupInvocationID)) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10009;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
                {
                    int loopIdx0 = 0;
                    do {
                        loopIdx0++;
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000d;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    } while (loopIdx0 < inputA.a[5]);
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10010;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                if (gl_LocalInvocationIndex >= inputA.a[cmpIndex2]) {
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10014;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            } else {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10017;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                if (gl_LocalInvocationIndex >= inputA.a[cmpIndex3]) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001a;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001d;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                if (inputA.a[2] == 2) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10020;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
            }
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex4]) {
                for (int loopIdx0 = 0;
                         loopIdx0 < inputA.a[1];
                         loopIdx0++) {
                }
                while (!subgroupElect()) {}
                {
                    int loopIdx0 = 0;
                    do {
                        if (subgroupElect()) {
                            break;
                        }
                        loopIdx0++;
                    } while (true);
                }
            } else {
                if (gl_LocalInvocationIndex >= inputA.a[cmpIndex5]) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002f;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                } else {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10032;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
                switch (gl_SubgroupInvocationID & 3) {
                    case 0:
                    case 1:
                    {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10037;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        break;
                    }
                    case 2:
                    case 3:
                    {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1003b;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        break;
                    }
                }
            }
        } else {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10009;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex6]) {
                {
                    int loopIdx0 = 0;
                    do {
                        loopIdx0++;
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000d;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    } while (loopIdx0 < inputA.a[5]);
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10010;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                if (gl_LocalInvocationIndex >= inputA.a[cmpIndex7]) {
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10014;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            } else {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10017;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                if (gl_LocalInvocationIndex >= inputA.a[cmpIndex8]) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001a;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001d;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                if (inputA.a[0] == 0) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10020;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
            }
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex9]) {
                for (int loopIdx0 = 0;
                         loopIdx0 < inputA.a[1];
                         loopIdx0++) {
                }
                while (!subgroupElect()) {}
                {
                    int loopIdx0 = 0;
                    do {
                        if (subgroupElect()) {
                            break;
                        }
                        loopIdx0++;
                    } while (true);
                }
            } else {
                if (gl_LocalInvocationIndex >= inputA.a[cmpIndex10]) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002f;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                } else {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10032;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
                switch (gl_SubgroupInvocationID & 3) {
                    case 0:
                    case 1:
                    {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10037;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        break;
                    }
                    case 2:
                    case 3:
                    {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1003b;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        break;
                    }
                }
            }
        }
        {
            int loopIdx0 = 0;
            do {
                if (gl_LocalInvocationIndex >= inputA.a[cmpIndex11]) {
                    for (int loopIdx1 = 0;
                             loopIdx1 < gl_SubgroupInvocationID + 1;
                             loopIdx1++) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1007c;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    }
                } else {
                    for (int loopIdx1 = 0;
                             loopIdx1 < gl_SubgroupInvocationID + 1;
                             loopIdx1++) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1007c;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    }
                }
                if (gl_SubgroupInvocationID == loopIdx0) {
                    if (testBit(uvec4(0xede2dc2c, 0xdcb30010, 0x2ebc3846, 0x63a3bd92), gl_SubgroupInvocationID)) {
                        break;
                    } else {
                        break;
                    }
                    if (inputA.a[0] == 0) {
                    }
                }
                if (subgroupElect()) {
                    break;
                }
                if (testBit(uvec4(0x1e63b50d, 0x123a9eee, 0x5acbdd0b, 0xe77a12d4), gl_SubgroupInvocationID)) {
                    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex12]) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10093;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    } else {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10096;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    }
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10099;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    if (gl_SubgroupInvocationID == loopIdx0) {
                    } else {
                    }
                } else {
                    if (gl_SubgroupInvocationID == loopIdx0) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x100a0;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    } else {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x100a3;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    }
                    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex13]) {
                    }
                }
                {
                    int loopIdx1 = 0;
                    do {
                        break;
                        for (int loopIdx2 = 0;
                                 loopIdx2 < inputA.a[4];
                                 loopIdx2++) {
                        }
                        if (subgroupElect()) {
                            break;
                        }
                        if (gl_SubgroupInvocationID == loopIdx1) {
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x100b1;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        }
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x100b4;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        if (testBit(uvec4(0x1e63b50d, 0x123a9eee, 0x5acbdd0b, 0xe77a12d4), gl_SubgroupInvocationID)) {
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x100b7;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        }
                        loopIdx1++;
                    } while (true);
                }
                loopIdx0++;
            } while (true);
        }
    } else {
        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex14]) {
            for (int loopIdx0 = 0;
                     loopIdx0 < gl_SubgroupInvocationID + 1;
                     loopIdx0++) {
                switch (gl_SubgroupInvocationID & 3) {
                    case 0:
                    case 1:
                    {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x100c1;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        break;
                    }
                    case 2:
                    case 3:
                    {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x100c5;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        break;
                    }
                }
                switch (loopIdx0) {
                    case 1: {
                        break;
                    }
                    case 2: {
                        break;
                    }
                    default: {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x100cf;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        break;
                    }
                }
            }
            if (inputA.a[2] == 2) {
                if (gl_LocalInvocationIndex >= inputA.a[cmpIndex15]) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x100d6;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                } else {
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x100da;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            }
        } else {
            if (testBit(uvec4(0x1e63b50d, 0x123a9eee, 0x5acbdd0b, 0xe77a12d4), gl_SubgroupInvocationID)) {
                if (gl_LocalInvocationIndex >= inputA.a[cmpIndex16]) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x100e0;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
                {
                    int loopIdx0 = 0;
                    do {
                        if (subgroupElect()) {
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x100e5;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                            if (testBit(uvec4(0xede2dc2c, 0xdcb30010, 0x2ebc3846, 0x63a3bd92), gl_SubgroupInvocationID)) {
                                break;
                            } else {
                                break;
                            }
                        }
                        loopIdx0++;
                    } while (true);
                }
            }
        }
    }



}
#version 450 core
#extension GL_KHR_shader_subgroup_ballot : enable
#extension GL_KHR_shader_subgroup_vote : enable
#extension GL_NV_shader_subgroup_partitioned : enable
#extension GL_EXT_subgroup_uniform_control_flow : enable
layout(local_size_x_id = 0, local_size_y_id = 1, local_size_z = 1) in;
layout(set=0, binding=2) coherent buffer OutputC { uint loc[]; } outputC;
layout(set=0, binding=1) coherent buffer OutputB { uvec4 b[]; } outputB;
layout(set=0, binding=0) coherent buffer InputA  { uint  a[]; } inputA;
layout(push_constant) uniform PC {
   // set to the real stride when writing out ballots, or zero when just counting
   int  invocationStride;
   // wildcard fields, for an example the dimensions of rendered area in the case of graphics shaders
   int  width;
   int  height;
   uint primitiveStride;
   uint subgroupStride;
   uint enableInvocationIndex;
};
int outLoc = 0;
bool testBit(uvec4 mask, uint bit) { return ((mask[bit / 32] >> (bit % 32)) & 1) != 0; }
uint elect() { return int(subgroupElect()) + 1; }


void main()
{

    for (int loopIdx0 = 0;;loopIdx0++,    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true)) {
        break;
        if (gl_SubgroupInvocationID == loopIdx0) {
            if (inputA.a[3] == 3) {
                if (testBit(uvec4(0xe3e6077b, 0x934d4176, 0x44df3f14, 0x16bfbe39), gl_SubgroupInvocationID)) {
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10006;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                for (int loopIdx1 = 0;
                         loopIdx1 < inputA.a[2];
                         loopIdx1++) {
                }
            } else {
                if (gl_SubgroupInvocationID == loopIdx0) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000c;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                } else {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000f;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10013;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            if (inputA.a[3] == 3) {
                break;
                {
                    int loopIdx1 = 0;
                    do {
                        loopIdx1++;
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10018;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    } while (loopIdx1 < inputA.a[3]);
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001b;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            }
        } else {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001f;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            if (gl_SubgroupInvocationID == loopIdx0) {
                if (testBit(uvec4(0xbdeae9f, 0x37d0c6ef, 0x9f4cb738, 0x54c6189a), gl_SubgroupInvocationID)) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10023;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
                if (inputA.a[2] == 2) {
                } else {
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10029;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            } else {
                if (inputA.a[0] == 12345) {
                    while (true) {
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    }
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002d;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                if (testBit(uvec4(0xe3e6077b, 0x934d4176, 0x44df3f14, 0x16bfbe39), gl_SubgroupInvocationID)) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10030;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10033;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10036;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        }
        if (subgroupElect()) {
            break;
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1003c;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        break;
    }



}
#version 450 core
#extension GL_KHR_shader_subgroup_ballot : enable
#extension GL_KHR_shader_subgroup_vote : enable
#extension GL_NV_shader_subgroup_partitioned : enable
#extension GL_EXT_subgroup_uniform_control_flow : enable
layout(local_size_x_id = 0, local_size_y_id = 1, local_size_z = 1) in;
layout(set=0, binding=2) coherent buffer OutputC { uint loc[]; } outputC;
layout(set=0, binding=1) coherent buffer OutputB { uvec4 b[]; } outputB;
layout(set=0, binding=0) coherent buffer InputA  { uint  a[]; } inputA;
layout(push_constant) uniform PC {
   // set to the real stride when writing out ballots, or zero when just counting
   int  invocationStride;
   // wildcard fields, for an example the dimensions of rendered area in the case of graphics shaders
   int  width;
   int  height;
   uint primitiveStride;
   uint subgroupStride;
   uint enableInvocationIndex;
};
int outLoc = 0;
bool testBit(uvec4 mask, uint bit) { return ((mask[bit / 32] >> (bit % 32)) & 1) != 0; }
uint elect() { return int(subgroupElect()) + 1; }
layout(constant_id = 10) const uint cmpIndex0 = 0u;
layout(constant_id = 11) const uint cmpIndex1 = 0u;
layout(constant_id = 12) const uint cmpIndex2 = 0u;
layout(constant_id = 13) const uint cmpIndex3 = 0u;
layout(constant_id = 14) const uint cmpIndex4 = 0u;


void main()
{

    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10001;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        {
            int loopIdx0 = 0;
            do {
                {
                    int loopIdx1 = 0;
                    do {
                        loopIdx1++;
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10005;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        break;
                        if (inputA.a[0] == 0) {
                        } else {
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000a;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        }
                    } while (loopIdx1 < inputA.a[4]);
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000e;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                if (gl_SubgroupInvocationID == loopIdx0) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10011;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10014;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    } else {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10017;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    }
                }
                if (subgroupElect()) {
                    break;
                }
                if (inputA.a[0] == 0) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001f;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    for (int loopIdx1 = 0;
                             loopIdx1 < inputA.a[1];
                             loopIdx1++) {
                    }
                } else {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10024;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    switch (loopIdx0) {
                        case 1: {
                            break;
                        }
                        case 2: {
                            break;
                        }
                        default: {
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002c;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                            break;
                        }
                    }
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10031;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                if (testBit(uvec4(0xb0caba39, 0xdcbca1e5, 0x73e934e7, 0x3e8bc839), gl_SubgroupInvocationID)) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10034;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    if (subgroupElect()) {
                    }
                } else {
                    {
                        int loopIdx1 = 0;
                        do {
                            if (subgroupElect()) {
                                outputC.loc[gl_LocalInvocationIndex]++;
                                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1003b;
                                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                                break;
                            }
                            loopIdx1++;
                        } while (true);
                    }
                }
                loopIdx0++;
            } while (true);
        }
        if (inputA.a[3] == 3) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10043;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            for (int loopIdx0 = 0;;loopIdx0++,            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true)) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10046;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                if (subgroupElect()) {
                    break;
                }
                for (int loopIdx1 = 0;
                         loopIdx1 < gl_SubgroupInvocationID + 1;
                         loopIdx1++) {
                }
                break;
            }
        } else {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10050;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10053;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
    } else {
        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex2]) {
            if (inputA.a[2] == 2) {
                if (subgroupElect()) {
                }
                {
                    int loopIdx0 = 0;
                    do {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1005b;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        if (subgroupElect()) {
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1005e;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                            break;
                        }
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10062;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        loopIdx0++;
                    } while (true);
                }
            }
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex3]) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10067;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                if (gl_LocalInvocationIndex >= inputA.a[cmpIndex4]) {
                } else {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1006b;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
            }
        }
    }



}
#version 450 core
#extension GL_KHR_shader_subgroup_ballot : enable
#extension GL_KHR_shader_subgroup_vote : enable
#extension GL_NV_shader_subgroup_partitioned : enable
#extension GL_EXT_subgroup_uniform_control_flow : enable
layout(local_size_x_id = 0, local_size_y_id = 1, local_size_z = 1) in;
layout(set=0, binding=2) coherent buffer OutputC { uint loc[]; } outputC;
layout(set=0, binding=1) coherent buffer OutputB { uvec4 b[]; } outputB;
layout(set=0, binding=0) coherent buffer InputA  { uint  a[]; } inputA;
layout(push_constant) uniform PC {
   // set to the real stride when writing out ballots, or zero when just counting
   int  invocationStride;
   // wildcard fields, for an example the dimensions of rendered area in the case of graphics shaders
   int  width;
   int  height;
   uint primitiveStride;
   uint subgroupStride;
   uint enableInvocationIndex;
};
int outLoc = 0;
bool testBit(uvec4 mask, uint bit) { return ((mask[bit / 32] >> (bit % 32)) & 1) != 0; }
uint elect() { return int(subgroupElect()) + 1; }
layout(constant_id = 10) const uint cmpIndex0 = 0u;
layout(constant_id = 11) const uint cmpIndex1 = 0u;
layout(constant_id = 12) const uint cmpIndex2 = 0u;
layout(constant_id = 13) const uint cmpIndex3 = 0u;


void main()
{

    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10000;
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
    if (inputA.a[0] == 0) {
        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
            if (testBit(uvec4(0xf77511fe, 0x9ecaa8ed, 0x511db92f, 0x8ad08538), gl_SubgroupInvocationID)) {
                if (subgroupElect()) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10006;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
                switch (gl_SubgroupInvocationID & 3) {
                    case 0:
                    {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000b;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        break;
                    }
                    case 1:
                    {
                        break;
                    }
                    case 2:
                    {
                        break;
                    }
                    case 3:
                    {
                        break;
                    }
                }
            } else {
                for (int loopIdx0 = 0;
                         loopIdx0 < gl_SubgroupInvocationID + 1;
                         loopIdx0++) {
                    if (inputA.a[0] == 12345) {
                        while (true) {
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        }
                    }
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10019;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                if (subgroupElect()) {
                }
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001e;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        } else {
            if (testBit(uvec4(0xf77511fe, 0x9ecaa8ed, 0x511db92f, 0x8ad08538), gl_SubgroupInvocationID)) {
                if (subgroupElect()) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10006;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
                switch (gl_SubgroupInvocationID & 3) {
                    case 0:
                    {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000b;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        break;
                    }
                    case 1:
                    {
                        break;
                    }
                    case 2:
                    {
                        break;
                    }
                    case 3:
                    {
                        break;
                    }
                }
            } else {
                for (int loopIdx0 = 0;
                         loopIdx0 < gl_SubgroupInvocationID + 1;
                         loopIdx0++) {
                    if (inputA.a[0] == 12345) {
                        while (true) {
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        }
                    }
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10019;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                if (subgroupElect()) {
                }
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001e;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1003e;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
    } else {
        if (subgroupElect()) {
            switch (inputA.a[3]) {
                case 4:
                {
                    if (subgroupElect()) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10045;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    }
                    break;
                }
                case 3:
                {
                    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1004b;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    } else {
                    }
                    return;
                    break;
                }
                case 5:
                {
                    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex2]) {
                    } else {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10054;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    }
                    break;
                }
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10059;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            for (int loopIdx0 = 0;
                     loopIdx0 < inputA.a[2];
                     loopIdx0++) {
                for (int loopIdx1 = 0;
                         loopIdx1 < gl_SubgroupInvocationID + 1;
                         loopIdx1++) {
                }
                if (inputA.a[3] == 3) {
                }
            }
        }
        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex3]) {
            if (testBit(uvec4(0x9e19d960, 0xdc84f6e8, 0x5cf95d28, 0x1058dec4), gl_SubgroupInvocationID)) {
                if (inputA.a[2] == 2) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10065;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10068;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                switch (gl_SubgroupInvocationID & 3) {
                    case 0:
                    case 1:
                    {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1006c;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        break;
                    }
                    case 2:
                    case 3:
                    {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10070;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        break;
                    }
                }
            }
            switch (gl_SubgroupInvocationID & 3) {
                case 0:
                case 1:
                {
                    if (testBit(uvec4(0xf7b3ccb6, 0xa731d3e9, 0xb74d8b76, 0x21cb827a), gl_SubgroupInvocationID)) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10078;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    }
                    break;
                }
                case 2:
                case 3:
                {
                    for (int loopIdx0 = 0;
                             loopIdx0 < inputA.a[4];
                             loopIdx0++) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1007e;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    }
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10081;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    if (inputA.a[0] == 0) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10084;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    }
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10087;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    break;
                }
            }
        }
    }
    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1008d;
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);



}
#version 450 core
#extension GL_KHR_shader_subgroup_ballot : enable
#extension GL_KHR_shader_subgroup_vote : enable
#extension GL_NV_shader_subgroup_partitioned : enable
#extension GL_EXT_subgroup_uniform_control_flow : enable
layout(local_size_x_id = 0, local_size_y_id = 1, local_size_z = 1) in;
layout(set=0, binding=2) coherent buffer OutputC { uint loc[]; } outputC;
layout(set=0, binding=1) coherent buffer OutputB { uvec4 b[]; } outputB;
layout(set=0, binding=0) coherent buffer InputA  { uint  a[]; } inputA;
layout(push_constant) uniform PC {
   // set to the real stride when writing out ballots, or zero when just counting
   int  invocationStride;
   // wildcard fields, for an example the dimensions of rendered area in the case of graphics shaders
   int  width;
   int  height;
   uint primitiveStride;
   uint subgroupStride;
   uint enableInvocationIndex;
};
int outLoc = 0;
bool testBit(uvec4 mask, uint bit) { return ((mask[bit / 32] >> (bit % 32)) & 1) != 0; }
uint elect() { return int(subgroupElect()) + 1; }
layout(constant_id = 10) const uint cmpIndex0 = 0u;
layout(constant_id = 11) const uint cmpIndex1 = 0u;
layout(constant_id = 12) const uint cmpIndex2 = 0u;
layout(constant_id = 13) const uint cmpIndex3 = 0u;
layout(constant_id = 14) const uint cmpIndex4 = 0u;


void main()
{

    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10000;
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
    switch (inputA.a[2]) {
        case 3:
        {
            if (subgroupElect()) {
                {
                    int loopIdx0 = 0;
                    do {
                        loopIdx0++;
                        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
                        }
                        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10009;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        } else {
                        }
                    } while (loopIdx0 < inputA.a[3]);
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000e;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                {
                    int loopIdx0 = 0;
                    do {
                        if (gl_SubgroupInvocationID == loopIdx0) {
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10012;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        } else {
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10012;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        }
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10018;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        if (subgroupElect()) {
                        }
                        if (subgroupElect()) {
                            break;
                        }
                        if (subgroupElect()) {
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10020;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        }
                        if (testBit(uvec4(0x47437516, 0xdc8cc7ef, 0x85e228f4, 0xc902798b), gl_SubgroupInvocationID)) {
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10024;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        } else {
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10027;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        }
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002a;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        loopIdx0++;
                    } while (true);
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002d;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            }
            break;
        }
        case 2:
        {
            switch (gl_SubgroupInvocationID & 3) {
                case 0:
                {
                    if (subgroupElect()) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10035;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        switch (inputA.a[3]) {
                            case 4:
                            {
                                break;
                            }
                            case 3:
                            {
                                break;
                            }
                            case 5:
                            {
                                break;
                            }
                        }
                    }
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10040;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    break;
                }
                case 1:
                {
                    break;
                }
                case 2:
                {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10046;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    if (testBit(uvec4(0xc8626f10, 0x4b547ee1, 0xd59c011f, 0x36238fad), gl_SubgroupInvocationID)) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10049;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        switch (gl_SubgroupInvocationID & 3) {
                            case 0:
                            case 1:
                            {
                                break;
                            }
                            case 2:
                            case 3:
                            {
                                outputC.loc[gl_LocalInvocationIndex]++;
                                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1004f;
                                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                                break;
                            }
                        }
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10053;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    } else {
                        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex2]) {
                        }
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10058;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    }
                    break;
                }
                case 3:
                {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1005d;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    break;
                }
            }
            {
                int loopIdx0 = 0;
                do {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10062;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    if (subgroupElect()) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10065;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        break;
                    }
                    if (subgroupElect()) {
                        switch (gl_SubgroupInvocationID & 3) {
                            case 0:
                            case 1:
                            {
                                break;
                            }
                            case 2:
                            case 3:
                            {
                                break;
                            }
                        }
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10070;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        break;
                    }
                    if (testBit(uvec4(0x2d447467, 0x7ae64289, 0x13784927, 0xf531f510), gl_SubgroupInvocationID)) {
                        if (inputA.a[0] == 0) {
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10076;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        } else {
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10079;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        }
                        switch (inputA.a[1]) {
                            case 2:
                            {
                                break;
                            }
                            case 1:
                            {
                                outputC.loc[gl_LocalInvocationIndex]++;
                                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10080;
                                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                                break;
                            }
                            case 3:
                            {
                                break;
                            }
                        }
                    } else {
                        break;
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10088;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        if (testBit(uvec4(0xc8626f10, 0x4b547ee1, 0xd59c011f, 0x36238fad), gl_SubgroupInvocationID)) {
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1008b;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        } else {
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1008e;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        }
                    }
                    loopIdx0++;
                } while (true);
            }
            break;
        }
        case 4:
        {
            if (inputA.a[0] == 0) {
                if (gl_LocalInvocationIndex >= inputA.a[cmpIndex3]) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10097;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    {
                        int loopIdx0 = 0;
                        do {
                            loopIdx0++;
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1009a;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        } while (loopIdx0 < inputA.a[4]);
                    }
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1009d;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex4]) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x100a0;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    } else {
                    }
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x100a5;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            }
            break;
        }
    }



}
#version 450 core
#extension GL_KHR_shader_subgroup_ballot : enable
#extension GL_KHR_shader_subgroup_vote : enable
#extension GL_NV_shader_subgroup_partitioned : enable
#extension GL_EXT_subgroup_uniform_control_flow : enable
layout(local_size_x_id = 0, local_size_y_id = 1, local_size_z = 1) in;
layout(set=0, binding=2) coherent buffer OutputC { uint loc[]; } outputC;
layout(set=0, binding=1) coherent buffer OutputB { uvec4 b[]; } outputB;
layout(set=0, binding=0) coherent buffer InputA  { uint  a[]; } inputA;
layout(push_constant) uniform PC {
   // set to the real stride when writing out ballots, or zero when just counting
   int  invocationStride;
   // wildcard fields, for an example the dimensions of rendered area in the case of graphics shaders
   int  width;
   int  height;
   uint primitiveStride;
   uint subgroupStride;
   uint enableInvocationIndex;
};
int outLoc = 0;
bool testBit(uvec4 mask, uint bit) { return ((mask[bit / 32] >> (bit % 32)) & 1) != 0; }
uint elect() { return int(subgroupElect()) + 1; }
layout(constant_id = 10) const uint cmpIndex0 = 0u;
layout(constant_id = 11) const uint cmpIndex1 = 0u;
layout(constant_id = 12) const uint cmpIndex2 = 0u;


void main()
{

    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
        if (testBit(uvec4(0x467d6e76, 0x4b45c110, 0xdc26e53e, 0xc4601a6e), gl_SubgroupInvocationID)) {
            for (int loopIdx0 = 0;;loopIdx0++,            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true)) {
                for (int loopIdx1 = 0;
                         loopIdx1 < inputA.a[5];
                         loopIdx1++) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10004;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
                switch (loopIdx0) {
                    case 1: {
                        break;
                    }
                    case 2: {
                        break;
                    }
                    default: {
                        break;
                    }
                }
                if (subgroupElect()) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10010;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    break;
                }
                if (subgroupElect()) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10015;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
                if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10019;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                } else {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001c;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001f;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            }
        }
    } else {
        if (testBit(uvec4(0x467d6e76, 0x4b45c110, 0xdc26e53e, 0xc4601a6e), gl_SubgroupInvocationID)) {
            for (int loopIdx0 = 0;;loopIdx0++,            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true)) {
                for (int loopIdx1 = 0;
                         loopIdx1 < inputA.a[5];
                         loopIdx1++) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10004;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
                switch (loopIdx0) {
                    case 1: {
                        break;
                    }
                    case 2: {
                        break;
                    }
                    default: {
                        break;
                    }
                }
                if (subgroupElect()) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10010;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    break;
                }
                if (subgroupElect()) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10015;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
                if (gl_LocalInvocationIndex >= inputA.a[cmpIndex2]) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10019;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                } else {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001c;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001f;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            }
        }
    }



}
