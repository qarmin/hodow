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


void main()
[[maximally_reconverges]]
{

    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10000;
    for (int loopIdx0 = 0;;loopIdx0++,    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true)) {
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        break;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        if (inputA.a[3] == 3) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10006;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        } else {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10006;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        }
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        if (subgroupElect()) {
            break;
        }
        for (int loopIdx1 = 0;;loopIdx1++,        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true)) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10011;
            if (subgroupElect()) {
                break;
            }
        }
    }
    if (subgroupElect()) {
        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        } else {
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        }
        if (subgroupElect()) {
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001f;
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

    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        }
    }
    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex2]) {
        if (testBit(uvec4(0xf769d02, 0x9d77bef, 0xe2a0008a, 0x6bd6bd3a), gl_SubgroupInvocationID)) {
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10009;
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
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10016;
                break;
            }
            case 3:
            {
                break;
            }
        }
    }
    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001c;
    for (int loopIdx0 = 0;
             loopIdx0 < gl_SubgroupInvocationID + 1;
             loopIdx0++) {
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        for (int loopIdx1 = 0;;loopIdx1++,        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true)) {
            if (subgroupElect()) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10021;
                break;
            }
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
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


void main()
[[maximally_reconverges]]
{

    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10002;
        if (testBit(uvec4(0x2451177d, 0xdcb3c008, 0xe709f5d7, 0xaa106ff5), gl_SubgroupInvocationID)) {
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        } else {
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
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000e;
                break;
            }
            case 3:
            {
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                break;
            }
        }
    } else {
        if (testBit(uvec4(0xee6a85de, 0x830e345, 0xf7a56dfc, 0x3bb1816a), gl_SubgroupInvocationID)) {
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        }
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        {
            int loopIdx0 = 0;
            do {
                loopIdx0++;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            } while (loopIdx0 < inputA.a[3]);
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


void main()
[[maximally_reconverges]]
{

    {
        int loopIdx0 = 0;
        do {
            loopIdx0++;
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            } else {
            }
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            for (int loopIdx1 = 0;
                     loopIdx1 < inputA.a[3];
                     loopIdx1++) {
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            }
        } while (loopIdx0 < inputA.a[1]);
    }
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
    if (testBit(uvec4(0x64d5c99f, 0x1808a9af, 0xb00e2b66, 0xd0c9bc22), gl_SubgroupInvocationID)) {
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
        } else {
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10010;
        }
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10013;
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
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001a;
    }
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex2]) {
        for (int loopIdx0 = 0;
                 loopIdx0 < gl_SubgroupInvocationID + 1;
                 loopIdx0++) {
        }
        if (testBit(uvec4(0x64d5c99f, 0x1808a9af, 0xb00e2b66, 0xd0c9bc22), gl_SubgroupInvocationID)) {
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        }
    } else {
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10024;
    }
    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10026;



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

    if (subgroupElect()) {
        if (testBit(uvec4(0x69b22f4b, 0xde19e3d2, 0x570385ca, 0xcb85febe), gl_SubgroupInvocationID)) {
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10004;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
    }
    for (int loopIdx0 = 0;
             loopIdx0 < inputA.a[4];
             loopIdx0++) {
        if (subgroupElect()) {
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000a;
        }
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        break;
    }
    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000f;
    {
        int loopIdx0 = 0;
        do {
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            if (inputA.a[2] == 2) {
            }
            {
                int loopIdx1 = 0;
                do {
                    loopIdx1++;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10016;
                } while (loopIdx1 < inputA.a[3]);
            }
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            if (subgroupElect()) {
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                break;
            }
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            {
                int loopIdx1 = 0;
                do {
                    if (subgroupElect()) {
                        break;
                    }
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10022;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    loopIdx1++;
                } while (true);
            }
            if (inputA.a[1] == 1) {
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            } else {
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002a;
            loopIdx0++;
        } while (true);
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


void main()
[[maximally_reconverges]]
{

    for (int loopIdx0 = 0;;loopIdx0++,    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true)) {
        if (inputA.a[0] == 0) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10002;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        } else {
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10007;
        break;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        if (subgroupElect()) {
            break;
        }
        break;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        {
            int loopIdx1 = 0;
            do {
                loopIdx1++;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            } while (loopIdx1 < inputA.a[5]);
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10012;
    }
    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10016;
        if (inputA.a[2] == 2) {
        } else {
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        }
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
    }
    {
        int loopIdx0 = 0;
        do {
            loopIdx0++;
            if (inputA.a[2] == 2) {
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            }
            continue;
        } while (loopIdx0 < inputA.a[2]);
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
        if (testBit(uvec4(0xba9b2883, 0x627a9aea, 0xe415efee, 0xc7b618da), gl_SubgroupInvocationID)) {
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10003;
        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        } else {
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        }
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
    }
    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000b;
    for (int loopIdx0 = 0;;loopIdx0++,    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true)) {
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        if (inputA.a[0] == 0) {
        }
        if (subgroupElect()) {
            break;
        }
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        break;
        if (testBit(uvec4(0xfc448fa1, 0x68b83ada, 0xcbbd07ad, 0x21ab9f7d), gl_SubgroupInvocationID)) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10016;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        } else {
        }
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
    }
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
    for (int loopIdx0 = 0;
             loopIdx0 < inputA.a[4];
             loopIdx0++) {
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001e;
        if (testBit(uvec4(0xfded30bc, 0x9e3bcf7f, 0x28b84885, 0x16997569), gl_SubgroupInvocationID)) {
        } else {
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        }
        if (gl_SubgroupInvocationID == loopIdx0) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10024;
        } else {
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


void main()
[[maximally_reconverges]]
{

    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10000;
    {
        int loopIdx0 = 0;
        do {
            if (testBit(uvec4(0x7add8c04, 0x3871181, 0x475415fe, 0x72a638d5), gl_SubgroupInvocationID)) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10003;
            }
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            if (subgroupElect()) {
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                break;
            }
            {
                int loopIdx1 = 0;
                do {
                    loopIdx1++;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                } while (loopIdx1 < inputA.a[4]);
            }
            if (gl_SubgroupInvocationID == loopIdx0) {
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            }
            loopIdx0++;
        } while (true);
    }
    if (testBit(uvec4(0xd42c613d, 0xdc94d4ee, 0x164d5461, 0x5a6d4ffb), gl_SubgroupInvocationID)) {
    }
    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10013;
    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10015;
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
    } else {
        switch (gl_SubgroupInvocationID & 3) {
            case 0:
            {
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002f;
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
    for (int loopIdx0 = 0;;loopIdx0++,    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true)) {
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        break;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        if (inputA.a[2] == 2) {
            if (gl_SubgroupInvocationID == loopIdx0) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10007;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            } else {
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000c;
        } else {
            if (gl_SubgroupInvocationID == loopIdx0) {
            } else {
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            }
            if (subgroupElect()) {
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            }
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        }
        if (subgroupElect()) {
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            switch (inputA.a[2]) {
                case 3:
                {
                    break;
                }
                case 2:
                {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001d;
                    break;
                }
                case 4:
                {
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    break;
                }
            }
            break;
        }
        for (int loopIdx1 = 0;
                 loopIdx1 < gl_SubgroupInvocationID + 1;
                 loopIdx1++) {
            if (testBit(uvec4(0x73a02751, 0xdca3a206, 0xb07b76af, 0xfde17503), gl_SubgroupInvocationID)) {
                break;
            } else {
                break;
            }
        }
        {
            int loopIdx1 = 0;
            do {
                if (subgroupElect()) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002e;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
                if (subgroupElect()) {
                    break;
                }
                if (gl_SubgroupInvocationID == loopIdx1) {
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                } else {
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1003a;
                return;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                loopIdx1++;
            } while (true);
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

    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
            {
                int loopIdx0 = 0;
                do {
                    loopIdx0++;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                } while (loopIdx0 < inputA.a[1]);
            }
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            for (int loopIdx0 = 0;;loopIdx0++,            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true)) {
                if (subgroupElect()) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10009;
                    break;
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000c;
            }
        } else {
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            if (testBit(uvec4(0x1963f897, 0x8b4219b3, 0x92c36785, 0xf2d7d33), gl_SubgroupInvocationID)) {
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10013;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        }
        switch (gl_SubgroupInvocationID & 3) {
            case 0:
            {
                if (testBit(uvec4(0x1963f897, 0x8b4219b3, 0x92c36785, 0xf2d7d33), gl_SubgroupInvocationID)) {
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001a;
                } else {
                }
                break;
            }
            case 1:
            {
                break;
            }
            case 2:
            {
                if (testBit(uvec4(0x1963f897, 0x8b4219b3, 0x92c36785, 0xf2d7d33), gl_SubgroupInvocationID)) {
                }
                break;
            }
            case 3:
            {
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                if (subgroupElect()) {
                }
                break;
            }
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002a;
    } else {
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        {
            int loopIdx0 = 0;
            do {
                if (inputA.a[2] == 2) {
                } else {
                }
                for (int loopIdx1 = 0;;loopIdx1++,                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true)) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10032;
                    if (subgroupElect()) {
                        break;
                    }
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                if (subgroupElect()) {
                    break;
                }
                break;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1003e;
                if (gl_LocalInvocationIndex >= inputA.a[cmpIndex2]) {
                } else {
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
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
    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10002;
        if (testBit(uvec4(0x2451177d, 0xdcb3c008, 0xe709f5d7, 0xaa106ff5), gl_SubgroupInvocationID)) {
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            }
            if (subgroupElect()) {
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000a;
            }
        } else {
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        }
        if (testBit(uvec4(0xee6a85de, 0x830e345, 0xf7a56dfc, 0x3bb1816a), gl_SubgroupInvocationID)) {
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex2]) {
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10013;
            {
                int loopIdx0 = 0;
                do {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10015;
                    if (subgroupElect()) {
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        break;
                    }
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001a;
                    loopIdx0++;
                } while (true);
            }
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        } else {
            if (subgroupElect()) {
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            }
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            {
                int loopIdx0 = 0;
                do {
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10024;
                    if (subgroupElect()) {
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        break;
                    }
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    loopIdx0++;
                } while (true);
            }
        }
    } else {
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        if (inputA.a[3] == 3) {
            {
                int loopIdx0 = 0;
                do {
                    if (subgroupElect()) {
                        if (testBit(uvec4(0x2451177d, 0xdcb3c008, 0xe709f5d7, 0xaa106ff5), gl_SubgroupInvocationID)) {
                            break;
                        } else {
                            break;
                        }
                    }
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10038;
                    loopIdx0++;
                } while (true);
            }
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex3]) {
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            }
        }
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
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

    {
        int loopIdx0 = 0;
        do {
            loopIdx0++;
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                if (testBit(uvec4(0x64d5c99f, 0x1808a9af, 0xb00e2b66, 0xd0c9bc22), gl_SubgroupInvocationID)) {
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                } else {
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
                for (int loopIdx1 = 0;
                         loopIdx1 < gl_SubgroupInvocationID + 1;
                         loopIdx1++) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10009;
                }
            } else {
                for (int loopIdx1 = 0;
                         loopIdx1 < gl_SubgroupInvocationID + 1;
                         loopIdx1++) {
                }
                if (testBit(uvec4(0x7a40b0b4, 0xdcbb1113, 0xb95e8c54, 0xf401d3ec), gl_SubgroupInvocationID)) {
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
            }
            continue;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        } while (loopIdx0 < inputA.a[1]);
    }
    if (subgroupElect()) {
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
    }
    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex2]) {
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            for (int loopIdx0 = 0;
                     loopIdx0 < gl_SubgroupInvocationID + 1;
                     loopIdx0++) {
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            }
        }
        if (inputA.a[3] == 3) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10020;
            if (testBit(uvec4(0xdcc5ff96, 0x8154a0d3, 0x19ca424f, 0x5a437a79), gl_SubgroupInvocationID)) {
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            } else {
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            }
        }
    } else {
        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex3]) {
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            if (inputA.a[0] == 0) {
            } else {
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            }
            for (int loopIdx0 = 0;
                     loopIdx0 < gl_SubgroupInvocationID + 1;
                     loopIdx0++) {
            }
        }
        if (inputA.a[3] == 3) {
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex4]) {
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10035;
            if (subgroupElect()) {
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            }
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1003a;
    }
    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1003c;



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

    if (subgroupElect()) {
        if (testBit(uvec4(0x69b22f4b, 0xde19e3d2, 0x570385ca, 0xcb85febe), gl_SubgroupInvocationID)) {
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            {
                int loopIdx0 = 0;
                do {
                    loopIdx0++;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                } while (loopIdx0 < inputA.a[4]);
            }
        } else {
            switch (gl_SubgroupInvocationID & 3) {
                case 0:
                {
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000a;
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
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10015;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        }
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        for (int loopIdx0 = 0;
                 loopIdx0 < gl_SubgroupInvocationID + 1;
                 loopIdx0++) {
            if (inputA.a[2] == 2) {
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001c;
            } else {
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001f;
            }
            break;
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10022;
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
        if (inputA.a[0] == 0) {
            {
                int loopIdx1 = 0;
                do {
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10004;
                    if (subgroupElect()) {
                        break;
                    }
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10008;
                    loopIdx1++;
                } while (true);
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000a;
        } else {
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            if (inputA.a[1] == 1) {
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000f;
            } else {
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10012;
            }
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        }
        if (subgroupElect()) {
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
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        }
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        if (subgroupElect()) {
            break;
        }
        if (gl_SubgroupInvocationID == loopIdx0) {
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            switch (gl_SubgroupInvocationID & 3) {
                case 0:
                {
                    break;
                }
                case 1:
                {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002a;
                    break;
                }
                case 2:
                {
                    break;
                }
                case 3:
                {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002f;
                    break;
                }
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10032;
            break;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
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


void main()
[[maximally_reconverges]]
{

    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
        if (testBit(uvec4(0xba9b2883, 0x627a9aea, 0xe415efee, 0xc7b618da), gl_SubgroupInvocationID)) {
            if (inputA.a[2] == 2) {
            }
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        }
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        return;
    } else {
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        if (testBit(uvec4(0x9e3fb15d, 0xf894c5ce, 0xc0dfd81f, 0x7ef2adad), gl_SubgroupInvocationID)) {
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            if (inputA.a[0] == 0) {
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            }
            if (subgroupElect()) {
            }
        }
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
    }
    for (int loopIdx0 = 0;
             loopIdx0 < inputA.a[4];
             loopIdx0++) {
        switch (gl_SubgroupInvocationID & 3) {
            case 0:
            {
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                break;
            }
            case 1:
            {
                {
                    int loopIdx1 = 0;
                    do {
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001c;
                        if (subgroupElect()) {
                            break;
                        }
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10020;
                        loopIdx1++;
                    } while (true);
                }
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                break;
            }
            case 2:
            {
                if (gl_SubgroupInvocationID == loopIdx0) {
                }
                break;
            }
            case 3:
            {
                for (int loopIdx1 = 0;
                         loopIdx1 < inputA.a[5];
                         loopIdx1++) {
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
                break;
            }
        }
        if (gl_SubgroupInvocationID == loopIdx0) {
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            if (subgroupElect()) {
            }
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10033;
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            }
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        } else {
            if (inputA.a[1] == 1) {
            }
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            switch (loopIdx0) {
                case 1: {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1003e;
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
    {
        int loopIdx0 = 0;
        do {
            if (testBit(uvec4(0x7add8c04, 0x3871181, 0x475415fe, 0x72a638d5), gl_SubgroupInvocationID)) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10003;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            }
            switch (loopIdx0) {
                case 1: {
                    for (int loopIdx1 = 0;
                             loopIdx1 < gl_SubgroupInvocationID + 1;
                             loopIdx1++) {
                    }
                    break;
                }
                case 2: {
                    for (int loopIdx1 = 0;
                             loopIdx1 < inputA.a[3];
                             loopIdx1++) {
                    }
                    break;
                }
                default: {
                    if (inputA.a[1] == 1) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10011;
                    }
                    break;
                }
            }
            if (subgroupElect()) {
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                break;
            }
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
                if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                } else {
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
                        break;
                    }
                }
            } else {
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                if (gl_LocalInvocationIndex >= inputA.a[cmpIndex2]) {
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
                break;
            }
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            switch (gl_SubgroupInvocationID & 3) {
                case 0:
                {
                    break;
                }
                case 1:
                {
                    if (subgroupElect()) {
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    }
                    break;
                }
                case 2:
                {
                    for (int loopIdx1 = 0;
                             loopIdx1 < gl_SubgroupInvocationID + 1;
                             loopIdx1++) {
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    }
                    break;
                }
                case 3:
                {
                    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex3]) {
                    }
                    break;
                }
            }
            loopIdx0++;
        } while (true);
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


void main()
[[maximally_reconverges]]
{

    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10000;
    for (int loopIdx0 = 0;;loopIdx0++,    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true)) {
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        break;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        if (inputA.a[3] == 3) {
            if (gl_SubgroupInvocationID == loopIdx0) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10007;
                for (int loopIdx1 = 0;
                         loopIdx1 < gl_SubgroupInvocationID + 1;
                         loopIdx1++) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10009;
                }
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000c;
                if (inputA.a[3] == 3) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000e;
                } else {
                }
            } else {
                if (inputA.a[3] == 3) {
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            }
        }
        if (subgroupElect()) {
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001a;
            break;
        }
        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001f;
            {
                int loopIdx1 = 0;
                do {
                    loopIdx1++;
                    continue;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    if (inputA.a[2] == 2) {
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    } else {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10026;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    }
                } while (loopIdx1 < inputA.a[3]);
            }
            if (subgroupElect()) {
                if (gl_SubgroupInvocationID == loopIdx0) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002c;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
                {
                    int loopIdx1 = 0;
                    do {
                        if (subgroupElect()) {
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                            break;
                        }
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        loopIdx1++;
                    } while (true);
                }
            }
        } else {
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001f;
            {
                int loopIdx1 = 0;
                do {
                    loopIdx1++;
                    continue;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    if (inputA.a[0] == 0) {
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    } else {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10026;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    }
                } while (loopIdx1 < inputA.a[3]);
            }
            if (subgroupElect()) {
                if (gl_SubgroupInvocationID == loopIdx0) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002c;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
                {
                    int loopIdx1 = 0;
                    do {
                        if (subgroupElect()) {
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                            break;
                        }
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        loopIdx1++;
                    } while (true);
                }
            }
        }
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        break;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
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
    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
            {
                int loopIdx0 = 0;
                do {
                    loopIdx0++;
                    continue;
                    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex2]) {
                    } else {
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10008;
                    }
                } while (loopIdx0 < inputA.a[1]);
            }
            for (int loopIdx0 = 0;;loopIdx0++,            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true)) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000c;
                {
                    int loopIdx1 = 0;
                    do {
                        loopIdx1++;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    } while (loopIdx1 < inputA.a[4]);
                }
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10011;
                return;
                if (subgroupElect()) {
                    break;
                }
                if (gl_SubgroupInvocationID == loopIdx0) {
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                } else {
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
                if (inputA.a[1] == 1) {
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
            }
        }
        if (testBit(uvec4(0x1963f897, 0x8b4219b3, 0x92c36785, 0xf2d7d33), gl_SubgroupInvocationID)) {
            if (testBit(uvec4(0xf769d02, 0x9d77bef, 0xe2a0008a, 0x6bd6bd3a), gl_SubgroupInvocationID)) {
                if (gl_LocalInvocationIndex >= inputA.a[cmpIndex3]) {
                }
                if (inputA.a[2] == 2) {
                }
            }
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
layout(constant_id = 15) const uint cmpIndex5 = 0u;
layout(constant_id = 16) const uint cmpIndex6 = 0u;
layout(constant_id = 17) const uint cmpIndex7 = 0u;
layout(constant_id = 18) const uint cmpIndex8 = 0u;
layout(constant_id = 19) const uint cmpIndex9 = 0u;
layout(constant_id = 20) const uint cmpIndex10 = 0u;


void main()
[[maximally_reconverges]]
{

    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10002;
        if (testBit(uvec4(0x2451177d, 0xdcb3c008, 0xe709f5d7, 0xaa106ff5), gl_SubgroupInvocationID)) {
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                if (subgroupElect()) {
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10009;
            }
            switch (inputA.a[3]) {
                case 4:
                {
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    break;
                }
                case 3:
                {
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    break;
                }
                case 5:
                {
                    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex2]) {
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    }
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10016;
                    break;
                }
            }
        } else {
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
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10021;
                    break;
                }
                case 3:
                {
                    switch (inputA.a[2]) {
                        case 3:
                        {
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                            break;
                        }
                        case 2:
                        {
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10029;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                            break;
                        }
                        case 4:
                        {
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                            break;
                        }
                    }
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    break;
                }
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10033;
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex3]) {
                if (inputA.a[2] == 2) {
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                } else {
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
                if (gl_LocalInvocationIndex >= inputA.a[cmpIndex4]) {
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1003c;
                } else {
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
            } else {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10041;
                if (gl_LocalInvocationIndex >= inputA.a[cmpIndex5]) {
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
                for (int loopIdx0 = 0;
                         loopIdx0 < gl_SubgroupInvocationID + 1;
                         loopIdx0++) {
                }
            }
        }
        for (int loopIdx0 = 0;
                 loopIdx0 < gl_SubgroupInvocationID + 1;
                 loopIdx0++) {
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            if (gl_SubgroupInvocationID == loopIdx0) {
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                if (subgroupElect()) {
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
                if (gl_SubgroupInvocationID == loopIdx0) {
                } else {
                }
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            } else {
                if (subgroupElect()) {
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
                if (gl_SubgroupInvocationID == loopIdx0) {
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
            }
        }
    } else {
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10002;
        if (testBit(uvec4(0x2451177d, 0xdcb3c008, 0xe709f5d7, 0xaa106ff5), gl_SubgroupInvocationID)) {
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex6]) {
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                if (subgroupElect()) {
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10009;
            }
            switch (inputA.a[3]) {
                case 4:
                {
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    break;
                }
                case 3:
                {
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    break;
                }
                case 5:
                {
                    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex7]) {
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    }
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10016;
                    break;
                }
            }
        } else {
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
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10021;
                    break;
                }
                case 3:
                {
                    switch (inputA.a[2]) {
                        case 3:
                        {
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                            break;
                        }
                        case 2:
                        {
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10029;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                            break;
                        }
                        case 4:
                        {
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                            break;
                        }
                    }
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    break;
                }
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10033;
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex8]) {
                if (inputA.a[1] == 1) {
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                } else {
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
                if (gl_LocalInvocationIndex >= inputA.a[cmpIndex9]) {
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1003c;
                } else {
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
            } else {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10041;
                if (gl_LocalInvocationIndex >= inputA.a[cmpIndex10]) {
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
                for (int loopIdx0 = 0;
                         loopIdx0 < gl_SubgroupInvocationID + 1;
                         loopIdx0++) {
                }
            }
        }
        for (int loopIdx0 = 0;
                 loopIdx0 < gl_SubgroupInvocationID + 1;
                 loopIdx0++) {
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            if (gl_SubgroupInvocationID == loopIdx0) {
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                if (subgroupElect()) {
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
                if (gl_SubgroupInvocationID == loopIdx0) {
                } else {
                }
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            } else {
                if (subgroupElect()) {
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
                if (gl_SubgroupInvocationID == loopIdx0) {
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


void main()
[[maximally_reconverges]]
{

    {
        int loopIdx0 = 0;
        do {
            loopIdx0++;
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                if (testBit(uvec4(0x64d5c99f, 0x1808a9af, 0xb00e2b66, 0xd0c9bc22), gl_SubgroupInvocationID)) {
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    if (gl_SubgroupInvocationID == loopIdx0) {
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    } else {
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    }
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    {
                        int loopIdx1 = 0;
                        do {
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000c;
                            if (subgroupElect()) {
                                outputC.loc[gl_LocalInvocationIndex]++;
                                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000e;
                                break;
                            }
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                            loopIdx1++;
                        } while (true);
                    }
                }
                {
                    int loopIdx1 = 0;
                    do {
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10016;
                        {
                            int loopIdx2 = 0;
                            do {
                                if (subgroupElect()) {
                                    break;
                                }
                                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                                loopIdx2++;
                            } while (true);
                        }
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001d;
                        if (subgroupElect()) {
                            break;
                        }
                        for (int loopIdx2 = 0;
                                 loopIdx2 < gl_SubgroupInvocationID + 1;
                                 loopIdx2++) {
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        }
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        loopIdx1++;
                    } while (true);
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10026;
            } else {
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                break;
            }
            switch (inputA.a[2]) {
                case 3:
                {
                    switch (gl_SubgroupInvocationID & 3) {
                        case 0:
                        {
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                            if (inputA.a[1] == 1) {
                                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                            } else {
                                outputC.loc[gl_LocalInvocationIndex]++;
                                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10033;
                            }
                            break;
                        }
                        case 1:
                        {
                            if (gl_SubgroupInvocationID == loopIdx0) {
                                outputC.loc[gl_LocalInvocationIndex]++;
                                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10038;
                                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                            }
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
                                     loopIdx1 < inputA.a[1];
                                     loopIdx1++) {
                                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                            }
                            break;
                        }
                    }
                    break;
                }
                case 2:
                {
                    if (gl_SubgroupInvocationID == loopIdx0) {
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        if (gl_SubgroupInvocationID == loopIdx0) {
                        } else {
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1004d;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        }
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10051;
                    }
                    if (subgroupElect()) {
                        if (testBit(uvec4(0x7a40b0b4, 0xdcbb1113, 0xb95e8c54, 0xf401d3ec), gl_SubgroupInvocationID)) {
                            break;
                        } else {
                            break;
                        }
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10059;
                        if (inputA.a[1] == 1) {
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        } else {
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        }
                    }
                    break;
                }
                case 4:
                {
                    break;
                }
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10064;
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
layout(constant_id = 10) const uint cmpIndex0 = 0u;
layout(constant_id = 11) const uint cmpIndex1 = 0u;


void main()
[[maximally_reconverges]]
{

    if (subgroupElect()) {
        if (testBit(uvec4(0x69b22f4b, 0xde19e3d2, 0x570385ca, 0xcb85febe), gl_SubgroupInvocationID)) {
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            {
                int loopIdx0 = 0;
                do {
                    loopIdx0++;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
                    } else {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10007;
                    }
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    for (int loopIdx1 = 0;
                             loopIdx1 < gl_SubgroupInvocationID + 1;
                             loopIdx1++) {
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    }
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                } while (loopIdx0 < inputA.a[4]);
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000f;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        } else {
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            {
                int loopIdx0 = 0;
                do {
                    loopIdx0++;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
                    } else {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10007;
                    }
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    for (int loopIdx1 = 0;
                             loopIdx1 < gl_SubgroupInvocationID + 1;
                             loopIdx1++) {
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    }
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                } while (loopIdx0 < inputA.a[4]);
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000f;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        }
        for (int loopIdx0 = 0;
                 loopIdx0 < inputA.a[5];
                 loopIdx0++) {
            if (subgroupElect()) {
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10025;
                if (inputA.a[1] == 1) {
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
            }
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            {
                int loopIdx1 = 0;
                do {
                    {
                        int loopIdx2 = 0;
                        do {
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                            if (subgroupElect()) {
                                break;
                            }
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10031;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                            loopIdx2++;
                        } while (true);
                    }
                    {
                        int loopIdx2 = 0;
                        do {
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                            if (subgroupElect()) {
                                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                                break;
                            }
                            loopIdx2++;
                        } while (true);
                    }
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1003c;
                    if (subgroupElect()) {
                        break;
                    }
                    for (int loopIdx2 = 0;
                             loopIdx2 < inputA.a[4];
                             loopIdx2++) {
                    }
                    loopIdx1++;
                } while (true);
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
        if (inputA.a[3] == 3) {
            {
                int loopIdx1 = 0;
                do {
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
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
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000c;
                            break;
                        }
                    }
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    {
                        int loopIdx2 = 0;
                        do {
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                            if (subgroupElect()) {
                                outputC.loc[gl_LocalInvocationIndex]++;
                                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10013;
                                break;
                            }
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10016;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                            loopIdx2++;
                        } while (true);
                    }
                    if (subgroupElect()) {
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001b;
                        break;
                    }
                    switch (loopIdx1) {
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
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10027;
                    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
                    } else {
                    }
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002b;
                    loopIdx1++;
                } while (true);
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002d;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            break;
        }
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        if (subgroupElect()) {
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            break;
        }
        if (inputA.a[3] == 3) {
            switch (gl_SubgroupInvocationID & 3) {
                case 0:
                {
                    break;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    break;
                }
                case 1:
                {
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
                    }
                    break;
                }
                case 2:
                {
                    break;
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
                    break;
                }
            }
            break;
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10053;
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
layout(constant_id = 15) const uint cmpIndex5 = 0u;
layout(constant_id = 16) const uint cmpIndex6 = 0u;
layout(constant_id = 17) const uint cmpIndex7 = 0u;
layout(constant_id = 18) const uint cmpIndex8 = 0u;
layout(constant_id = 19) const uint cmpIndex9 = 0u;
layout(constant_id = 20) const uint cmpIndex10 = 0u;
layout(constant_id = 21) const uint cmpIndex11 = 0u;
layout(constant_id = 22) const uint cmpIndex12 = 0u;
layout(constant_id = 23) const uint cmpIndex13 = 0u;


void main()
[[maximally_reconverges]]
{

    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
        if (testBit(uvec4(0xba9b2883, 0x627a9aea, 0xe415efee, 0xc7b618da), gl_SubgroupInvocationID)) {
            if (inputA.a[0] == 0) {
                for (int loopIdx0 = 0;
                         loopIdx0 < inputA.a[1];
                         loopIdx0++) {
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
                if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10008;
            } else {
                if (gl_LocalInvocationIndex >= inputA.a[cmpIndex2]) {
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000d;
                if (gl_LocalInvocationIndex >= inputA.a[cmpIndex3]) {
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                } else {
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
            }
            if (inputA.a[0] == 0) {
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            }
        } else {
            if (inputA.a[1] == 1) {
                for (int loopIdx0 = 0;
                         loopIdx0 < inputA.a[1];
                         loopIdx0++) {
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
                if (gl_LocalInvocationIndex >= inputA.a[cmpIndex4]) {
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10008;
            } else {
                if (gl_LocalInvocationIndex >= inputA.a[cmpIndex5]) {
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000d;
                if (gl_LocalInvocationIndex >= inputA.a[cmpIndex6]) {
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                } else {
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
            }
            if (inputA.a[2] == 2) {
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            }
        }
        if (inputA.a[2] == 2) {
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex7]) {
                if (gl_LocalInvocationIndex >= inputA.a[cmpIndex8]) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10031;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                } else {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10031;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
                if (subgroupElect()) {
                }
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1003a;
            if (inputA.a[0] == 0) {
                if (gl_LocalInvocationIndex >= inputA.a[cmpIndex9]) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1003d;
                } else {
                }
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10041;
                {
                    int loopIdx0 = 0;
                    do {
                        loopIdx0++;
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10043;
                    } while (loopIdx0 < inputA.a[4]);
                }
            } else {
                if (inputA.a[1] == 1) {
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
                if (gl_LocalInvocationIndex >= inputA.a[cmpIndex10]) {
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1004d;
            }
        }
    } else {
        if (inputA.a[0] == 0) {
            for (int loopIdx0 = 0;;loopIdx0++,            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true)) {
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                if (gl_LocalInvocationIndex >= inputA.a[cmpIndex11]) {
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10056;
                } else {
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
                if (subgroupElect()) {
                    if (testBit(uvec4(0x823c9e27, 0xdc8c87e7, 0x409fc185, 0xc7d8a15), gl_SubgroupInvocationID)) {
                        break;
                    } else {
                        break;
                    }
                }
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                if (inputA.a[3] == 3) {
                }
                if (gl_LocalInvocationIndex >= inputA.a[cmpIndex12]) {
                }
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            }
            for (int loopIdx0 = 0;;loopIdx0++,            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true)) {
                if (gl_SubgroupInvocationID == loopIdx0) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1006a;
                }
                if (testBit(uvec4(0xba9b2883, 0x627a9aea, 0xe415efee, 0xc7b618da), gl_SubgroupInvocationID)) {
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                } else {
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
                if (subgroupElect()) {
                    break;
                }
                break;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10076;
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10078;
        } else {
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            if (subgroupElect()) {
                for (int loopIdx0 = 0;
                         loopIdx0 < gl_SubgroupInvocationID + 1;
                         loopIdx0++) {
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1007f;
            }
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        }
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        if (inputA.a[1] == 1) {
            if (subgroupElect()) {
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10087;
                if (inputA.a[3] == 3) {
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                } else {
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
            }
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex13]) {
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                {
                    int loopIdx0 = 0;
                    do {
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        if (subgroupElect()) {
                            break;
                        }
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10095;
                        loopIdx0++;
                    } while (true);
                }
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10098;
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


void main()
[[maximally_reconverges]]
{

    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10000;
    {
        int loopIdx0 = 0;
        do {
            if (testBit(uvec4(0x7add8c04, 0x3871181, 0x475415fe, 0x72a638d5), gl_SubgroupInvocationID)) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10003;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            }
            switch (loopIdx0) {
                case 1: {
                    for (int loopIdx1 = 0;
                             loopIdx1 < gl_SubgroupInvocationID + 1;
                             loopIdx1++) {
                        for (int loopIdx2 = 0;;loopIdx2++,                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true)) {
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                            if (subgroupElect()) {
                                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                                break;
                            }
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        }
                    }
                    break;
                }
                case 2: {
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    if (subgroupElect()) {
                        if (inputA.a[3] == 3) {
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        }
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        {
                            int loopIdx1 = 0;
                            do {
                                outputC.loc[gl_LocalInvocationIndex]++;
                                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001b;
                                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                                if (subgroupElect()) {
                                    outputC.loc[gl_LocalInvocationIndex]++;
                                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001e;
                                    if (testBit(uvec4(0xd42c613d, 0xdc94d4ee, 0x164d5461, 0x5a6d4ffb), gl_SubgroupInvocationID)) {
                                        break;
                                    } else {
                                        break;
                                    }
                                }
                                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                                loopIdx1++;
                            } while (true);
                        }
                    }
                    break;
                }
                default: {
                    switch (gl_SubgroupInvocationID & 3) {
                        case 0:
                        {
                            if (gl_SubgroupInvocationID == loopIdx0) {
                            }
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                            break;
                        }
                        case 1:
                        {
                            if (testBit(uvec4(0xdb9660d6, 0x6c04c1e2, 0x97265183, 0xebb4fec8), gl_SubgroupInvocationID)) {
                                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                            }
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                            break;
                        }
                        case 2:
                        {
                            break;
                        }
                        case 3:
                        {
                            if (inputA.a[0] == 0) {
                                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                            } else {
                                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                            }
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1003e;
                            break;
                        }
                    }
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    break;
                }
            }
            if (subgroupElect()) {
                break;
            }
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                break;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            }
            if (subgroupElect()) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1004d;
                {
                    int loopIdx1 = 0;
                    do {
                        loopIdx1++;
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1004f;
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
                                outputC.loc[gl_LocalInvocationIndex]++;
                                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10057;
                                break;
                            }
                            case 3:
                            {
                                break;
                            }
                        }
                        for (int loopIdx2 = 0;
                                 loopIdx2 < gl_SubgroupInvocationID + 1;
                                 loopIdx2++) {
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1005d;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        }
                    } while (loopIdx1 < inputA.a[2]);
                }
                switch (gl_SubgroupInvocationID & 3) {
                    case 0:
                    {
                        if (subgroupElect()) {
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10064;
                        }
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10067;
                        break;
                    }
                    case 1:
                    {
                        if (testBit(uvec4(0xd42c613d, 0xdc94d4ee, 0x164d5461, 0x5a6d4ffb), gl_SubgroupInvocationID)) {
                        } else {
                        }
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        break;
                    }
                    case 2:
                    {
                        break;
                        break;
                    }
                    case 3:
                    {
                        if (gl_SubgroupInvocationID == loopIdx0) {
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        } else {
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        }
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        break;
                    }
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1007b;
            }
            loopIdx0++;
        } while (true);
    }
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


void main()
[[subgroup_uniform_control_flow]]
{

    for (int loopIdx0 = 0;;loopIdx0++,    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect()) {
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10001;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        break;
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10004;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        if (inputA.a[3] == 3) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10007;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        } else {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10007;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000d;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        if (subgroupElect()) {
            break;
        }
        for (int loopIdx1 = 0;;loopIdx1++,        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect()) {
            if (subgroupElect()) {
                break;
            }
        }
    }
    if (subgroupElect()) {
        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001a;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        } else {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001d;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        }
        if (subgroupElect()) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10021;
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

    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10000;
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
    if (inputA.a[3] == 3) {
        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10005;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        {
            int loopIdx0 = 0;
            do {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10008;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                if (subgroupElect()) {
                    break;
                }
                loopIdx0++;
            } while (true);
        }
    }
    {
        int loopIdx0 = 0;
        do {
            loopIdx0++;
            switch (loopIdx0) {
                case 1: {
                    break;
                }
                case 2: {
                    break;
                }
                default: {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10016;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    break;
                }
            }
            break;
        } while (loopIdx0 < inputA.a[3]);
    }
    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001c;
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


void main()
[[subgroup_uniform_control_flow]]
{

    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10000;
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10004;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        }
    }
    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex2]) {
        if (testBit(uvec4(0xf769d02, 0x9d77bef, 0xe2a0008a, 0x6bd6bd3a), gl_SubgroupInvocationID)) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000a;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000d;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
    } else {
        switch (gl_SubgroupInvocationID & 3) {
            case 0:
            case 1:
            {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10012;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                break;
            }
            case 2:
            case 3:
            {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10016;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                break;
            }
        }
    }
    for (int loopIdx0 = 0;
             loopIdx0 < gl_SubgroupInvocationID + 1;
             loopIdx0++) {
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001c;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        for (int loopIdx1 = 0;;loopIdx1++,        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect()) {
            if (subgroupElect()) {
                break;
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10022;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        }
    }
    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10026;
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

    switch (inputA.a[2]) {
        case 3:
        {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10002;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10005;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            } else {
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10009;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            break;
        }
        case 2:
        {
            if (subgroupElect()) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000e;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            }
            break;
        }
        case 4:
        {
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
            }
            break;
        }
    }
    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10017;
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
    for (int loopIdx0 = 0;;loopIdx0++,    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect()) {
        switch (inputA.a[4]) {
            case 5:
            {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001c;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                break;
            }
            case 4:
            {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10020;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                break;
            }
            case 6:
            {
                break;
            }
        }
        break;
        if (subgroupElect()) {
            break;
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002a;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        for (int loopIdx1 = 0;
                 loopIdx1 < inputA.a[3];
                 loopIdx1++) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002d;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10030;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        if (testBit(uvec4(0xd1e6eb46, 0xe442a0b6, 0xf986abd3, 0x7e35676e), gl_SubgroupInvocationID)) {
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10034;
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


void main()
[[subgroup_uniform_control_flow]]
{

    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10000;
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
        if (testBit(uvec4(0x2451177d, 0xdcb3c008, 0xe709f5d7, 0xaa106ff5), gl_SubgroupInvocationID)) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10004;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        } else {
        }
        switch (gl_SubgroupInvocationID & 3) {
            case 0:
            case 1:
            {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000a;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                break;
            }
            case 2:
            case 3:
            {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000e;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                break;
            }
        }
    } else {
        if (testBit(uvec4(0xee6a85de, 0x830e345, 0xf7a56dfc, 0x3bb1816a), gl_SubgroupInvocationID)) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10014;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10017;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        {
            int loopIdx0 = 0;
            do {
                loopIdx0++;
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001a;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            } while (loopIdx0 < inputA.a[3]);
        }
    }
    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001e;
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

    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10000;
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
    if (subgroupElect()) {
        if (inputA.a[2] == 2) {
        } else {
        }
    }
    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10007;
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
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
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000e;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                break;
            }
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10012;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
    }
    for (int loopIdx0 = 0;;loopIdx0++,    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect()) {
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10016;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
        } else {
        }
        if (testBit(uvec4(0xc2d3e3ec, 0xbd6921e5, 0x75c6c187, 0x38b7d6e9), gl_SubgroupInvocationID)) {
        } else {
        }
        if (subgroupElect()) {
            break;
        }
        switch (inputA.a[0]) {
            case 1:
            {
                break;
            }
            case 0:
            {
                break;
            }
            case 2:
            {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10027;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                break;
            }
        }
    }
    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002c;
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

    {
        int loopIdx0 = 0;
        do {
            loopIdx0++;
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10002;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            } else {
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10006;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            for (int loopIdx1 = 0;
                     loopIdx1 < inputA.a[3];
                     loopIdx1++) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10009;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            }
        } while (loopIdx0 < inputA.a[1]);
    }
    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000d;
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
    if (testBit(uvec4(0x64d5c99f, 0x1808a9af, 0xb00e2b66, 0xd0c9bc22), gl_SubgroupInvocationID)) {
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10010;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
        } else {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10014;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10017;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        {
            int loopIdx0 = 0;
            do {
                if (subgroupElect()) {
                    break;
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001d;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
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
[[subgroup_uniform_control_flow]]
{

    if (subgroupElect()) {
        if (testBit(uvec4(0x69b22f4b, 0xde19e3d2, 0x570385ca, 0xcb85febe), gl_SubgroupInvocationID)) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10002;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10005;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
    }
    for (int loopIdx0 = 0;
             loopIdx0 < inputA.a[4];
             loopIdx0++) {
        if (subgroupElect()) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000a;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000d;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        break;
    }
    {
        int loopIdx0 = 0;
        do {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10012;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            if (inputA.a[2] == 2) {
            }
            {
                int loopIdx1 = 0;
                do {
                    loopIdx1++;
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10017;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                } while (loopIdx1 < inputA.a[3]);
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001a;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            if (subgroupElect()) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001d;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                break;
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10021;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            {
                int loopIdx1 = 0;
                do {
                    if (subgroupElect()) {
                        break;
                    }
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10027;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    loopIdx1++;
                } while (true);
            }
            if (inputA.a[1] == 1) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002b;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            } else {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002e;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            }
            loopIdx0++;
        } while (true);
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

    for (int loopIdx0 = 0;;loopIdx0++,    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect()) {
        if (inputA.a[2] == 2) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10002;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        } else {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10005;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        }
        break;
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10009;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        if (subgroupElect()) {
            break;
        }
        break;
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000f;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        {
            int loopIdx1 = 0;
            do {
                loopIdx1++;
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10012;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            } while (loopIdx1 < inputA.a[5]);
        }
    }
    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10017;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        if (inputA.a[3] == 3) {
        } else {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001b;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001e;
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

    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
        if (testBit(uvec4(0xba9b2883, 0x627a9aea, 0xe415efee, 0xc7b618da), gl_SubgroupInvocationID)) {
        }
        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10004;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        } else {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10007;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000a;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
    }
    for (int loopIdx0 = 0;;loopIdx0++,    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect()) {
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000e;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        if (inputA.a[0] == 0) {
        }
        if (subgroupElect()) {
            break;
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10015;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        break;
        if (testBit(uvec4(0xfc448fa1, 0x68b83ada, 0xcbbd07ad, 0x21ab9f7d), gl_SubgroupInvocationID)) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10019;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        } else {
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001d;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
    }
    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10020;
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


void main()
[[subgroup_uniform_control_flow]]
{

    {
        int loopIdx0 = 0;
        do {
            if (testBit(uvec4(0x7add8c04, 0x3871181, 0x475415fe, 0x72a638d5), gl_SubgroupInvocationID)) {
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10003;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            if (subgroupElect()) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10006;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                break;
            }
            {
                int loopIdx1 = 0;
                do {
                    loopIdx1++;
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000b;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                } while (loopIdx1 < inputA.a[4]);
            }
            if (gl_SubgroupInvocationID == loopIdx0) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000f;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            }
            loopIdx0++;
        } while (true);
    }
    if (testBit(uvec4(0xd42c613d, 0xdc94d4ee, 0x164d5461, 0x5a6d4ffb), gl_SubgroupInvocationID)) {
    }
    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
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
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001a;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                break;
            }
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
                break;
            }
        }
    } else {
        switch (gl_SubgroupInvocationID & 3) {
            case 0:
            case 1:
            {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10027;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                break;
            }
            case 2:
            case 3:
            {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002b;
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


void main()
[[subgroup_uniform_control_flow]]
{

    for (int loopIdx0 = 0;;loopIdx0++,    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect()) {
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10001;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        break;
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10004;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        if (inputA.a[2] == 2) {
            if (gl_SubgroupInvocationID == loopIdx0) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10008;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            } else {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000b;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            }
        } else {
            if (gl_SubgroupInvocationID == loopIdx0) {
            } else {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10011;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            }
            if (subgroupElect()) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10015;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10018;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        }
        if (subgroupElect()) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001c;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            switch (inputA.a[2]) {
                case 3:
                {
                    break;
                }
                case 2:
                {
                    break;
                }
                case 4:
                {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10024;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    break;
                }
            }
            break;
        }
        for (int loopIdx1 = 0;
                 loopIdx1 < gl_SubgroupInvocationID + 1;
                 loopIdx1++) {
            if (testBit(uvec4(0x73a02751, 0xdca3a206, 0xb07b76af, 0xfde17503), gl_SubgroupInvocationID)) {
                break;
            } else {
                break;
            }
        }
        {
            int loopIdx1 = 0;
            do {
                if (subgroupElect()) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10033;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                }
                if (subgroupElect()) {
                    break;
                }
                if (gl_SubgroupInvocationID == loopIdx1) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1003a;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                } else {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1003d;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10040;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                return;
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10043;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                loopIdx1++;
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
layout(constant_id = 12) const uint cmpIndex2 = 0u;


void main()
[[subgroup_uniform_control_flow]]
{

    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10000;
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
            {
                int loopIdx0 = 0;
                do {
                    loopIdx0++;
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10005;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                } while (loopIdx0 < inputA.a[1]);
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10008;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            for (int loopIdx0 = 0;;loopIdx0++,            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect()) {
                if (subgroupElect()) {
                    break;
                }
            }
        } else {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10010;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            if (testBit(uvec4(0x1963f897, 0x8b4219b3, 0x92c36785, 0xf2d7d33), gl_SubgroupInvocationID)) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10013;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10016;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        }
        switch (gl_SubgroupInvocationID & 3) {
            case 0:
            case 1:
            {
                if (testBit(uvec4(0x1963f897, 0x8b4219b3, 0x92c36785, 0xf2d7d33), gl_SubgroupInvocationID)) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001c;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                } else {
                }
                break;
            }
            case 2:
            case 3:
            {
                if (testBit(uvec4(0x1963f897, 0x8b4219b3, 0x92c36785, 0xf2d7d33), gl_SubgroupInvocationID)) {
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10024;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                if (subgroupElect()) {
                }
                break;
            }
        }
    } else {
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002b;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        {
            int loopIdx0 = 0;
            do {
                if (inputA.a[2] == 2) {
                } else {
                }
                for (int loopIdx1 = 0;;loopIdx1++,                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect()) {
                    if (subgroupElect()) {
                        break;
                    }
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10035;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10038;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                if (subgroupElect()) {
                    break;
                }
                break;
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1003e;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                if (gl_LocalInvocationIndex >= inputA.a[cmpIndex2]) {
                } else {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10042;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
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
layout(constant_id = 12) const uint cmpIndex2 = 0u;
layout(constant_id = 13) const uint cmpIndex3 = 0u;


void main()
[[subgroup_uniform_control_flow]]
{

    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10000;
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
        if (testBit(uvec4(0x2451177d, 0xdcb3c008, 0xe709f5d7, 0xaa106ff5), gl_SubgroupInvocationID)) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10004;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10007;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            }
            if (subgroupElect()) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000b;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            }
        } else {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000f;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        }
        if (testBit(uvec4(0xee6a85de, 0x830e345, 0xf7a56dfc, 0x3bb1816a), gl_SubgroupInvocationID)) {
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex2]) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10014;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            }
            {
                int loopIdx0 = 0;
                do {
                    if (subgroupElect()) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10019;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                        break;
                    }
                    loopIdx0++;
                } while (true);
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001e;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        } else {
            if (subgroupElect()) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10022;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10025;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            {
                int loopIdx0 = 0;
                do {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10028;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    if (subgroupElect()) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002b;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                        break;
                    }
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002f;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    loopIdx0++;
                } while (true);
            }
        }
    } else {
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10034;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        if (inputA.a[3] == 3) {
            {
                int loopIdx0 = 0;
                do {
                    if (subgroupElect()) {
                        if (testBit(uvec4(0x2451177d, 0xdcb3c008, 0xe709f5d7, 0xaa106ff5), gl_SubgroupInvocationID)) {
                            break;
                        } else {
                            break;
                        }
                    }
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1003f;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    loopIdx0++;
                } while (true);
            }
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex3]) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10043;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            }
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10047;
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


void main()
[[subgroup_uniform_control_flow]]
{

    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10000;
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10003;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        if (subgroupElect()) {
            switch (gl_SubgroupInvocationID & 3) {
                case 0:
                {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10008;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    break;
                }
                case 1:
                {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000c;
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
    }
    {
        int loopIdx0 = 0;
        do {
            loopIdx0++;
            break;
            if (gl_SubgroupInvocationID == loopIdx0) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001f;
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
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10027;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                        break;
                    }
                }
            } else {
                if (gl_SubgroupInvocationID == loopIdx0) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002d;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                } else {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10030;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10033;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                if (gl_SubgroupInvocationID == loopIdx0) {
                }
            }
        } while (loopIdx0 < inputA.a[5]);
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

    {
        int loopIdx0 = 0;
        do {
            loopIdx0++;
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10002;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                if (testBit(uvec4(0x64d5c99f, 0x1808a9af, 0xb00e2b66, 0xd0c9bc22), gl_SubgroupInvocationID)) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10005;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                } else {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10008;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                }
                for (int loopIdx1 = 0;
                         loopIdx1 < gl_SubgroupInvocationID + 1;
                         loopIdx1++) {
                }
            } else {
                for (int loopIdx1 = 0;
                         loopIdx1 < gl_SubgroupInvocationID + 1;
                         loopIdx1++) {
                }
                if (testBit(uvec4(0x7a40b0b4, 0xdcbb1113, 0xb95e8c54, 0xf401d3ec), gl_SubgroupInvocationID)) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10011;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                }
            }
            continue;
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10016;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        } while (loopIdx0 < inputA.a[1]);
    }
    if (subgroupElect()) {
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001a;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
    }
    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex2]) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001f;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            for (int loopIdx0 = 0;
                     loopIdx0 < gl_SubgroupInvocationID + 1;
                     loopIdx0++) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10022;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            }
        }
        if (inputA.a[3] == 3) {
            if (testBit(uvec4(0xdcc5ff96, 0x8154a0d3, 0x19ca424f, 0x5a437a79), gl_SubgroupInvocationID)) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10028;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            } else {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10028;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            }
        }
    } else {
        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex3]) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10031;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            if (inputA.a[0] == 0) {
            } else {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10035;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            }
            for (int loopIdx0 = 0;
                     loopIdx0 < gl_SubgroupInvocationID + 1;
                     loopIdx0++) {
            }
        }
        if (inputA.a[3] == 3) {
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex4]) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1003d;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            }
            if (subgroupElect()) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10041;
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


void main()
[[subgroup_uniform_control_flow]]
{

    if (subgroupElect()) {
        if (testBit(uvec4(0x69b22f4b, 0xde19e3d2, 0x570385ca, 0xcb85febe), gl_SubgroupInvocationID)) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10002;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            {
                int loopIdx0 = 0;
                do {
                    loopIdx0++;
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10005;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                } while (loopIdx0 < inputA.a[4]);
            }
        } else {
            switch (gl_SubgroupInvocationID & 3) {
                case 0:
                case 1:
                {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000b;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    break;
                }
                case 2:
                case 3:
                {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000f;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    break;
                }
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10013;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10016;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        for (int loopIdx0 = 0;
                 loopIdx0 < gl_SubgroupInvocationID + 1;
                 loopIdx0++) {
            if (inputA.a[2] == 2) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001a;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            } else {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001d;
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


void main()
[[subgroup_uniform_control_flow]]
{

    for (int loopIdx0 = 0;;loopIdx0++,    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect()) {
        if (inputA.a[0] == 0) {
            {
                int loopIdx1 = 0;
                do {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10003;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    if (subgroupElect()) {
                        break;
                    }
                    loopIdx1++;
                } while (true);
            }
        } else {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000a;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            if (inputA.a[1] == 1) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000d;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            } else {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10010;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10013;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        }
        if (subgroupElect()) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10017;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            {
                int loopIdx1 = 0;
                do {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001a;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    if (subgroupElect()) {
                        break;
                    }
                    loopIdx1++;
                } while (true);
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10020;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10023;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        if (subgroupElect()) {
            break;
        }
        if (gl_SubgroupInvocationID == loopIdx0) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10029;
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
                    break;
                }
            }
            break;
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10036;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
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
layout(constant_id = 10) const uint cmpIndex0 = 0u;
layout(constant_id = 11) const uint cmpIndex1 = 0u;


void main()
[[subgroup_uniform_control_flow]]
{

    {
        int loopIdx0 = 0;
        do {
            loopIdx0++;
            continue;
            if (gl_SubgroupInvocationID == loopIdx0) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10003;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                continue;
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10006;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                for (int loopIdx1 = 0;
                         loopIdx1 < inputA.a[2];
                         loopIdx1++) {
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000a;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            } else {
                {
                    int loopIdx1 = 0;
                    do {
                        loopIdx1++;
                    } while (loopIdx1 < inputA.a[1]);
                }
                {
                    int loopIdx1 = 0;
                    do {
                        loopIdx1++;
                    } while (loopIdx1 < inputA.a[1]);
                }
            }
        } while (loopIdx0 < inputA.a[5]);
    }
    if (inputA.a[0] == 0) {
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10014;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        if (testBit(uvec4(0xfded30bc, 0x9e3bcf7f, 0x28b84885, 0x16997569), gl_SubgroupInvocationID)) {
            if (inputA.a[1] == 1) {
            }
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
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001f;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        if (testBit(uvec4(0x9e3fb15d, 0xf894c5ce, 0xc0dfd81f, 0x7ef2adad), gl_SubgroupInvocationID)) {
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
            }
            if (subgroupElect()) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10025;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            }
        } else {
            for (int loopIdx0 = 0;
                     loopIdx0 < inputA.a[2];
                     loopIdx0++) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002a;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            }
            for (int loopIdx0 = 0;
                     loopIdx0 < gl_SubgroupInvocationID + 1;
                     loopIdx0++) {
            }
        }
    } else {
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10031;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        if (inputA.a[0] == 0) {
            if (inputA.a[3] == 3) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10035;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            } else {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10038;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            }
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1003c;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            } else {
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10040;
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

    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
        if (testBit(uvec4(0xba9b2883, 0x627a9aea, 0xe415efee, 0xc7b618da), gl_SubgroupInvocationID)) {
            if (inputA.a[2] == 2) {
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10004;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10007;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        return;
    } else {
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000b;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        if (testBit(uvec4(0x9e3fb15d, 0xf894c5ce, 0xc0dfd81f, 0x7ef2adad), gl_SubgroupInvocationID)) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000e;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            if (inputA.a[0] == 0) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10011;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            }
            if (subgroupElect()) {
            }
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10017;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
    }
    for (int loopIdx0 = 0;
             loopIdx0 < inputA.a[4];
             loopIdx0++) {
        switch (gl_SubgroupInvocationID & 3) {
            case 0:
            {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001d;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                break;
            }
            case 1:
            {
                {
                    int loopIdx1 = 0;
                    do {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10022;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                        if (subgroupElect()) {
                            break;
                        }
                        loopIdx1++;
                    } while (true);
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10028;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                break;
            }
            case 2:
            {
                if (gl_SubgroupInvocationID == loopIdx0) {
                }
                break;
            }
            case 3:
            {
                for (int loopIdx1 = 0;
                         loopIdx1 < inputA.a[5];
                         loopIdx1++) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10031;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                }
                break;
            }
        }
        if (gl_SubgroupInvocationID == loopIdx0) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10037;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            if (subgroupElect()) {
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1003b;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1003e;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10041;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        } else {
            if (inputA.a[1] == 1) {
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10046;
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
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1004e;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
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


void main()
[[subgroup_uniform_control_flow]]
{

    {
        int loopIdx0 = 0;
        do {
            if (testBit(uvec4(0x7add8c04, 0x3871181, 0x475415fe, 0x72a638d5), gl_SubgroupInvocationID)) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10002;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            }
            switch (loopIdx0) {
                case 1: {
                    for (int loopIdx1 = 0;
                             loopIdx1 < gl_SubgroupInvocationID + 1;
                             loopIdx1++) {
                    }
                    break;
                }
                case 2: {
                    for (int loopIdx1 = 0;
                             loopIdx1 < inputA.a[3];
                             loopIdx1++) {
                    }
                    break;
                }
                default: {
                    if (inputA.a[1] == 1) {
                    }
                    break;
                }
            }
            if (subgroupElect()) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10014;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                break;
            }
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
                if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001a;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                } else {
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001e;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                switch (gl_SubgroupInvocationID & 3) {
                    case 0:
                    case 1:
                    {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10022;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                        break;
                    }
                    case 2:
                    case 3:
                    {
                        break;
                    }
                }
            } else {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10029;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                if (gl_LocalInvocationIndex >= inputA.a[cmpIndex2]) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002c;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                }
                break;
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10031;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            switch (gl_SubgroupInvocationID & 3) {
                case 0:
                {
                    break;
                }
                case 1:
                {
                    if (subgroupElect()) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10038;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    }
                    break;
                }
                case 2:
                {
                    for (int loopIdx1 = 0;
                             loopIdx1 < gl_SubgroupInvocationID + 1;
                             loopIdx1++) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1003e;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    }
                    break;
                }
                case 3:
                {
                    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex3]) {
                    }
                    break;
                }
            }
            loopIdx0++;
        } while (true);
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

    if (subgroupElect()) {
        for (int loopIdx0 = 0;;loopIdx0++,        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect()) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10002;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            if (testBit(uvec4(0xd42c613d, 0xdc94d4ee, 0x164d5461, 0x5a6d4ffb), gl_SubgroupInvocationID)) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10005;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10008;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000b;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            }
            if (subgroupElect()) {
                break;
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10011;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10014;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            } else {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10014;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001a;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            if (gl_SubgroupInvocationID == loopIdx0) {
            }
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001f;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        if (subgroupElect()) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10022;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            switch (gl_SubgroupInvocationID & 3) {
                case 0:
                case 1:
                {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10026;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    break;
                }
                case 2:
                case 3:
                {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002a;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    break;
                }
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002e;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            if (testBit(uvec4(0xb59fc2fe, 0xdd679954, 0x5c9ed4c3, 0xf991283b), gl_SubgroupInvocationID)) {
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10032;
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
    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10003;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
    } else {
        switch (inputA.a[2]) {
            case 3:
            {
                if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
                } else {
                }
                break;
            }
            case 2:
            {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000d;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                for (int loopIdx0 = 0;;loopIdx0++,                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect()) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10010;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    if (subgroupElect()) {
                        break;
                    }
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10015;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                }
                break;
            }
            case 4:
            {
                break;
            }
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001c;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        if (subgroupElect()) {
            if (inputA.a[3] == 3) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10020;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10023;
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

    for (int loopIdx0 = 0;;loopIdx0++,    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect()) {
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10001;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        break;
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10004;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        if (inputA.a[3] == 3) {
            if (gl_SubgroupInvocationID == loopIdx0) {
                for (int loopIdx1 = 0;
                         loopIdx1 < gl_SubgroupInvocationID + 1;
                         loopIdx1++) {
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000a;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                if (inputA.a[3] == 3) {
                } else {
                }
            } else {
                if (inputA.a[3] == 3) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10011;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10014;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            }
        }
        if (subgroupElect()) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10019;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            break;
        }
        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001e;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            {
                int loopIdx1 = 0;
                do {
                    loopIdx1++;
                    continue;
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10022;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    if (inputA.a[2] == 2) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10025;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    } else {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10028;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    }
                } while (loopIdx1 < inputA.a[3]);
            }
            if (subgroupElect()) {
                if (gl_SubgroupInvocationID == loopIdx0) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002e;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                }
                {
                    int loopIdx1 = 0;
                    do {
                        if (subgroupElect()) {
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10033;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                            break;
                        }
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10037;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                        loopIdx1++;
                    } while (true);
                }
            }
        } else {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001e;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            {
                int loopIdx1 = 0;
                do {
                    loopIdx1++;
                    continue;
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10022;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    if (inputA.a[0] == 0) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10025;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    } else {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10028;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    }
                } while (loopIdx1 < inputA.a[3]);
            }
            if (subgroupElect()) {
                if (gl_SubgroupInvocationID == loopIdx0) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002e;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                }
                {
                    int loopIdx1 = 0;
                    do {
                        if (subgroupElect()) {
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10033;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                            break;
                        }
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10037;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                        loopIdx1++;
                    } while (true);
                }
            }
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1005a;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        break;
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1005d;
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
layout(constant_id = 12) const uint cmpIndex2 = 0u;
layout(constant_id = 13) const uint cmpIndex3 = 0u;


void main()
[[subgroup_uniform_control_flow]]
{

    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10000;
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
            {
                int loopIdx0 = 0;
                do {
                    loopIdx0++;
                    continue;
                    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex2]) {
                    } else {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10008;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    }
                } while (loopIdx0 < inputA.a[1]);
            }
            for (int loopIdx0 = 0;;loopIdx0++,            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect()) {
                {
                    int loopIdx1 = 0;
                    do {
                        loopIdx1++;
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000e;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    } while (loopIdx1 < inputA.a[4]);
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10011;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                return;
                if (subgroupElect()) {
                    break;
                }
                if (gl_SubgroupInvocationID == loopIdx0) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10018;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                } else {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001b;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                }
                if (inputA.a[1] == 1) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001f;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                }
            }
        }
        if (testBit(uvec4(0x1963f897, 0x8b4219b3, 0x92c36785, 0xf2d7d33), gl_SubgroupInvocationID)) {
            if (testBit(uvec4(0xf769d02, 0x9d77bef, 0xe2a0008a, 0x6bd6bd3a), gl_SubgroupInvocationID)) {
                if (gl_LocalInvocationIndex >= inputA.a[cmpIndex3]) {
                }
                if (inputA.a[2] == 2) {
                }
            }
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


void main()
[[subgroup_uniform_control_flow]]
{

    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10000;
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
        if (testBit(uvec4(0x2451177d, 0xdcb3c008, 0xe709f5d7, 0xaa106ff5), gl_SubgroupInvocationID)) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10004;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10007;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                if (subgroupElect()) {
                }
            }
            switch (inputA.a[3]) {
                case 4:
                {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000e;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    break;
                }
                case 3:
                {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10012;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    break;
                }
                case 5:
                {
                    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex2]) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10017;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    }
                    break;
                }
            }
        } else {
            switch (gl_SubgroupInvocationID & 3) {
                case 0:
                case 1:
                {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001f;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    break;
                }
                case 2:
                case 3:
                {
                    switch (inputA.a[2]) {
                        case 3:
                        {
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10025;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                            break;
                        }
                        case 2:
                        {
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10029;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                            break;
                        }
                        case 4:
                        {
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002d;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                            break;
                        }
                    }
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10031;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    break;
                }
            }
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex3]) {
                if (inputA.a[2] == 2) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10037;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                } else {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10037;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                }
                if (gl_LocalInvocationIndex >= inputA.a[cmpIndex4]) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1003e;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                } else {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10041;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                }
            } else {
                if (gl_LocalInvocationIndex >= inputA.a[cmpIndex5]) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10046;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                }
                for (int loopIdx0 = 0;
                         loopIdx0 < gl_SubgroupInvocationID + 1;
                         loopIdx0++) {
                }
            }
        }
        for (int loopIdx0 = 0;
                 loopIdx0 < gl_SubgroupInvocationID + 1;
                 loopIdx0++) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1004e;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            if (gl_SubgroupInvocationID == loopIdx0) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10051;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                if (subgroupElect()) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10054;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                }
                if (gl_SubgroupInvocationID == loopIdx0) {
                } else {
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1005a;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            } else {
                if (subgroupElect()) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1005e;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                }
                if (gl_SubgroupInvocationID == loopIdx0) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10062;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                }
            }
        }
    } else {
        if (testBit(uvec4(0x2451177d, 0xdcb3c008, 0xe709f5d7, 0xaa106ff5), gl_SubgroupInvocationID)) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10004;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex6]) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10007;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                if (subgroupElect()) {
                }
            }
            switch (inputA.a[3]) {
                case 4:
                {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000e;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    break;
                }
                case 3:
                {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10012;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    break;
                }
                case 5:
                {
                    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex7]) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10017;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    }
                    break;
                }
            }
        } else {
            switch (gl_SubgroupInvocationID & 3) {
                case 0:
                case 1:
                {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001f;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    break;
                }
                case 2:
                case 3:
                {
                    switch (inputA.a[2]) {
                        case 3:
                        {
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10025;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                            break;
                        }
                        case 2:
                        {
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10029;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                            break;
                        }
                        case 4:
                        {
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002d;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                            break;
                        }
                    }
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10031;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    break;
                }
            }
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex8]) {
                if (inputA.a[1] == 1) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10037;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                } else {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10037;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                }
                if (gl_LocalInvocationIndex >= inputA.a[cmpIndex9]) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1003e;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                } else {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10041;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                }
            } else {
                if (gl_LocalInvocationIndex >= inputA.a[cmpIndex10]) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10046;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                }
                for (int loopIdx0 = 0;
                         loopIdx0 < gl_SubgroupInvocationID + 1;
                         loopIdx0++) {
                }
            }
        }
        for (int loopIdx0 = 0;
                 loopIdx0 < gl_SubgroupInvocationID + 1;
                 loopIdx0++) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1004e;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            if (gl_SubgroupInvocationID == loopIdx0) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10051;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                if (subgroupElect()) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10054;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                }
                if (gl_SubgroupInvocationID == loopIdx0) {
                } else {
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1005a;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            } else {
                if (subgroupElect()) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1005e;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                }
                if (gl_SubgroupInvocationID == loopIdx0) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10062;
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


void main()
[[subgroup_uniform_control_flow]]
{

    {
        int loopIdx0 = 0;
        do {
            loopIdx0++;
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10002;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                if (testBit(uvec4(0x64d5c99f, 0x1808a9af, 0xb00e2b66, 0xd0c9bc22), gl_SubgroupInvocationID)) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10005;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    if (gl_SubgroupInvocationID == loopIdx0) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10008;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    } else {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000b;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    }
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000e;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    {
                        int loopIdx1 = 0;
                        do {
                            if (subgroupElect()) {
                                break;
                            }
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10014;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                            loopIdx1++;
                        } while (true);
                    }
                }
                {
                    int loopIdx1 = 0;
                    do {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10019;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                        {
                            int loopIdx2 = 0;
                            do {
                                if (subgroupElect()) {
                                    break;
                                }
                                outputC.loc[gl_LocalInvocationIndex]++;
                                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001f;
                                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                                loopIdx2++;
                            } while (true);
                        }
                        if (subgroupElect()) {
                            break;
                        }
                        for (int loopIdx2 = 0;
                                 loopIdx2 < gl_SubgroupInvocationID + 1;
                                 loopIdx2++) {
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10026;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                        }
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10029;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                        loopIdx1++;
                    } while (true);
                }
            } else {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002d;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                break;
            }
            switch (inputA.a[2]) {
                case 3:
                {
                    switch (gl_SubgroupInvocationID & 3) {
                        case 0:
                        {
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10035;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                            if (inputA.a[1] == 1) {
                                outputC.loc[gl_LocalInvocationIndex]++;
                                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10038;
                                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                            } else {
                            }
                            break;
                        }
                        case 1:
                        {
                            if (gl_SubgroupInvocationID == loopIdx0) {
                                outputC.loc[gl_LocalInvocationIndex]++;
                                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1003f;
                                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                            }
                            break;
                        }
                        case 2:
                        {
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10044;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                            if (subgroupElect()) {
                            }
                            break;
                        }
                        case 3:
                        {
                            for (int loopIdx1 = 0;
                                     loopIdx1 < inputA.a[1];
                                     loopIdx1++) {
                                outputC.loc[gl_LocalInvocationIndex]++;
                                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1004b;
                                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                            }
                            break;
                        }
                    }
                    break;
                }
                case 2:
                {
                    if (gl_SubgroupInvocationID == loopIdx0) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10053;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                        if (gl_SubgroupInvocationID == loopIdx0) {
                        } else {
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10057;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                        }
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1005a;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    }
                    if (subgroupElect()) {
                        if (testBit(uvec4(0x7a40b0b4, 0xdcbb1113, 0xb95e8c54, 0xf401d3ec), gl_SubgroupInvocationID)) {
                            break;
                        } else {
                            break;
                        }
                        if (inputA.a[1] == 1) {
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10064;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                        } else {
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10064;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                        }
                    }
                    break;
                }
                case 4:
                {
                    break;
                }
            }
        } while (loopIdx0 < inputA.a[1]);
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

    if (subgroupElect()) {
        if (testBit(uvec4(0x69b22f4b, 0xde19e3d2, 0x570385ca, 0xcb85febe), gl_SubgroupInvocationID)) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10002;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            {
                int loopIdx0 = 0;
                do {
                    loopIdx0++;
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10005;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
                    } else {
                    }
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000a;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    for (int loopIdx1 = 0;
                             loopIdx1 < gl_SubgroupInvocationID + 1;
                             loopIdx1++) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000d;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    }
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10010;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                } while (loopIdx0 < inputA.a[4]);
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10013;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        } else {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10002;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            {
                int loopIdx0 = 0;
                do {
                    loopIdx0++;
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10005;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
                    } else {
                    }
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000a;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    for (int loopIdx1 = 0;
                             loopIdx1 < gl_SubgroupInvocationID + 1;
                             loopIdx1++) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000d;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    }
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10010;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                } while (loopIdx0 < inputA.a[4]);
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10013;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        }
        for (int loopIdx0 = 0;
                 loopIdx0 < inputA.a[5];
                 loopIdx0++) {
            if (subgroupElect()) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002c;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                if (inputA.a[1] == 1) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002f;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                }
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10033;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            {
                int loopIdx1 = 0;
                do {
                    {
                        int loopIdx2 = 0;
                        do {
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10037;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                            if (subgroupElect()) {
                                break;
                            }
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1003c;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                            loopIdx2++;
                        } while (true);
                    }
                    {
                        int loopIdx2 = 0;
                        do {
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10040;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                            if (subgroupElect()) {
                                outputC.loc[gl_LocalInvocationIndex]++;
                                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10043;
                                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                                break;
                            }
                            loopIdx2++;
                        } while (true);
                    }
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10048;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    if (subgroupElect()) {
                        break;
                    }
                    for (int loopIdx2 = 0;
                             loopIdx2 < inputA.a[4];
                             loopIdx2++) {
                    }
                    loopIdx1++;
                } while (true);
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
        if (inputA.a[3] == 3) {
            {
                int loopIdx1 = 0;
                do {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10003;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    switch (inputA.a[1]) {
                        case 2:
                        {
                            break;
                        }
                        case 1:
                        {
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10009;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                            break;
                        }
                        case 3:
                        {
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000d;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                            break;
                        }
                    }
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10011;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    {
                        int loopIdx2 = 0;
                        do {
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10014;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                            if (subgroupElect()) {
                                break;
                            }
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10019;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                            loopIdx2++;
                        } while (true);
                    }
                    if (subgroupElect()) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001d;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                        break;
                    }
                    switch (loopIdx1) {
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
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10029;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
                    } else {
                    }
                    loopIdx1++;
                } while (true);
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002f;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            break;
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10033;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        if (subgroupElect()) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10036;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            break;
        }
        if (inputA.a[3] == 3) {
            switch (gl_SubgroupInvocationID & 3) {
                case 0:
                {
                    break;
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1003e;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    break;
                }
                case 1:
                {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10042;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
                    }
                    break;
                }
                case 2:
                {
                    break;
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
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1004f;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                            break;
                        }
                        case 5:
                        {
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10053;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                            break;
                        }
                    }
                    break;
                }
            }
            break;
        }
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
layout(constant_id = 15) const uint cmpIndex5 = 0u;
layout(constant_id = 16) const uint cmpIndex6 = 0u;
layout(constant_id = 17) const uint cmpIndex7 = 0u;
layout(constant_id = 18) const uint cmpIndex8 = 0u;
layout(constant_id = 19) const uint cmpIndex9 = 0u;
layout(constant_id = 20) const uint cmpIndex10 = 0u;
layout(constant_id = 21) const uint cmpIndex11 = 0u;
layout(constant_id = 22) const uint cmpIndex12 = 0u;
layout(constant_id = 23) const uint cmpIndex13 = 0u;


void main()
[[subgroup_uniform_control_flow]]
{

    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
        if (testBit(uvec4(0xba9b2883, 0x627a9aea, 0xe415efee, 0xc7b618da), gl_SubgroupInvocationID)) {
            if (inputA.a[0] == 0) {
                for (int loopIdx0 = 0;
                         loopIdx0 < inputA.a[1];
                         loopIdx0++) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10004;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                }
                if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
                }
            } else {
                if (gl_LocalInvocationIndex >= inputA.a[cmpIndex2]) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000b;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                }
                if (gl_LocalInvocationIndex >= inputA.a[cmpIndex3]) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000f;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                } else {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10012;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                }
            }
            if (inputA.a[0] == 0) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10017;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            }
        } else {
            if (inputA.a[1] == 1) {
                for (int loopIdx0 = 0;
                         loopIdx0 < inputA.a[1];
                         loopIdx0++) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10004;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                }
                if (gl_LocalInvocationIndex >= inputA.a[cmpIndex4]) {
                }
            } else {
                if (gl_LocalInvocationIndex >= inputA.a[cmpIndex5]) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000b;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                }
                if (gl_LocalInvocationIndex >= inputA.a[cmpIndex6]) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000f;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                } else {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10012;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                }
            }
            if (inputA.a[2] == 2) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10017;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            }
        }
        if (inputA.a[2] == 2) {
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex7]) {
                if (gl_LocalInvocationIndex >= inputA.a[cmpIndex8]) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10037;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                } else {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10037;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                }
                if (subgroupElect()) {
                }
            }
            if (inputA.a[0] == 0) {
                if (gl_LocalInvocationIndex >= inputA.a[cmpIndex9]) {
                } else {
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10044;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                {
                    int loopIdx0 = 0;
                    do {
                        loopIdx0++;
                    } while (loopIdx0 < inputA.a[4]);
                }
            } else {
                if (inputA.a[1] == 1) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1004a;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                }
                if (gl_LocalInvocationIndex >= inputA.a[cmpIndex10]) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1004e;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10051;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            }
        }
    } else {
        if (inputA.a[0] == 0) {
            for (int loopIdx0 = 0;;loopIdx0++,            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect()) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10058;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                if (gl_LocalInvocationIndex >= inputA.a[cmpIndex11]) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1005b;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                } else {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1005e;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                }
                if (subgroupElect()) {
                    if (testBit(uvec4(0x823c9e27, 0xdc8c87e7, 0x409fc185, 0xc7d8a15), gl_SubgroupInvocationID)) {
                        break;
                    } else {
                        break;
                    }
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10068;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                if (inputA.a[3] == 3) {
                }
                if (gl_LocalInvocationIndex >= inputA.a[cmpIndex12]) {
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1006e;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            }
            for (int loopIdx0 = 0;;loopIdx0++,            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect()) {
                if (gl_SubgroupInvocationID == loopIdx0) {
                }
                if (testBit(uvec4(0xba9b2883, 0x627a9aea, 0xe415efee, 0xc7b618da), gl_SubgroupInvocationID)) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10075;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                } else {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10078;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                }
                if (subgroupElect()) {
                    break;
                }
                break;
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1007f;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            }
        } else {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10083;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            if (subgroupElect()) {
                for (int loopIdx0 = 0;
                         loopIdx0 < gl_SubgroupInvocationID + 1;
                         loopIdx0++) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10087;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                }
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1008b;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1008e;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        if (inputA.a[1] == 1) {
            if (subgroupElect()) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10092;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                if (inputA.a[3] == 3) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10095;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                } else {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10098;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                }
            }
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex13]) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1009d;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                {
                    int loopIdx0 = 0;
                    do {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x100a0;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                        if (subgroupElect()) {
                            break;
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
layout(constant_id = 10) const uint cmpIndex0 = 0u;


void main()
[[subgroup_uniform_control_flow]]
{

    {
        int loopIdx0 = 0;
        do {
            if (testBit(uvec4(0x7add8c04, 0x3871181, 0x475415fe, 0x72a638d5), gl_SubgroupInvocationID)) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10002;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            }
            switch (loopIdx0) {
                case 1: {
                    for (int loopIdx1 = 0;
                             loopIdx1 < gl_SubgroupInvocationID + 1;
                             loopIdx1++) {
                        for (int loopIdx2 = 0;;loopIdx2++,                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect()) {
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10009;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                            if (subgroupElect()) {
                                outputC.loc[gl_LocalInvocationIndex]++;
                                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000c;
                                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                                break;
                            }
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10010;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                        }
                    }
                    break;
                }
                case 2: {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10016;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    if (subgroupElect()) {
                        if (inputA.a[3] == 3) {
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001a;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                        }
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001d;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                        {
                            int loopIdx1 = 0;
                            do {
                                outputC.loc[gl_LocalInvocationIndex]++;
                                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10020;
                                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                                if (subgroupElect()) {
                                    if (testBit(uvec4(0xd42c613d, 0xdc94d4ee, 0x164d5461, 0x5a6d4ffb), gl_SubgroupInvocationID)) {
                                        break;
                                    } else {
                                        break;
                                    }
                                }
                                outputC.loc[gl_LocalInvocationIndex]++;
                                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10029;
                                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                                loopIdx1++;
                            } while (true);
                        }
                    }
                    break;
                }
                default: {
                    switch (gl_SubgroupInvocationID & 3) {
                        case 0:
                        case 1:
                        {
                            if (gl_SubgroupInvocationID == loopIdx0) {
                            }
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10033;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                            if (testBit(uvec4(0xdb9660d6, 0x6c04c1e2, 0x97265183, 0xebb4fec8), gl_SubgroupInvocationID)) {
                                outputC.loc[gl_LocalInvocationIndex]++;
                                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10036;
                                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                            }
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10039;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                            break;
                        }
                        case 2:
                        case 3:
                        {
                            if (inputA.a[0] == 0) {
                                outputC.loc[gl_LocalInvocationIndex]++;
                                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1003e;
                                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                            } else {
                                outputC.loc[gl_LocalInvocationIndex]++;
                                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1003e;
                                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                            }
                            break;
                        }
                    }
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10046;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    break;
                }
            }
            if (subgroupElect()) {
                break;
            }
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1004e;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                break;
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10051;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            }
            if (subgroupElect()) {
                {
                    int loopIdx1 = 0;
                    do {
                        loopIdx1++;
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
                                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1005a;
                                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                                break;
                            }
                        }
                        for (int loopIdx2 = 0;
                                 loopIdx2 < gl_SubgroupInvocationID + 1;
                                 loopIdx2++) {
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1005f;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                        }
                    } while (loopIdx1 < inputA.a[2]);
                }
                switch (gl_SubgroupInvocationID & 3) {
                    case 0:
                    case 1:
                    {
                        if (subgroupElect()) {
                        }
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10067;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                        if (testBit(uvec4(0xd42c613d, 0xdc94d4ee, 0x164d5461, 0x5a6d4ffb), gl_SubgroupInvocationID)) {
                        } else {
                        }
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1006c;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                        break;
                    }
                    case 2:
                    case 3:
                    {
                        break;
                        if (gl_SubgroupInvocationID == loopIdx0) {
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10072;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                        } else {
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10072;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                        }
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10078;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                        break;
                    }
                }
            }
            loopIdx0++;
        } while (true);
    }
    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1007e;
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


void main()
[[subgroup_uniform_control_flow]]
{

    for (int loopIdx0 = 0;;loopIdx0++,    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true)) {
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10001;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        break;
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10004;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        if (inputA.a[3] == 3) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10007;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        } else {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10007;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000d;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        if (subgroupElect()) {
            break;
        }
        for (int loopIdx1 = 0;;loopIdx1++,        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true)) {
            if (subgroupElect()) {
                break;
            }
        }
    }
    if (subgroupElect()) {
        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001a;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        } else {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001d;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        }
        if (subgroupElect()) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10021;
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

    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10000;
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
    if (inputA.a[3] == 3) {
        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10005;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        {
            int loopIdx0 = 0;
            do {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10008;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                if (subgroupElect()) {
                    break;
                }
                loopIdx0++;
            } while (true);
        }
    }
    {
        int loopIdx0 = 0;
        do {
            loopIdx0++;
            switch (loopIdx0) {
                case 1: {
                    break;
                }
                case 2: {
                    break;
                }
                default: {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10016;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    break;
                }
            }
            break;
        } while (loopIdx0 < inputA.a[3]);
    }
    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001c;
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


void main()
[[subgroup_uniform_control_flow]]
{

    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10000;
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10004;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        }
    }
    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex2]) {
        if (testBit(uvec4(0xf769d02, 0x9d77bef, 0xe2a0008a, 0x6bd6bd3a), gl_SubgroupInvocationID)) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000a;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000d;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
    } else {
        switch (gl_SubgroupInvocationID & 3) {
            case 0:
            case 1:
            {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10012;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                break;
            }
            case 2:
            case 3:
            {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10016;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                break;
            }
        }
    }
    for (int loopIdx0 = 0;
             loopIdx0 < gl_SubgroupInvocationID + 1;
             loopIdx0++) {
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001c;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        for (int loopIdx1 = 0;;loopIdx1++,        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true)) {
            if (subgroupElect()) {
                break;
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10022;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        }
    }
    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10026;
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

    switch (inputA.a[2]) {
        case 3:
        {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10002;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10005;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            } else {
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10009;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            break;
        }
        case 2:
        {
            if (subgroupElect()) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000e;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            }
            break;
        }
        case 4:
        {
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
            }
            break;
        }
    }
    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10017;
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
    for (int loopIdx0 = 0;;loopIdx0++,    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true)) {
        switch (inputA.a[4]) {
            case 5:
            {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001c;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                break;
            }
            case 4:
            {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10020;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                break;
            }
            case 6:
            {
                break;
            }
        }
        break;
        if (subgroupElect()) {
            break;
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002a;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        for (int loopIdx1 = 0;
                 loopIdx1 < inputA.a[3];
                 loopIdx1++) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002d;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10030;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        if (testBit(uvec4(0xd1e6eb46, 0xe442a0b6, 0xf986abd3, 0x7e35676e), gl_SubgroupInvocationID)) {
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10034;
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


void main()
[[subgroup_uniform_control_flow]]
{

    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10000;
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
        if (testBit(uvec4(0x2451177d, 0xdcb3c008, 0xe709f5d7, 0xaa106ff5), gl_SubgroupInvocationID)) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10004;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        } else {
        }
        switch (gl_SubgroupInvocationID & 3) {
            case 0:
            case 1:
            {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000a;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                break;
            }
            case 2:
            case 3:
            {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000e;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                break;
            }
        }
    } else {
        if (testBit(uvec4(0xee6a85de, 0x830e345, 0xf7a56dfc, 0x3bb1816a), gl_SubgroupInvocationID)) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10014;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10017;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        {
            int loopIdx0 = 0;
            do {
                loopIdx0++;
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001a;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            } while (loopIdx0 < inputA.a[3]);
        }
    }
    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001e;
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

    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10000;
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
    if (subgroupElect()) {
        if (inputA.a[2] == 2) {
        } else {
        }
    }
    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10007;
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
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
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000e;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                break;
            }
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10012;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
    }
    for (int loopIdx0 = 0;;loopIdx0++,    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true)) {
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10016;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
        } else {
        }
        if (testBit(uvec4(0xc2d3e3ec, 0xbd6921e5, 0x75c6c187, 0x38b7d6e9), gl_SubgroupInvocationID)) {
        } else {
        }
        if (subgroupElect()) {
            break;
        }
        switch (inputA.a[0]) {
            case 1:
            {
                break;
            }
            case 0:
            {
                break;
            }
            case 2:
            {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10027;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                break;
            }
        }
    }
    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002c;
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

    {
        int loopIdx0 = 0;
        do {
            loopIdx0++;
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10002;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            } else {
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10006;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            for (int loopIdx1 = 0;
                     loopIdx1 < inputA.a[3];
                     loopIdx1++) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10009;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            }
        } while (loopIdx0 < inputA.a[1]);
    }
    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000d;
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
    if (testBit(uvec4(0x64d5c99f, 0x1808a9af, 0xb00e2b66, 0xd0c9bc22), gl_SubgroupInvocationID)) {
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10010;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
        } else {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10014;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10017;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        {
            int loopIdx0 = 0;
            do {
                if (subgroupElect()) {
                    break;
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001d;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
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
[[subgroup_uniform_control_flow]]
{

    if (subgroupElect()) {
        if (testBit(uvec4(0x69b22f4b, 0xde19e3d2, 0x570385ca, 0xcb85febe), gl_SubgroupInvocationID)) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10002;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10005;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
    }
    for (int loopIdx0 = 0;
             loopIdx0 < inputA.a[4];
             loopIdx0++) {
        if (subgroupElect()) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000a;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000d;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        break;
    }
    {
        int loopIdx0 = 0;
        do {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10012;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            if (inputA.a[2] == 2) {
            }
            {
                int loopIdx1 = 0;
                do {
                    loopIdx1++;
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10017;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                } while (loopIdx1 < inputA.a[3]);
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001a;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            if (subgroupElect()) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001d;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                break;
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10021;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            {
                int loopIdx1 = 0;
                do {
                    if (subgroupElect()) {
                        break;
                    }
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10027;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    loopIdx1++;
                } while (true);
            }
            if (inputA.a[1] == 1) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002b;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            } else {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002e;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            }
            loopIdx0++;
        } while (true);
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

    for (int loopIdx0 = 0;;loopIdx0++,    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true)) {
        if (inputA.a[2] == 2) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10002;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        } else {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10005;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        }
        break;
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10009;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        if (subgroupElect()) {
            break;
        }
        break;
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000f;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        {
            int loopIdx1 = 0;
            do {
                loopIdx1++;
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10012;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            } while (loopIdx1 < inputA.a[5]);
        }
    }
    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10017;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        if (inputA.a[3] == 3) {
        } else {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001b;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001e;
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

    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
        if (testBit(uvec4(0xba9b2883, 0x627a9aea, 0xe415efee, 0xc7b618da), gl_SubgroupInvocationID)) {
        }
        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10004;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        } else {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10007;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000a;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
    }
    for (int loopIdx0 = 0;;loopIdx0++,    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true)) {
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000e;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        if (inputA.a[0] == 0) {
        }
        if (subgroupElect()) {
            break;
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10015;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        break;
        if (testBit(uvec4(0xfc448fa1, 0x68b83ada, 0xcbbd07ad, 0x21ab9f7d), gl_SubgroupInvocationID)) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10019;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        } else {
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001d;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
    }
    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10020;
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


void main()
[[subgroup_uniform_control_flow]]
{

    {
        int loopIdx0 = 0;
        do {
            if (testBit(uvec4(0x7add8c04, 0x3871181, 0x475415fe, 0x72a638d5), gl_SubgroupInvocationID)) {
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10003;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            if (subgroupElect()) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10006;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                break;
            }
            {
                int loopIdx1 = 0;
                do {
                    loopIdx1++;
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000b;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                } while (loopIdx1 < inputA.a[4]);
            }
            if (gl_SubgroupInvocationID == loopIdx0) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000f;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            }
            loopIdx0++;
        } while (true);
    }
    if (testBit(uvec4(0xd42c613d, 0xdc94d4ee, 0x164d5461, 0x5a6d4ffb), gl_SubgroupInvocationID)) {
    }
    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
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
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001a;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                break;
            }
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
                break;
            }
        }
    } else {
        switch (gl_SubgroupInvocationID & 3) {
            case 0:
            case 1:
            {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10027;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                break;
            }
            case 2:
            case 3:
            {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002b;
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


void main()
[[subgroup_uniform_control_flow]]
{

    for (int loopIdx0 = 0;;loopIdx0++,    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true)) {
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10001;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        break;
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10004;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        if (inputA.a[2] == 2) {
            if (gl_SubgroupInvocationID == loopIdx0) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10008;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            } else {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000b;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            }
        } else {
            if (gl_SubgroupInvocationID == loopIdx0) {
            } else {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10011;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            }
            if (subgroupElect()) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10015;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10018;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        }
        if (subgroupElect()) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001c;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            switch (inputA.a[2]) {
                case 3:
                {
                    break;
                }
                case 2:
                {
                    break;
                }
                case 4:
                {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10024;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    break;
                }
            }
            break;
        }
        for (int loopIdx1 = 0;
                 loopIdx1 < gl_SubgroupInvocationID + 1;
                 loopIdx1++) {
            if (testBit(uvec4(0x73a02751, 0xdca3a206, 0xb07b76af, 0xfde17503), gl_SubgroupInvocationID)) {
                break;
            } else {
                break;
            }
        }
        {
            int loopIdx1 = 0;
            do {
                if (subgroupElect()) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10033;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
                if (subgroupElect()) {
                    break;
                }
                if (gl_SubgroupInvocationID == loopIdx1) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1003a;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                } else {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1003d;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10040;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                return;
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10043;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                loopIdx1++;
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
layout(constant_id = 12) const uint cmpIndex2 = 0u;


void main()
[[subgroup_uniform_control_flow]]
{

    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10000;
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
            {
                int loopIdx0 = 0;
                do {
                    loopIdx0++;
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10005;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                } while (loopIdx0 < inputA.a[1]);
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10008;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            for (int loopIdx0 = 0;;loopIdx0++,            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true)) {
                if (subgroupElect()) {
                    break;
                }
            }
        } else {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10010;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            if (testBit(uvec4(0x1963f897, 0x8b4219b3, 0x92c36785, 0xf2d7d33), gl_SubgroupInvocationID)) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10013;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10016;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        }
        switch (gl_SubgroupInvocationID & 3) {
            case 0:
            case 1:
            {
                if (testBit(uvec4(0x1963f897, 0x8b4219b3, 0x92c36785, 0xf2d7d33), gl_SubgroupInvocationID)) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001c;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                } else {
                }
                break;
            }
            case 2:
            case 3:
            {
                if (testBit(uvec4(0x1963f897, 0x8b4219b3, 0x92c36785, 0xf2d7d33), gl_SubgroupInvocationID)) {
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10024;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                if (subgroupElect()) {
                }
                break;
            }
        }
    } else {
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002b;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        {
            int loopIdx0 = 0;
            do {
                if (inputA.a[2] == 2) {
                } else {
                }
                for (int loopIdx1 = 0;;loopIdx1++,                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true)) {
                    if (subgroupElect()) {
                        break;
                    }
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10035;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10038;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                if (subgroupElect()) {
                    break;
                }
                break;
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1003e;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                if (gl_LocalInvocationIndex >= inputA.a[cmpIndex2]) {
                } else {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10042;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
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
layout(constant_id = 12) const uint cmpIndex2 = 0u;
layout(constant_id = 13) const uint cmpIndex3 = 0u;


void main()
[[subgroup_uniform_control_flow]]
{

    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10000;
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
        if (testBit(uvec4(0x2451177d, 0xdcb3c008, 0xe709f5d7, 0xaa106ff5), gl_SubgroupInvocationID)) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10004;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10007;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            }
            if (subgroupElect()) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000b;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            }
        } else {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000f;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        }
        if (testBit(uvec4(0xee6a85de, 0x830e345, 0xf7a56dfc, 0x3bb1816a), gl_SubgroupInvocationID)) {
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex2]) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10014;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            }
            {
                int loopIdx0 = 0;
                do {
                    if (subgroupElect()) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10019;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        break;
                    }
                    loopIdx0++;
                } while (true);
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001e;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        } else {
            if (subgroupElect()) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10022;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10025;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            {
                int loopIdx0 = 0;
                do {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10028;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    if (subgroupElect()) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002b;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        break;
                    }
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002f;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    loopIdx0++;
                } while (true);
            }
        }
    } else {
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10034;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        if (inputA.a[3] == 3) {
            {
                int loopIdx0 = 0;
                do {
                    if (subgroupElect()) {
                        if (testBit(uvec4(0x2451177d, 0xdcb3c008, 0xe709f5d7, 0xaa106ff5), gl_SubgroupInvocationID)) {
                            break;
                        } else {
                            break;
                        }
                    }
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1003f;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    loopIdx0++;
                } while (true);
            }
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex3]) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10043;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            }
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10047;
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


void main()
[[subgroup_uniform_control_flow]]
{

    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10000;
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10003;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        if (subgroupElect()) {
            switch (gl_SubgroupInvocationID & 3) {
                case 0:
                {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10008;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    break;
                }
                case 1:
                {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000c;
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
    }
    {
        int loopIdx0 = 0;
        do {
            loopIdx0++;
            break;
            if (gl_SubgroupInvocationID == loopIdx0) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001f;
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
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10027;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        break;
                    }
                }
            } else {
                if (gl_SubgroupInvocationID == loopIdx0) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002d;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                } else {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10030;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10033;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                if (gl_SubgroupInvocationID == loopIdx0) {
                }
            }
        } while (loopIdx0 < inputA.a[5]);
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

    {
        int loopIdx0 = 0;
        do {
            loopIdx0++;
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10002;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                if (testBit(uvec4(0x64d5c99f, 0x1808a9af, 0xb00e2b66, 0xd0c9bc22), gl_SubgroupInvocationID)) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10005;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                } else {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10008;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
                for (int loopIdx1 = 0;
                         loopIdx1 < gl_SubgroupInvocationID + 1;
                         loopIdx1++) {
                }
            } else {
                for (int loopIdx1 = 0;
                         loopIdx1 < gl_SubgroupInvocationID + 1;
                         loopIdx1++) {
                }
                if (testBit(uvec4(0x7a40b0b4, 0xdcbb1113, 0xb95e8c54, 0xf401d3ec), gl_SubgroupInvocationID)) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10011;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
            }
            continue;
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10016;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        } while (loopIdx0 < inputA.a[1]);
    }
    if (subgroupElect()) {
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001a;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
    }
    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex2]) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001f;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            for (int loopIdx0 = 0;
                     loopIdx0 < gl_SubgroupInvocationID + 1;
                     loopIdx0++) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10022;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            }
        }
        if (inputA.a[3] == 3) {
            if (testBit(uvec4(0xdcc5ff96, 0x8154a0d3, 0x19ca424f, 0x5a437a79), gl_SubgroupInvocationID)) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10028;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            } else {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10028;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            }
        }
    } else {
        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex3]) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10031;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            if (inputA.a[0] == 0) {
            } else {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10035;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            }
            for (int loopIdx0 = 0;
                     loopIdx0 < gl_SubgroupInvocationID + 1;
                     loopIdx0++) {
            }
        }
        if (inputA.a[3] == 3) {
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex4]) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1003d;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            }
            if (subgroupElect()) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10041;
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


void main()
[[subgroup_uniform_control_flow]]
{

    if (subgroupElect()) {
        if (testBit(uvec4(0x69b22f4b, 0xde19e3d2, 0x570385ca, 0xcb85febe), gl_SubgroupInvocationID)) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10002;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            {
                int loopIdx0 = 0;
                do {
                    loopIdx0++;
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10005;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                } while (loopIdx0 < inputA.a[4]);
            }
        } else {
            switch (gl_SubgroupInvocationID & 3) {
                case 0:
                case 1:
                {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000b;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    break;
                }
                case 2:
                case 3:
                {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000f;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    break;
                }
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10013;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10016;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        for (int loopIdx0 = 0;
                 loopIdx0 < gl_SubgroupInvocationID + 1;
                 loopIdx0++) {
            if (inputA.a[2] == 2) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001a;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            } else {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001d;
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


void main()
[[subgroup_uniform_control_flow]]
{

    for (int loopIdx0 = 0;;loopIdx0++,    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true)) {
        if (inputA.a[0] == 0) {
            {
                int loopIdx1 = 0;
                do {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10003;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    if (subgroupElect()) {
                        break;
                    }
                    loopIdx1++;
                } while (true);
            }
        } else {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000a;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            if (inputA.a[1] == 1) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000d;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            } else {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10010;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10013;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        }
        if (subgroupElect()) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10017;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            {
                int loopIdx1 = 0;
                do {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001a;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    if (subgroupElect()) {
                        break;
                    }
                    loopIdx1++;
                } while (true);
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10020;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10023;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        if (subgroupElect()) {
            break;
        }
        if (gl_SubgroupInvocationID == loopIdx0) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10029;
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
                    break;
                }
            }
            break;
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10036;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
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
layout(constant_id = 10) const uint cmpIndex0 = 0u;
layout(constant_id = 11) const uint cmpIndex1 = 0u;


void main()
[[subgroup_uniform_control_flow]]
{

    {
        int loopIdx0 = 0;
        do {
            loopIdx0++;
            continue;
            if (gl_SubgroupInvocationID == loopIdx0) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10003;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                continue;
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10006;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                for (int loopIdx1 = 0;
                         loopIdx1 < inputA.a[2];
                         loopIdx1++) {
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000a;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            } else {
                {
                    int loopIdx1 = 0;
                    do {
                        loopIdx1++;
                    } while (loopIdx1 < inputA.a[1]);
                }
                {
                    int loopIdx1 = 0;
                    do {
                        loopIdx1++;
                    } while (loopIdx1 < inputA.a[1]);
                }
            }
        } while (loopIdx0 < inputA.a[5]);
    }
    if (inputA.a[0] == 0) {
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10014;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        if (testBit(uvec4(0xfded30bc, 0x9e3bcf7f, 0x28b84885, 0x16997569), gl_SubgroupInvocationID)) {
            if (inputA.a[1] == 1) {
            }
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
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001f;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        if (testBit(uvec4(0x9e3fb15d, 0xf894c5ce, 0xc0dfd81f, 0x7ef2adad), gl_SubgroupInvocationID)) {
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
            }
            if (subgroupElect()) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10025;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            }
        } else {
            for (int loopIdx0 = 0;
                     loopIdx0 < inputA.a[2];
                     loopIdx0++) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002a;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            }
            for (int loopIdx0 = 0;
                     loopIdx0 < gl_SubgroupInvocationID + 1;
                     loopIdx0++) {
            }
        }
    } else {
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10031;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        if (inputA.a[0] == 0) {
            if (inputA.a[3] == 3) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10035;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            } else {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10038;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            }
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1003c;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            } else {
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10040;
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

    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
        if (testBit(uvec4(0xba9b2883, 0x627a9aea, 0xe415efee, 0xc7b618da), gl_SubgroupInvocationID)) {
            if (inputA.a[2] == 2) {
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10004;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10007;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        return;
    } else {
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000b;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        if (testBit(uvec4(0x9e3fb15d, 0xf894c5ce, 0xc0dfd81f, 0x7ef2adad), gl_SubgroupInvocationID)) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000e;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            if (inputA.a[0] == 0) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10011;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            }
            if (subgroupElect()) {
            }
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10017;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
    }
    for (int loopIdx0 = 0;
             loopIdx0 < inputA.a[4];
             loopIdx0++) {
        switch (gl_SubgroupInvocationID & 3) {
            case 0:
            {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001d;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                break;
            }
            case 1:
            {
                {
                    int loopIdx1 = 0;
                    do {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10022;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        if (subgroupElect()) {
                            break;
                        }
                        loopIdx1++;
                    } while (true);
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10028;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                break;
            }
            case 2:
            {
                if (gl_SubgroupInvocationID == loopIdx0) {
                }
                break;
            }
            case 3:
            {
                for (int loopIdx1 = 0;
                         loopIdx1 < inputA.a[5];
                         loopIdx1++) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10031;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
                break;
            }
        }
        if (gl_SubgroupInvocationID == loopIdx0) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10037;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            if (subgroupElect()) {
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1003b;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1003e;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10041;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        } else {
            if (inputA.a[1] == 1) {
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10046;
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
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1004e;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
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


void main()
[[subgroup_uniform_control_flow]]
{

    {
        int loopIdx0 = 0;
        do {
            if (testBit(uvec4(0x7add8c04, 0x3871181, 0x475415fe, 0x72a638d5), gl_SubgroupInvocationID)) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10002;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            }
            switch (loopIdx0) {
                case 1: {
                    for (int loopIdx1 = 0;
                             loopIdx1 < gl_SubgroupInvocationID + 1;
                             loopIdx1++) {
                    }
                    break;
                }
                case 2: {
                    for (int loopIdx1 = 0;
                             loopIdx1 < inputA.a[3];
                             loopIdx1++) {
                    }
                    break;
                }
                default: {
                    if (inputA.a[1] == 1) {
                    }
                    break;
                }
            }
            if (subgroupElect()) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10014;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                break;
            }
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
                if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001a;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                } else {
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001e;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                switch (gl_SubgroupInvocationID & 3) {
                    case 0:
                    case 1:
                    {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10022;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        break;
                    }
                    case 2:
                    case 3:
                    {
                        break;
                    }
                }
            } else {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10029;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                if (gl_LocalInvocationIndex >= inputA.a[cmpIndex2]) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002c;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
                break;
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10031;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            switch (gl_SubgroupInvocationID & 3) {
                case 0:
                {
                    break;
                }
                case 1:
                {
                    if (subgroupElect()) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10038;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    }
                    break;
                }
                case 2:
                {
                    for (int loopIdx1 = 0;
                             loopIdx1 < gl_SubgroupInvocationID + 1;
                             loopIdx1++) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1003e;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    }
                    break;
                }
                case 3:
                {
                    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex3]) {
                    }
                    break;
                }
            }
            loopIdx0++;
        } while (true);
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

    if (subgroupElect()) {
        for (int loopIdx0 = 0;;loopIdx0++,        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true)) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10002;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            if (testBit(uvec4(0xd42c613d, 0xdc94d4ee, 0x164d5461, 0x5a6d4ffb), gl_SubgroupInvocationID)) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10005;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10008;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000b;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            }
            if (subgroupElect()) {
                break;
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10011;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10014;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            } else {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10014;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001a;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            if (gl_SubgroupInvocationID == loopIdx0) {
            }
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001f;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        if (subgroupElect()) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10022;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            switch (gl_SubgroupInvocationID & 3) {
                case 0:
                case 1:
                {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10026;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    break;
                }
                case 2:
                case 3:
                {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002a;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    break;
                }
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002e;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            if (testBit(uvec4(0xb59fc2fe, 0xdd679954, 0x5c9ed4c3, 0xf991283b), gl_SubgroupInvocationID)) {
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10032;
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
    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10003;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
    } else {
        switch (inputA.a[2]) {
            case 3:
            {
                if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
                } else {
                }
                break;
            }
            case 2:
            {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000d;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                for (int loopIdx0 = 0;;loopIdx0++,                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true)) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10010;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    if (subgroupElect()) {
                        break;
                    }
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10015;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
                break;
            }
            case 4:
            {
                break;
            }
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001c;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        if (subgroupElect()) {
            if (inputA.a[3] == 3) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10020;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10023;
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

    for (int loopIdx0 = 0;;loopIdx0++,    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true)) {
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10001;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        break;
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10004;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        if (inputA.a[3] == 3) {
            if (gl_SubgroupInvocationID == loopIdx0) {
                for (int loopIdx1 = 0;
                         loopIdx1 < gl_SubgroupInvocationID + 1;
                         loopIdx1++) {
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000a;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                if (inputA.a[3] == 3) {
                } else {
                }
            } else {
                if (inputA.a[3] == 3) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10011;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10014;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            }
        }
        if (subgroupElect()) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10019;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            break;
        }
        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001e;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            {
                int loopIdx1 = 0;
                do {
                    loopIdx1++;
                    continue;
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10022;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    if (inputA.a[2] == 2) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10025;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    } else {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10028;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    }
                } while (loopIdx1 < inputA.a[3]);
            }
            if (subgroupElect()) {
                if (gl_SubgroupInvocationID == loopIdx0) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002e;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
                {
                    int loopIdx1 = 0;
                    do {
                        if (subgroupElect()) {
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10033;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                            break;
                        }
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10037;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        loopIdx1++;
                    } while (true);
                }
            }
        } else {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001e;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            {
                int loopIdx1 = 0;
                do {
                    loopIdx1++;
                    continue;
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10022;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    if (inputA.a[0] == 0) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10025;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    } else {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10028;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    }
                } while (loopIdx1 < inputA.a[3]);
            }
            if (subgroupElect()) {
                if (gl_SubgroupInvocationID == loopIdx0) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002e;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
                {
                    int loopIdx1 = 0;
                    do {
                        if (subgroupElect()) {
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10033;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                            break;
                        }
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10037;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        loopIdx1++;
                    } while (true);
                }
            }
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1005a;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        break;
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1005d;
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
layout(constant_id = 12) const uint cmpIndex2 = 0u;
layout(constant_id = 13) const uint cmpIndex3 = 0u;


void main()
[[subgroup_uniform_control_flow]]
{

    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10000;
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
            {
                int loopIdx0 = 0;
                do {
                    loopIdx0++;
                    continue;
                    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex2]) {
                    } else {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10008;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    }
                } while (loopIdx0 < inputA.a[1]);
            }
            for (int loopIdx0 = 0;;loopIdx0++,            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true)) {
                {
                    int loopIdx1 = 0;
                    do {
                        loopIdx1++;
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000e;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    } while (loopIdx1 < inputA.a[4]);
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10011;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                return;
                if (subgroupElect()) {
                    break;
                }
                if (gl_SubgroupInvocationID == loopIdx0) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10018;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                } else {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001b;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
                if (inputA.a[1] == 1) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001f;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
            }
        }
        if (testBit(uvec4(0x1963f897, 0x8b4219b3, 0x92c36785, 0xf2d7d33), gl_SubgroupInvocationID)) {
            if (testBit(uvec4(0xf769d02, 0x9d77bef, 0xe2a0008a, 0x6bd6bd3a), gl_SubgroupInvocationID)) {
                if (gl_LocalInvocationIndex >= inputA.a[cmpIndex3]) {
                }
                if (inputA.a[2] == 2) {
                }
            }
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


void main()
[[subgroup_uniform_control_flow]]
{

    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10000;
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
        if (testBit(uvec4(0x2451177d, 0xdcb3c008, 0xe709f5d7, 0xaa106ff5), gl_SubgroupInvocationID)) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10004;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10007;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                if (subgroupElect()) {
                }
            }
            switch (inputA.a[3]) {
                case 4:
                {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000e;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    break;
                }
                case 3:
                {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10012;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    break;
                }
                case 5:
                {
                    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex2]) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10017;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    }
                    break;
                }
            }
        } else {
            switch (gl_SubgroupInvocationID & 3) {
                case 0:
                case 1:
                {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001f;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    break;
                }
                case 2:
                case 3:
                {
                    switch (inputA.a[2]) {
                        case 3:
                        {
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10025;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                            break;
                        }
                        case 2:
                        {
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10029;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                            break;
                        }
                        case 4:
                        {
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002d;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                            break;
                        }
                    }
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10031;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    break;
                }
            }
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex3]) {
                if (inputA.a[2] == 2) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10037;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                } else {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10037;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
                if (gl_LocalInvocationIndex >= inputA.a[cmpIndex4]) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1003e;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                } else {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10041;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
            } else {
                if (gl_LocalInvocationIndex >= inputA.a[cmpIndex5]) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10046;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
                for (int loopIdx0 = 0;
                         loopIdx0 < gl_SubgroupInvocationID + 1;
                         loopIdx0++) {
                }
            }
        }
        for (int loopIdx0 = 0;
                 loopIdx0 < gl_SubgroupInvocationID + 1;
                 loopIdx0++) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1004e;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            if (gl_SubgroupInvocationID == loopIdx0) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10051;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                if (subgroupElect()) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10054;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
                if (gl_SubgroupInvocationID == loopIdx0) {
                } else {
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1005a;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            } else {
                if (subgroupElect()) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1005e;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
                if (gl_SubgroupInvocationID == loopIdx0) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10062;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
            }
        }
    } else {
        if (testBit(uvec4(0x2451177d, 0xdcb3c008, 0xe709f5d7, 0xaa106ff5), gl_SubgroupInvocationID)) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10004;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex6]) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10007;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                if (subgroupElect()) {
                }
            }
            switch (inputA.a[3]) {
                case 4:
                {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000e;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    break;
                }
                case 3:
                {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10012;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    break;
                }
                case 5:
                {
                    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex7]) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10017;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    }
                    break;
                }
            }
        } else {
            switch (gl_SubgroupInvocationID & 3) {
                case 0:
                case 1:
                {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001f;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    break;
                }
                case 2:
                case 3:
                {
                    switch (inputA.a[2]) {
                        case 3:
                        {
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10025;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                            break;
                        }
                        case 2:
                        {
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10029;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                            break;
                        }
                        case 4:
                        {
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002d;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                            break;
                        }
                    }
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10031;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    break;
                }
            }
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex8]) {
                if (inputA.a[1] == 1) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10037;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                } else {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10037;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
                if (gl_LocalInvocationIndex >= inputA.a[cmpIndex9]) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1003e;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                } else {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10041;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
            } else {
                if (gl_LocalInvocationIndex >= inputA.a[cmpIndex10]) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10046;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
                for (int loopIdx0 = 0;
                         loopIdx0 < gl_SubgroupInvocationID + 1;
                         loopIdx0++) {
                }
            }
        }
        for (int loopIdx0 = 0;
                 loopIdx0 < gl_SubgroupInvocationID + 1;
                 loopIdx0++) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1004e;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            if (gl_SubgroupInvocationID == loopIdx0) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10051;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                if (subgroupElect()) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10054;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
                if (gl_SubgroupInvocationID == loopIdx0) {
                } else {
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1005a;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            } else {
                if (subgroupElect()) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1005e;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
                if (gl_SubgroupInvocationID == loopIdx0) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10062;
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


void main()
[[subgroup_uniform_control_flow]]
{

    {
        int loopIdx0 = 0;
        do {
            loopIdx0++;
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10002;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                if (testBit(uvec4(0x64d5c99f, 0x1808a9af, 0xb00e2b66, 0xd0c9bc22), gl_SubgroupInvocationID)) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10005;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    if (gl_SubgroupInvocationID == loopIdx0) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10008;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    } else {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000b;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    }
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000e;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    {
                        int loopIdx1 = 0;
                        do {
                            if (subgroupElect()) {
                                break;
                            }
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10014;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                            loopIdx1++;
                        } while (true);
                    }
                }
                {
                    int loopIdx1 = 0;
                    do {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10019;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        {
                            int loopIdx2 = 0;
                            do {
                                if (subgroupElect()) {
                                    break;
                                }
                                outputC.loc[gl_LocalInvocationIndex]++;
                                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001f;
                                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                                loopIdx2++;
                            } while (true);
                        }
                        if (subgroupElect()) {
                            break;
                        }
                        for (int loopIdx2 = 0;
                                 loopIdx2 < gl_SubgroupInvocationID + 1;
                                 loopIdx2++) {
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10026;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        }
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10029;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        loopIdx1++;
                    } while (true);
                }
            } else {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002d;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                break;
            }
            switch (inputA.a[2]) {
                case 3:
                {
                    switch (gl_SubgroupInvocationID & 3) {
                        case 0:
                        {
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10035;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                            if (inputA.a[1] == 1) {
                                outputC.loc[gl_LocalInvocationIndex]++;
                                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10038;
                                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                            } else {
                            }
                            break;
                        }
                        case 1:
                        {
                            if (gl_SubgroupInvocationID == loopIdx0) {
                                outputC.loc[gl_LocalInvocationIndex]++;
                                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1003f;
                                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                            }
                            break;
                        }
                        case 2:
                        {
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10044;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                            if (subgroupElect()) {
                            }
                            break;
                        }
                        case 3:
                        {
                            for (int loopIdx1 = 0;
                                     loopIdx1 < inputA.a[1];
                                     loopIdx1++) {
                                outputC.loc[gl_LocalInvocationIndex]++;
                                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1004b;
                                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                            }
                            break;
                        }
                    }
                    break;
                }
                case 2:
                {
                    if (gl_SubgroupInvocationID == loopIdx0) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10053;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        if (gl_SubgroupInvocationID == loopIdx0) {
                        } else {
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10057;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        }
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1005a;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    }
                    if (subgroupElect()) {
                        if (testBit(uvec4(0x7a40b0b4, 0xdcbb1113, 0xb95e8c54, 0xf401d3ec), gl_SubgroupInvocationID)) {
                            break;
                        } else {
                            break;
                        }
                        if (inputA.a[1] == 1) {
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10064;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        } else {
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10064;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        }
                    }
                    break;
                }
                case 4:
                {
                    break;
                }
            }
        } while (loopIdx0 < inputA.a[1]);
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

    if (subgroupElect()) {
        if (testBit(uvec4(0x69b22f4b, 0xde19e3d2, 0x570385ca, 0xcb85febe), gl_SubgroupInvocationID)) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10002;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            {
                int loopIdx0 = 0;
                do {
                    loopIdx0++;
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10005;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
                    } else {
                    }
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000a;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    for (int loopIdx1 = 0;
                             loopIdx1 < gl_SubgroupInvocationID + 1;
                             loopIdx1++) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000d;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    }
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10010;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                } while (loopIdx0 < inputA.a[4]);
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10013;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        } else {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10002;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            {
                int loopIdx0 = 0;
                do {
                    loopIdx0++;
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10005;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
                    } else {
                    }
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000a;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    for (int loopIdx1 = 0;
                             loopIdx1 < gl_SubgroupInvocationID + 1;
                             loopIdx1++) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000d;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    }
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10010;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                } while (loopIdx0 < inputA.a[4]);
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10013;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        }
        for (int loopIdx0 = 0;
                 loopIdx0 < inputA.a[5];
                 loopIdx0++) {
            if (subgroupElect()) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002c;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                if (inputA.a[1] == 1) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002f;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10033;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            {
                int loopIdx1 = 0;
                do {
                    {
                        int loopIdx2 = 0;
                        do {
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10037;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                            if (subgroupElect()) {
                                break;
                            }
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1003c;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                            loopIdx2++;
                        } while (true);
                    }
                    {
                        int loopIdx2 = 0;
                        do {
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10040;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                            if (subgroupElect()) {
                                outputC.loc[gl_LocalInvocationIndex]++;
                                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10043;
                                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                                break;
                            }
                            loopIdx2++;
                        } while (true);
                    }
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10048;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    if (subgroupElect()) {
                        break;
                    }
                    for (int loopIdx2 = 0;
                             loopIdx2 < inputA.a[4];
                             loopIdx2++) {
                    }
                    loopIdx1++;
                } while (true);
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
        if (inputA.a[3] == 3) {
            {
                int loopIdx1 = 0;
                do {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10003;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    switch (inputA.a[1]) {
                        case 2:
                        {
                            break;
                        }
                        case 1:
                        {
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10009;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                            break;
                        }
                        case 3:
                        {
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000d;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                            break;
                        }
                    }
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10011;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    {
                        int loopIdx2 = 0;
                        do {
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10014;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                            if (subgroupElect()) {
                                break;
                            }
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10019;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                            loopIdx2++;
                        } while (true);
                    }
                    if (subgroupElect()) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001d;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        break;
                    }
                    switch (loopIdx1) {
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
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10029;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
                    } else {
                    }
                    loopIdx1++;
                } while (true);
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002f;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            break;
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10033;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        if (subgroupElect()) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10036;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            break;
        }
        if (inputA.a[3] == 3) {
            switch (gl_SubgroupInvocationID & 3) {
                case 0:
                {
                    break;
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1003e;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    break;
                }
                case 1:
                {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10042;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
                    }
                    break;
                }
                case 2:
                {
                    break;
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
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1004f;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                            break;
                        }
                        case 5:
                        {
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10053;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                            break;
                        }
                    }
                    break;
                }
            }
            break;
        }
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
layout(constant_id = 15) const uint cmpIndex5 = 0u;
layout(constant_id = 16) const uint cmpIndex6 = 0u;
layout(constant_id = 17) const uint cmpIndex7 = 0u;
layout(constant_id = 18) const uint cmpIndex8 = 0u;
layout(constant_id = 19) const uint cmpIndex9 = 0u;
layout(constant_id = 20) const uint cmpIndex10 = 0u;
layout(constant_id = 21) const uint cmpIndex11 = 0u;
layout(constant_id = 22) const uint cmpIndex12 = 0u;
layout(constant_id = 23) const uint cmpIndex13 = 0u;


void main()
[[subgroup_uniform_control_flow]]
{

    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
        if (testBit(uvec4(0xba9b2883, 0x627a9aea, 0xe415efee, 0xc7b618da), gl_SubgroupInvocationID)) {
            if (inputA.a[0] == 0) {
                for (int loopIdx0 = 0;
                         loopIdx0 < inputA.a[1];
                         loopIdx0++) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10004;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
                if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
                }
            } else {
                if (gl_LocalInvocationIndex >= inputA.a[cmpIndex2]) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000b;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
                if (gl_LocalInvocationIndex >= inputA.a[cmpIndex3]) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000f;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                } else {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10012;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
            }
            if (inputA.a[0] == 0) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10017;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            }
        } else {
            if (inputA.a[1] == 1) {
                for (int loopIdx0 = 0;
                         loopIdx0 < inputA.a[1];
                         loopIdx0++) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10004;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
                if (gl_LocalInvocationIndex >= inputA.a[cmpIndex4]) {
                }
            } else {
                if (gl_LocalInvocationIndex >= inputA.a[cmpIndex5]) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000b;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
                if (gl_LocalInvocationIndex >= inputA.a[cmpIndex6]) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000f;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                } else {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10012;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
            }
            if (inputA.a[2] == 2) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10017;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            }
        }
        if (inputA.a[2] == 2) {
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex7]) {
                if (gl_LocalInvocationIndex >= inputA.a[cmpIndex8]) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10037;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                } else {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10037;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
                if (subgroupElect()) {
                }
            }
            if (inputA.a[0] == 0) {
                if (gl_LocalInvocationIndex >= inputA.a[cmpIndex9]) {
                } else {
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10044;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                {
                    int loopIdx0 = 0;
                    do {
                        loopIdx0++;
                    } while (loopIdx0 < inputA.a[4]);
                }
            } else {
                if (inputA.a[1] == 1) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1004a;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
                if (gl_LocalInvocationIndex >= inputA.a[cmpIndex10]) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1004e;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10051;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            }
        }
    } else {
        if (inputA.a[0] == 0) {
            for (int loopIdx0 = 0;;loopIdx0++,            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true)) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10058;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                if (gl_LocalInvocationIndex >= inputA.a[cmpIndex11]) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1005b;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                } else {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1005e;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
                if (subgroupElect()) {
                    if (testBit(uvec4(0x823c9e27, 0xdc8c87e7, 0x409fc185, 0xc7d8a15), gl_SubgroupInvocationID)) {
                        break;
                    } else {
                        break;
                    }
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10068;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                if (inputA.a[3] == 3) {
                }
                if (gl_LocalInvocationIndex >= inputA.a[cmpIndex12]) {
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1006e;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            }
            for (int loopIdx0 = 0;;loopIdx0++,            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true)) {
                if (gl_SubgroupInvocationID == loopIdx0) {
                }
                if (testBit(uvec4(0xba9b2883, 0x627a9aea, 0xe415efee, 0xc7b618da), gl_SubgroupInvocationID)) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10075;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                } else {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10078;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
                if (subgroupElect()) {
                    break;
                }
                break;
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1007f;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            }
        } else {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10083;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            if (subgroupElect()) {
                for (int loopIdx0 = 0;
                         loopIdx0 < gl_SubgroupInvocationID + 1;
                         loopIdx0++) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10087;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1008b;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1008e;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        if (inputA.a[1] == 1) {
            if (subgroupElect()) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10092;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                if (inputA.a[3] == 3) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10095;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                } else {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10098;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
            }
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex13]) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1009d;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                {
                    int loopIdx0 = 0;
                    do {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x100a0;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        if (subgroupElect()) {
                            break;
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
layout(constant_id = 10) const uint cmpIndex0 = 0u;


void main()
[[subgroup_uniform_control_flow]]
{

    {
        int loopIdx0 = 0;
        do {
            if (testBit(uvec4(0x7add8c04, 0x3871181, 0x475415fe, 0x72a638d5), gl_SubgroupInvocationID)) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10002;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            }
            switch (loopIdx0) {
                case 1: {
                    for (int loopIdx1 = 0;
                             loopIdx1 < gl_SubgroupInvocationID + 1;
                             loopIdx1++) {
                        for (int loopIdx2 = 0;;loopIdx2++,                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true)) {
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10009;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                            if (subgroupElect()) {
                                outputC.loc[gl_LocalInvocationIndex]++;
                                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000c;
                                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                                break;
                            }
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10010;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        }
                    }
                    break;
                }
                case 2: {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10016;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    if (subgroupElect()) {
                        if (inputA.a[3] == 3) {
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001a;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        }
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001d;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        {
                            int loopIdx1 = 0;
                            do {
                                outputC.loc[gl_LocalInvocationIndex]++;
                                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10020;
                                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                                if (subgroupElect()) {
                                    if (testBit(uvec4(0xd42c613d, 0xdc94d4ee, 0x164d5461, 0x5a6d4ffb), gl_SubgroupInvocationID)) {
                                        break;
                                    } else {
                                        break;
                                    }
                                }
                                outputC.loc[gl_LocalInvocationIndex]++;
                                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10029;
                                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                                loopIdx1++;
                            } while (true);
                        }
                    }
                    break;
                }
                default: {
                    switch (gl_SubgroupInvocationID & 3) {
                        case 0:
                        case 1:
                        {
                            if (gl_SubgroupInvocationID == loopIdx0) {
                            }
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10033;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                            if (testBit(uvec4(0xdb9660d6, 0x6c04c1e2, 0x97265183, 0xebb4fec8), gl_SubgroupInvocationID)) {
                                outputC.loc[gl_LocalInvocationIndex]++;
                                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10036;
                                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                            }
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10039;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                            break;
                        }
                        case 2:
                        case 3:
                        {
                            if (inputA.a[0] == 0) {
                                outputC.loc[gl_LocalInvocationIndex]++;
                                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1003e;
                                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                            } else {
                                outputC.loc[gl_LocalInvocationIndex]++;
                                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1003e;
                                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                            }
                            break;
                        }
                    }
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10046;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    break;
                }
            }
            if (subgroupElect()) {
                break;
            }
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1004e;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                break;
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10051;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            }
            if (subgroupElect()) {
                {
                    int loopIdx1 = 0;
                    do {
                        loopIdx1++;
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
                                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1005a;
                                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                                break;
                            }
                        }
                        for (int loopIdx2 = 0;
                                 loopIdx2 < gl_SubgroupInvocationID + 1;
                                 loopIdx2++) {
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1005f;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        }
                    } while (loopIdx1 < inputA.a[2]);
                }
                switch (gl_SubgroupInvocationID & 3) {
                    case 0:
                    case 1:
                    {
                        if (subgroupElect()) {
                        }
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10067;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        if (testBit(uvec4(0xd42c613d, 0xdc94d4ee, 0x164d5461, 0x5a6d4ffb), gl_SubgroupInvocationID)) {
                        } else {
                        }
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1006c;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        break;
                    }
                    case 2:
                    case 3:
                    {
                        break;
                        if (gl_SubgroupInvocationID == loopIdx0) {
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10072;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        } else {
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10072;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        }
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10078;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        break;
                    }
                }
            }
            loopIdx0++;
        } while (true);
    }
    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1007e;
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


void main()
{

    for (int loopIdx0 = 0;;loopIdx0++,    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect()) {
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10001;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        break;
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10004;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        if (inputA.a[3] == 3) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10007;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        } else {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10007;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000d;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        if (subgroupElect()) {
            break;
        }
        for (int loopIdx1 = 0;;loopIdx1++,        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect()) {
            if (subgroupElect()) {
                break;
            }
        }
    }
    if (subgroupElect()) {
        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001a;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        } else {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001d;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        }
        if (subgroupElect()) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10021;
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

    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10000;
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
    if (inputA.a[3] == 3) {
        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10005;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        {
            int loopIdx0 = 0;
            do {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10008;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                if (subgroupElect()) {
                    break;
                }
                loopIdx0++;
            } while (true);
        }
    }
    {
        int loopIdx0 = 0;
        do {
            loopIdx0++;
            switch (loopIdx0) {
                case 1: {
                    break;
                }
                case 2: {
                    break;
                }
                default: {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10016;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    break;
                }
            }
            break;
        } while (loopIdx0 < inputA.a[3]);
    }
    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001c;
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

    switch (inputA.a[2]) {
        case 3:
        {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10002;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10005;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            } else {
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10009;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            break;
        }
        case 2:
        {
            if (subgroupElect()) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000e;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            }
            break;
        }
        case 4:
        {
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
            }
            break;
        }
    }
    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10017;
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
    for (int loopIdx0 = 0;;loopIdx0++,    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect()) {
        switch (inputA.a[4]) {
            case 5:
            {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001c;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                break;
            }
            case 4:
            {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10020;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                break;
            }
            case 6:
            {
                break;
            }
        }
        break;
        if (subgroupElect()) {
            break;
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002a;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        for (int loopIdx1 = 0;
                 loopIdx1 < inputA.a[3];
                 loopIdx1++) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002d;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10030;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        if (testBit(uvec4(0xd1e6eb46, 0xe442a0b6, 0xf986abd3, 0x7e35676e), gl_SubgroupInvocationID)) {
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10034;
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

    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10000;
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
    if (subgroupElect()) {
        if (inputA.a[2] == 2) {
        } else {
        }
    }
    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10007;
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
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
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000e;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                break;
            }
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10012;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
    }
    for (int loopIdx0 = 0;;loopIdx0++,    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect()) {
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10016;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
        } else {
        }
        if (testBit(uvec4(0xc2d3e3ec, 0xbd6921e5, 0x75c6c187, 0x38b7d6e9), gl_SubgroupInvocationID)) {
        } else {
        }
        if (subgroupElect()) {
            break;
        }
        switch (inputA.a[0]) {
            case 1:
            {
                break;
            }
            case 0:
            {
                break;
            }
            case 2:
            {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10027;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                break;
            }
        }
    }
    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002c;
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

    if (subgroupElect()) {
        if (testBit(uvec4(0x69b22f4b, 0xde19e3d2, 0x570385ca, 0xcb85febe), gl_SubgroupInvocationID)) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10002;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10005;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
    }
    for (int loopIdx0 = 0;
             loopIdx0 < inputA.a[4];
             loopIdx0++) {
        if (subgroupElect()) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000a;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000d;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        break;
    }
    {
        int loopIdx0 = 0;
        do {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10012;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            if (inputA.a[2] == 2) {
            }
            {
                int loopIdx1 = 0;
                do {
                    loopIdx1++;
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10017;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                } while (loopIdx1 < inputA.a[3]);
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001a;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            if (subgroupElect()) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001d;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                break;
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10021;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            {
                int loopIdx1 = 0;
                do {
                    if (subgroupElect()) {
                        break;
                    }
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10027;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    loopIdx1++;
                } while (true);
            }
            if (inputA.a[1] == 1) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002b;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            } else {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002e;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            }
            loopIdx0++;
        } while (true);
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

    for (int loopIdx0 = 0;;loopIdx0++,    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect()) {
        if (inputA.a[2] == 2) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10002;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        } else {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10005;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        }
        break;
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10009;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        if (subgroupElect()) {
            break;
        }
        break;
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000f;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        {
            int loopIdx1 = 0;
            do {
                loopIdx1++;
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10012;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            } while (loopIdx1 < inputA.a[5]);
        }
    }
    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10017;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        if (inputA.a[3] == 3) {
        } else {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001b;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001e;
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

    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
        if (testBit(uvec4(0xba9b2883, 0x627a9aea, 0xe415efee, 0xc7b618da), gl_SubgroupInvocationID)) {
        }
        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10004;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        } else {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10007;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000a;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
    }
    for (int loopIdx0 = 0;;loopIdx0++,    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect()) {
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000e;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        if (inputA.a[0] == 0) {
        }
        if (subgroupElect()) {
            break;
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10015;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        break;
        if (testBit(uvec4(0xfc448fa1, 0x68b83ada, 0xcbbd07ad, 0x21ab9f7d), gl_SubgroupInvocationID)) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10019;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        } else {
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001d;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
    }
    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10020;
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


void main()
{

    {
        int loopIdx0 = 0;
        do {
            if (testBit(uvec4(0x7add8c04, 0x3871181, 0x475415fe, 0x72a638d5), gl_SubgroupInvocationID)) {
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10003;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            if (subgroupElect()) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10006;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                break;
            }
            {
                int loopIdx1 = 0;
                do {
                    loopIdx1++;
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000b;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                } while (loopIdx1 < inputA.a[4]);
            }
            if (gl_SubgroupInvocationID == loopIdx0) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000f;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            }
            loopIdx0++;
        } while (true);
    }
    if (testBit(uvec4(0xd42c613d, 0xdc94d4ee, 0x164d5461, 0x5a6d4ffb), gl_SubgroupInvocationID)) {
    }
    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
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
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001a;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                break;
            }
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
                break;
            }
        }
    } else {
        switch (gl_SubgroupInvocationID & 3) {
            case 0:
            case 1:
            {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10027;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                break;
            }
            case 2:
            case 3:
            {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002b;
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


void main()
{

    for (int loopIdx0 = 0;;loopIdx0++,    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect()) {
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10001;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        break;
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10004;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        if (inputA.a[2] == 2) {
            if (gl_SubgroupInvocationID == loopIdx0) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10008;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            } else {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000b;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            }
        } else {
            if (gl_SubgroupInvocationID == loopIdx0) {
            } else {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10011;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            }
            if (subgroupElect()) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10015;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10018;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        }
        if (subgroupElect()) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001c;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            switch (inputA.a[2]) {
                case 3:
                {
                    break;
                }
                case 2:
                {
                    break;
                }
                case 4:
                {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10024;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    break;
                }
            }
            break;
        }
        for (int loopIdx1 = 0;
                 loopIdx1 < gl_SubgroupInvocationID + 1;
                 loopIdx1++) {
            if (testBit(uvec4(0x73a02751, 0xdca3a206, 0xb07b76af, 0xfde17503), gl_SubgroupInvocationID)) {
                break;
            } else {
                break;
            }
        }
        {
            int loopIdx1 = 0;
            do {
                if (subgroupElect()) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10033;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                }
                if (subgroupElect()) {
                    break;
                }
                if (gl_SubgroupInvocationID == loopIdx1) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1003a;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                } else {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1003d;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10040;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                return;
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10043;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                loopIdx1++;
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
layout(constant_id = 12) const uint cmpIndex2 = 0u;


void main()
{

    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10000;
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
            {
                int loopIdx0 = 0;
                do {
                    loopIdx0++;
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10005;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                } while (loopIdx0 < inputA.a[1]);
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10008;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            for (int loopIdx0 = 0;;loopIdx0++,            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect()) {
                if (subgroupElect()) {
                    break;
                }
            }
        } else {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10010;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            if (testBit(uvec4(0x1963f897, 0x8b4219b3, 0x92c36785, 0xf2d7d33), gl_SubgroupInvocationID)) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10013;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10016;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        }
        switch (gl_SubgroupInvocationID & 3) {
            case 0:
            case 1:
            {
                if (testBit(uvec4(0x1963f897, 0x8b4219b3, 0x92c36785, 0xf2d7d33), gl_SubgroupInvocationID)) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001c;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                } else {
                }
                break;
            }
            case 2:
            case 3:
            {
                if (testBit(uvec4(0x1963f897, 0x8b4219b3, 0x92c36785, 0xf2d7d33), gl_SubgroupInvocationID)) {
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10024;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                if (subgroupElect()) {
                }
                break;
            }
        }
    } else {
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002b;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        {
            int loopIdx0 = 0;
            do {
                if (inputA.a[2] == 2) {
                } else {
                }
                for (int loopIdx1 = 0;;loopIdx1++,                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect()) {
                    if (subgroupElect()) {
                        break;
                    }
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10035;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10038;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                if (subgroupElect()) {
                    break;
                }
                break;
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1003e;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                if (gl_LocalInvocationIndex >= inputA.a[cmpIndex2]) {
                } else {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10042;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
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
layout(constant_id = 12) const uint cmpIndex2 = 0u;
layout(constant_id = 13) const uint cmpIndex3 = 0u;


void main()
{

    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10000;
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
        if (testBit(uvec4(0x2451177d, 0xdcb3c008, 0xe709f5d7, 0xaa106ff5), gl_SubgroupInvocationID)) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10004;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10007;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            }
            if (subgroupElect()) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000b;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            }
        } else {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000f;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        }
        if (testBit(uvec4(0xee6a85de, 0x830e345, 0xf7a56dfc, 0x3bb1816a), gl_SubgroupInvocationID)) {
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex2]) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10014;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            }
            {
                int loopIdx0 = 0;
                do {
                    if (subgroupElect()) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10019;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                        break;
                    }
                    loopIdx0++;
                } while (true);
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001e;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        } else {
            if (subgroupElect()) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10022;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10025;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            {
                int loopIdx0 = 0;
                do {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10028;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    if (subgroupElect()) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002b;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                        break;
                    }
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002f;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    loopIdx0++;
                } while (true);
            }
        }
    } else {
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10034;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        if (inputA.a[3] == 3) {
            {
                int loopIdx0 = 0;
                do {
                    if (subgroupElect()) {
                        if (testBit(uvec4(0x2451177d, 0xdcb3c008, 0xe709f5d7, 0xaa106ff5), gl_SubgroupInvocationID)) {
                            break;
                        } else {
                            break;
                        }
                    }
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1003f;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    loopIdx0++;
                } while (true);
            }
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex3]) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10043;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            }
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10047;
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


void main()
{

    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10000;
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10003;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        if (subgroupElect()) {
            switch (gl_SubgroupInvocationID & 3) {
                case 0:
                {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10008;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    break;
                }
                case 1:
                {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000c;
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
    }
    {
        int loopIdx0 = 0;
        do {
            loopIdx0++;
            break;
            if (gl_SubgroupInvocationID == loopIdx0) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001f;
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
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10027;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                        break;
                    }
                }
            } else {
                if (gl_SubgroupInvocationID == loopIdx0) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002d;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                } else {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10030;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10033;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                if (gl_SubgroupInvocationID == loopIdx0) {
                }
            }
        } while (loopIdx0 < inputA.a[5]);
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

    {
        int loopIdx0 = 0;
        do {
            loopIdx0++;
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10002;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                if (testBit(uvec4(0x64d5c99f, 0x1808a9af, 0xb00e2b66, 0xd0c9bc22), gl_SubgroupInvocationID)) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10005;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                } else {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10008;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                }
                for (int loopIdx1 = 0;
                         loopIdx1 < gl_SubgroupInvocationID + 1;
                         loopIdx1++) {
                }
            } else {
                for (int loopIdx1 = 0;
                         loopIdx1 < gl_SubgroupInvocationID + 1;
                         loopIdx1++) {
                }
                if (testBit(uvec4(0x7a40b0b4, 0xdcbb1113, 0xb95e8c54, 0xf401d3ec), gl_SubgroupInvocationID)) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10011;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                }
            }
            continue;
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10016;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        } while (loopIdx0 < inputA.a[1]);
    }
    if (subgroupElect()) {
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001a;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
    }
    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex2]) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001f;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            for (int loopIdx0 = 0;
                     loopIdx0 < gl_SubgroupInvocationID + 1;
                     loopIdx0++) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10022;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            }
        }
        if (inputA.a[3] == 3) {
            if (testBit(uvec4(0xdcc5ff96, 0x8154a0d3, 0x19ca424f, 0x5a437a79), gl_SubgroupInvocationID)) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10028;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            } else {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10028;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            }
        }
    } else {
        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex3]) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10031;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            if (inputA.a[0] == 0) {
            } else {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10035;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            }
            for (int loopIdx0 = 0;
                     loopIdx0 < gl_SubgroupInvocationID + 1;
                     loopIdx0++) {
            }
        }
        if (inputA.a[3] == 3) {
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex4]) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1003d;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            }
            if (subgroupElect()) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10041;
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


void main()
{

    if (subgroupElect()) {
        if (testBit(uvec4(0x69b22f4b, 0xde19e3d2, 0x570385ca, 0xcb85febe), gl_SubgroupInvocationID)) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10002;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            {
                int loopIdx0 = 0;
                do {
                    loopIdx0++;
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10005;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                } while (loopIdx0 < inputA.a[4]);
            }
        } else {
            switch (gl_SubgroupInvocationID & 3) {
                case 0:
                case 1:
                {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000b;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    break;
                }
                case 2:
                case 3:
                {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000f;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    break;
                }
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10013;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10016;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        for (int loopIdx0 = 0;
                 loopIdx0 < gl_SubgroupInvocationID + 1;
                 loopIdx0++) {
            if (inputA.a[2] == 2) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001a;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            } else {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001d;
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


void main()
{

    for (int loopIdx0 = 0;;loopIdx0++,    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect()) {
        if (inputA.a[0] == 0) {
            {
                int loopIdx1 = 0;
                do {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10003;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    if (subgroupElect()) {
                        break;
                    }
                    loopIdx1++;
                } while (true);
            }
        } else {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000a;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            if (inputA.a[1] == 1) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000d;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            } else {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10010;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10013;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        }
        if (subgroupElect()) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10017;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            {
                int loopIdx1 = 0;
                do {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001a;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    if (subgroupElect()) {
                        break;
                    }
                    loopIdx1++;
                } while (true);
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10020;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10023;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        if (subgroupElect()) {
            break;
        }
        if (gl_SubgroupInvocationID == loopIdx0) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10029;
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
                    break;
                }
            }
            break;
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10036;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
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
layout(constant_id = 10) const uint cmpIndex0 = 0u;
layout(constant_id = 11) const uint cmpIndex1 = 0u;


void main()
{

    {
        int loopIdx0 = 0;
        do {
            loopIdx0++;
            continue;
            if (gl_SubgroupInvocationID == loopIdx0) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10003;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                continue;
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10006;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                for (int loopIdx1 = 0;
                         loopIdx1 < inputA.a[2];
                         loopIdx1++) {
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000a;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            } else {
                {
                    int loopIdx1 = 0;
                    do {
                        loopIdx1++;
                    } while (loopIdx1 < inputA.a[1]);
                }
                {
                    int loopIdx1 = 0;
                    do {
                        loopIdx1++;
                    } while (loopIdx1 < inputA.a[1]);
                }
            }
        } while (loopIdx0 < inputA.a[5]);
    }
    if (inputA.a[0] == 0) {
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10014;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        if (testBit(uvec4(0xfded30bc, 0x9e3bcf7f, 0x28b84885, 0x16997569), gl_SubgroupInvocationID)) {
            if (inputA.a[1] == 1) {
            }
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
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001f;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        if (testBit(uvec4(0x9e3fb15d, 0xf894c5ce, 0xc0dfd81f, 0x7ef2adad), gl_SubgroupInvocationID)) {
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
            }
            if (subgroupElect()) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10025;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            }
        } else {
            for (int loopIdx0 = 0;
                     loopIdx0 < inputA.a[2];
                     loopIdx0++) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002a;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            }
            for (int loopIdx0 = 0;
                     loopIdx0 < gl_SubgroupInvocationID + 1;
                     loopIdx0++) {
            }
        }
    } else {
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10031;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        if (inputA.a[0] == 0) {
            if (inputA.a[3] == 3) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10035;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            } else {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10038;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            }
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1003c;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            } else {
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10040;
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
{

    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
        if (testBit(uvec4(0xba9b2883, 0x627a9aea, 0xe415efee, 0xc7b618da), gl_SubgroupInvocationID)) {
            if (inputA.a[2] == 2) {
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10004;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10007;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        return;
    } else {
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000b;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        if (testBit(uvec4(0x9e3fb15d, 0xf894c5ce, 0xc0dfd81f, 0x7ef2adad), gl_SubgroupInvocationID)) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000e;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            if (inputA.a[0] == 0) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10011;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            }
            if (subgroupElect()) {
            }
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10017;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
    }
    for (int loopIdx0 = 0;
             loopIdx0 < inputA.a[4];
             loopIdx0++) {
        switch (gl_SubgroupInvocationID & 3) {
            case 0:
            {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001d;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                break;
            }
            case 1:
            {
                {
                    int loopIdx1 = 0;
                    do {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10022;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                        if (subgroupElect()) {
                            break;
                        }
                        loopIdx1++;
                    } while (true);
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10028;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                break;
            }
            case 2:
            {
                if (gl_SubgroupInvocationID == loopIdx0) {
                }
                break;
            }
            case 3:
            {
                for (int loopIdx1 = 0;
                         loopIdx1 < inputA.a[5];
                         loopIdx1++) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10031;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                }
                break;
            }
        }
        if (gl_SubgroupInvocationID == loopIdx0) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10037;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            if (subgroupElect()) {
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1003b;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1003e;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10041;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        } else {
            if (inputA.a[1] == 1) {
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10046;
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
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1004e;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
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


void main()
{

    {
        int loopIdx0 = 0;
        do {
            if (testBit(uvec4(0x7add8c04, 0x3871181, 0x475415fe, 0x72a638d5), gl_SubgroupInvocationID)) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10002;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            }
            switch (loopIdx0) {
                case 1: {
                    for (int loopIdx1 = 0;
                             loopIdx1 < gl_SubgroupInvocationID + 1;
                             loopIdx1++) {
                    }
                    break;
                }
                case 2: {
                    for (int loopIdx1 = 0;
                             loopIdx1 < inputA.a[3];
                             loopIdx1++) {
                    }
                    break;
                }
                default: {
                    if (inputA.a[1] == 1) {
                    }
                    break;
                }
            }
            if (subgroupElect()) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10014;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                break;
            }
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
                if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001a;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                } else {
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001e;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                switch (gl_SubgroupInvocationID & 3) {
                    case 0:
                    case 1:
                    {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10022;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                        break;
                    }
                    case 2:
                    case 3:
                    {
                        break;
                    }
                }
            } else {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10029;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                if (gl_LocalInvocationIndex >= inputA.a[cmpIndex2]) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002c;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                }
                break;
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10031;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            switch (gl_SubgroupInvocationID & 3) {
                case 0:
                {
                    break;
                }
                case 1:
                {
                    if (subgroupElect()) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10038;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    }
                    break;
                }
                case 2:
                {
                    for (int loopIdx1 = 0;
                             loopIdx1 < gl_SubgroupInvocationID + 1;
                             loopIdx1++) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1003e;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    }
                    break;
                }
                case 3:
                {
                    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex3]) {
                    }
                    break;
                }
            }
            loopIdx0++;
        } while (true);
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

    if (subgroupElect()) {
        for (int loopIdx0 = 0;;loopIdx0++,        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect()) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10002;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            if (testBit(uvec4(0xd42c613d, 0xdc94d4ee, 0x164d5461, 0x5a6d4ffb), gl_SubgroupInvocationID)) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10005;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10008;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000b;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            }
            if (subgroupElect()) {
                break;
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10011;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10014;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            } else {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10014;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001a;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            if (gl_SubgroupInvocationID == loopIdx0) {
            }
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001f;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        if (subgroupElect()) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10022;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            switch (gl_SubgroupInvocationID & 3) {
                case 0:
                case 1:
                {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10026;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    break;
                }
                case 2:
                case 3:
                {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002a;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    break;
                }
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002e;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            if (testBit(uvec4(0xb59fc2fe, 0xdd679954, 0x5c9ed4c3, 0xf991283b), gl_SubgroupInvocationID)) {
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10032;
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

    for (int loopIdx0 = 0;;loopIdx0++,    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect()) {
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10001;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        break;
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10004;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        if (inputA.a[3] == 3) {
            if (gl_SubgroupInvocationID == loopIdx0) {
                for (int loopIdx1 = 0;
                         loopIdx1 < gl_SubgroupInvocationID + 1;
                         loopIdx1++) {
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000a;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                if (inputA.a[3] == 3) {
                } else {
                }
            } else {
                if (inputA.a[3] == 3) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10011;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10014;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            }
        }
        if (subgroupElect()) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10019;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            break;
        }
        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001e;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            {
                int loopIdx1 = 0;
                do {
                    loopIdx1++;
                    continue;
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10022;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    if (inputA.a[2] == 2) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10025;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    } else {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10028;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    }
                } while (loopIdx1 < inputA.a[3]);
            }
            if (subgroupElect()) {
                if (gl_SubgroupInvocationID == loopIdx0) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002e;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                }
                {
                    int loopIdx1 = 0;
                    do {
                        if (subgroupElect()) {
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10033;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                            break;
                        }
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10037;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                        loopIdx1++;
                    } while (true);
                }
            }
        } else {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001e;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            {
                int loopIdx1 = 0;
                do {
                    loopIdx1++;
                    continue;
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10022;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    if (inputA.a[0] == 0) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10025;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    } else {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10028;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    }
                } while (loopIdx1 < inputA.a[3]);
            }
            if (subgroupElect()) {
                if (gl_SubgroupInvocationID == loopIdx0) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002e;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                }
                {
                    int loopIdx1 = 0;
                    do {
                        if (subgroupElect()) {
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10033;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                            break;
                        }
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10037;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                        loopIdx1++;
                    } while (true);
                }
            }
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1005a;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        break;
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1005d;
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
layout(constant_id = 12) const uint cmpIndex2 = 0u;
layout(constant_id = 13) const uint cmpIndex3 = 0u;


void main()
{

    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10000;
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
            {
                int loopIdx0 = 0;
                do {
                    loopIdx0++;
                    continue;
                    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex2]) {
                    } else {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10008;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    }
                } while (loopIdx0 < inputA.a[1]);
            }
            for (int loopIdx0 = 0;;loopIdx0++,            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect()) {
                {
                    int loopIdx1 = 0;
                    do {
                        loopIdx1++;
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000e;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    } while (loopIdx1 < inputA.a[4]);
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10011;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                return;
                if (subgroupElect()) {
                    break;
                }
                if (gl_SubgroupInvocationID == loopIdx0) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10018;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                } else {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001b;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                }
                if (inputA.a[1] == 1) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001f;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                }
            }
        }
        if (testBit(uvec4(0x1963f897, 0x8b4219b3, 0x92c36785, 0xf2d7d33), gl_SubgroupInvocationID)) {
            if (testBit(uvec4(0xf769d02, 0x9d77bef, 0xe2a0008a, 0x6bd6bd3a), gl_SubgroupInvocationID)) {
                if (gl_LocalInvocationIndex >= inputA.a[cmpIndex3]) {
                }
                if (inputA.a[2] == 2) {
                }
            }
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


void main()
{

    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10000;
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
        if (testBit(uvec4(0x2451177d, 0xdcb3c008, 0xe709f5d7, 0xaa106ff5), gl_SubgroupInvocationID)) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10004;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10007;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                if (subgroupElect()) {
                }
            }
            switch (inputA.a[3]) {
                case 4:
                {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000e;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    break;
                }
                case 3:
                {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10012;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    break;
                }
                case 5:
                {
                    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex2]) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10017;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    }
                    break;
                }
            }
        } else {
            switch (gl_SubgroupInvocationID & 3) {
                case 0:
                case 1:
                {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001f;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    break;
                }
                case 2:
                case 3:
                {
                    switch (inputA.a[2]) {
                        case 3:
                        {
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10025;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                            break;
                        }
                        case 2:
                        {
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10029;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                            break;
                        }
                        case 4:
                        {
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002d;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                            break;
                        }
                    }
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10031;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    break;
                }
            }
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex3]) {
                if (inputA.a[2] == 2) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10037;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                } else {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10037;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                }
                if (gl_LocalInvocationIndex >= inputA.a[cmpIndex4]) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1003e;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                } else {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10041;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                }
            } else {
                if (gl_LocalInvocationIndex >= inputA.a[cmpIndex5]) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10046;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                }
                for (int loopIdx0 = 0;
                         loopIdx0 < gl_SubgroupInvocationID + 1;
                         loopIdx0++) {
                }
            }
        }
        for (int loopIdx0 = 0;
                 loopIdx0 < gl_SubgroupInvocationID + 1;
                 loopIdx0++) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1004e;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            if (gl_SubgroupInvocationID == loopIdx0) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10051;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                if (subgroupElect()) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10054;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                }
                if (gl_SubgroupInvocationID == loopIdx0) {
                } else {
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1005a;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            } else {
                if (subgroupElect()) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1005e;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                }
                if (gl_SubgroupInvocationID == loopIdx0) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10062;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                }
            }
        }
    } else {
        if (testBit(uvec4(0x2451177d, 0xdcb3c008, 0xe709f5d7, 0xaa106ff5), gl_SubgroupInvocationID)) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10004;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex6]) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10007;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                if (subgroupElect()) {
                }
            }
            switch (inputA.a[3]) {
                case 4:
                {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000e;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    break;
                }
                case 3:
                {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10012;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    break;
                }
                case 5:
                {
                    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex7]) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10017;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    }
                    break;
                }
            }
        } else {
            switch (gl_SubgroupInvocationID & 3) {
                case 0:
                case 1:
                {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001f;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    break;
                }
                case 2:
                case 3:
                {
                    switch (inputA.a[2]) {
                        case 3:
                        {
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10025;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                            break;
                        }
                        case 2:
                        {
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10029;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                            break;
                        }
                        case 4:
                        {
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002d;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                            break;
                        }
                    }
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10031;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    break;
                }
            }
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex8]) {
                if (inputA.a[1] == 1) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10037;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                } else {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10037;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                }
                if (gl_LocalInvocationIndex >= inputA.a[cmpIndex9]) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1003e;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                } else {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10041;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                }
            } else {
                if (gl_LocalInvocationIndex >= inputA.a[cmpIndex10]) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10046;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                }
                for (int loopIdx0 = 0;
                         loopIdx0 < gl_SubgroupInvocationID + 1;
                         loopIdx0++) {
                }
            }
        }
        for (int loopIdx0 = 0;
                 loopIdx0 < gl_SubgroupInvocationID + 1;
                 loopIdx0++) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1004e;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            if (gl_SubgroupInvocationID == loopIdx0) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10051;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                if (subgroupElect()) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10054;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                }
                if (gl_SubgroupInvocationID == loopIdx0) {
                } else {
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1005a;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            } else {
                if (subgroupElect()) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1005e;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                }
                if (gl_SubgroupInvocationID == loopIdx0) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10062;
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


void main()
{

    {
        int loopIdx0 = 0;
        do {
            loopIdx0++;
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10002;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                if (testBit(uvec4(0x64d5c99f, 0x1808a9af, 0xb00e2b66, 0xd0c9bc22), gl_SubgroupInvocationID)) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10005;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    if (gl_SubgroupInvocationID == loopIdx0) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10008;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    } else {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000b;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    }
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000e;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    {
                        int loopIdx1 = 0;
                        do {
                            if (subgroupElect()) {
                                break;
                            }
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10014;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                            loopIdx1++;
                        } while (true);
                    }
                }
                {
                    int loopIdx1 = 0;
                    do {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10019;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                        {
                            int loopIdx2 = 0;
                            do {
                                if (subgroupElect()) {
                                    break;
                                }
                                outputC.loc[gl_LocalInvocationIndex]++;
                                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001f;
                                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                                loopIdx2++;
                            } while (true);
                        }
                        if (subgroupElect()) {
                            break;
                        }
                        for (int loopIdx2 = 0;
                                 loopIdx2 < gl_SubgroupInvocationID + 1;
                                 loopIdx2++) {
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10026;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                        }
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10029;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                        loopIdx1++;
                    } while (true);
                }
            } else {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002d;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                break;
            }
            switch (inputA.a[2]) {
                case 3:
                {
                    switch (gl_SubgroupInvocationID & 3) {
                        case 0:
                        {
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10035;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                            if (inputA.a[1] == 1) {
                                outputC.loc[gl_LocalInvocationIndex]++;
                                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10038;
                                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                            } else {
                            }
                            break;
                        }
                        case 1:
                        {
                            if (gl_SubgroupInvocationID == loopIdx0) {
                                outputC.loc[gl_LocalInvocationIndex]++;
                                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1003f;
                                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                            }
                            break;
                        }
                        case 2:
                        {
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10044;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                            if (subgroupElect()) {
                            }
                            break;
                        }
                        case 3:
                        {
                            for (int loopIdx1 = 0;
                                     loopIdx1 < inputA.a[1];
                                     loopIdx1++) {
                                outputC.loc[gl_LocalInvocationIndex]++;
                                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1004b;
                                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                            }
                            break;
                        }
                    }
                    break;
                }
                case 2:
                {
                    if (gl_SubgroupInvocationID == loopIdx0) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10053;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                        if (gl_SubgroupInvocationID == loopIdx0) {
                        } else {
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10057;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                        }
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1005a;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    }
                    if (subgroupElect()) {
                        if (testBit(uvec4(0x7a40b0b4, 0xdcbb1113, 0xb95e8c54, 0xf401d3ec), gl_SubgroupInvocationID)) {
                            break;
                        } else {
                            break;
                        }
                        if (inputA.a[1] == 1) {
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10064;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                        } else {
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10064;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                        }
                    }
                    break;
                }
                case 4:
                {
                    break;
                }
            }
        } while (loopIdx0 < inputA.a[1]);
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

    if (subgroupElect()) {
        if (testBit(uvec4(0x69b22f4b, 0xde19e3d2, 0x570385ca, 0xcb85febe), gl_SubgroupInvocationID)) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10002;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            {
                int loopIdx0 = 0;
                do {
                    loopIdx0++;
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10005;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
                    } else {
                    }
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000a;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    for (int loopIdx1 = 0;
                             loopIdx1 < gl_SubgroupInvocationID + 1;
                             loopIdx1++) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000d;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    }
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10010;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                } while (loopIdx0 < inputA.a[4]);
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10013;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        } else {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10002;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            {
                int loopIdx0 = 0;
                do {
                    loopIdx0++;
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10005;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
                    } else {
                    }
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000a;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    for (int loopIdx1 = 0;
                             loopIdx1 < gl_SubgroupInvocationID + 1;
                             loopIdx1++) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000d;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    }
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10010;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                } while (loopIdx0 < inputA.a[4]);
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10013;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        }
        for (int loopIdx0 = 0;
                 loopIdx0 < inputA.a[5];
                 loopIdx0++) {
            if (subgroupElect()) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002c;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                if (inputA.a[1] == 1) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002f;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                }
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10033;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            {
                int loopIdx1 = 0;
                do {
                    {
                        int loopIdx2 = 0;
                        do {
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10037;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                            if (subgroupElect()) {
                                break;
                            }
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1003c;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                            loopIdx2++;
                        } while (true);
                    }
                    {
                        int loopIdx2 = 0;
                        do {
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10040;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                            if (subgroupElect()) {
                                outputC.loc[gl_LocalInvocationIndex]++;
                                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10043;
                                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                                break;
                            }
                            loopIdx2++;
                        } while (true);
                    }
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10048;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    if (subgroupElect()) {
                        break;
                    }
                    for (int loopIdx2 = 0;
                             loopIdx2 < inputA.a[4];
                             loopIdx2++) {
                    }
                    loopIdx1++;
                } while (true);
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
        if (inputA.a[3] == 3) {
            {
                int loopIdx1 = 0;
                do {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10003;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    switch (inputA.a[1]) {
                        case 2:
                        {
                            break;
                        }
                        case 1:
                        {
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10009;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                            break;
                        }
                        case 3:
                        {
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000d;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                            break;
                        }
                    }
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10011;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    {
                        int loopIdx2 = 0;
                        do {
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10014;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                            if (subgroupElect()) {
                                break;
                            }
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10019;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                            loopIdx2++;
                        } while (true);
                    }
                    if (subgroupElect()) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001d;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                        break;
                    }
                    switch (loopIdx1) {
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
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10029;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
                    } else {
                    }
                    loopIdx1++;
                } while (true);
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002f;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            break;
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10033;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        if (subgroupElect()) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10036;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            break;
        }
        if (inputA.a[3] == 3) {
            switch (gl_SubgroupInvocationID & 3) {
                case 0:
                {
                    break;
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1003e;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    break;
                }
                case 1:
                {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10042;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
                    }
                    break;
                }
                case 2:
                {
                    break;
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
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1004f;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                            break;
                        }
                        case 5:
                        {
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10053;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                            break;
                        }
                    }
                    break;
                }
            }
            break;
        }
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
layout(constant_id = 15) const uint cmpIndex5 = 0u;
layout(constant_id = 16) const uint cmpIndex6 = 0u;
layout(constant_id = 17) const uint cmpIndex7 = 0u;
layout(constant_id = 18) const uint cmpIndex8 = 0u;
layout(constant_id = 19) const uint cmpIndex9 = 0u;
layout(constant_id = 20) const uint cmpIndex10 = 0u;
layout(constant_id = 21) const uint cmpIndex11 = 0u;
layout(constant_id = 22) const uint cmpIndex12 = 0u;
layout(constant_id = 23) const uint cmpIndex13 = 0u;


void main()
{

    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
        if (testBit(uvec4(0xba9b2883, 0x627a9aea, 0xe415efee, 0xc7b618da), gl_SubgroupInvocationID)) {
            if (inputA.a[0] == 0) {
                for (int loopIdx0 = 0;
                         loopIdx0 < inputA.a[1];
                         loopIdx0++) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10004;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                }
                if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
                }
            } else {
                if (gl_LocalInvocationIndex >= inputA.a[cmpIndex2]) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000b;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                }
                if (gl_LocalInvocationIndex >= inputA.a[cmpIndex3]) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000f;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                } else {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10012;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                }
            }
            if (inputA.a[0] == 0) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10017;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            }
        } else {
            if (inputA.a[1] == 1) {
                for (int loopIdx0 = 0;
                         loopIdx0 < inputA.a[1];
                         loopIdx0++) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10004;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                }
                if (gl_LocalInvocationIndex >= inputA.a[cmpIndex4]) {
                }
            } else {
                if (gl_LocalInvocationIndex >= inputA.a[cmpIndex5]) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000b;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                }
                if (gl_LocalInvocationIndex >= inputA.a[cmpIndex6]) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000f;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                } else {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10012;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                }
            }
            if (inputA.a[2] == 2) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10017;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            }
        }
        if (inputA.a[2] == 2) {
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex7]) {
                if (gl_LocalInvocationIndex >= inputA.a[cmpIndex8]) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10037;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                } else {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10037;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                }
                if (subgroupElect()) {
                }
            }
            if (inputA.a[0] == 0) {
                if (gl_LocalInvocationIndex >= inputA.a[cmpIndex9]) {
                } else {
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10044;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                {
                    int loopIdx0 = 0;
                    do {
                        loopIdx0++;
                    } while (loopIdx0 < inputA.a[4]);
                }
            } else {
                if (inputA.a[1] == 1) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1004a;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                }
                if (gl_LocalInvocationIndex >= inputA.a[cmpIndex10]) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1004e;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10051;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            }
        }
    } else {
        if (inputA.a[0] == 0) {
            for (int loopIdx0 = 0;;loopIdx0++,            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect()) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10058;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                if (gl_LocalInvocationIndex >= inputA.a[cmpIndex11]) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1005b;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                } else {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1005e;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                }
                if (subgroupElect()) {
                    if (testBit(uvec4(0x823c9e27, 0xdc8c87e7, 0x409fc185, 0xc7d8a15), gl_SubgroupInvocationID)) {
                        break;
                    } else {
                        break;
                    }
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10068;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                if (inputA.a[3] == 3) {
                }
                if (gl_LocalInvocationIndex >= inputA.a[cmpIndex12]) {
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1006e;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            }
            for (int loopIdx0 = 0;;loopIdx0++,            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect()) {
                if (gl_SubgroupInvocationID == loopIdx0) {
                }
                if (testBit(uvec4(0xba9b2883, 0x627a9aea, 0xe415efee, 0xc7b618da), gl_SubgroupInvocationID)) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10075;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                } else {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10078;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                }
                if (subgroupElect()) {
                    break;
                }
                break;
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1007f;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            }
        } else {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10083;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            if (subgroupElect()) {
                for (int loopIdx0 = 0;
                         loopIdx0 < gl_SubgroupInvocationID + 1;
                         loopIdx0++) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10087;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                }
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1008b;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1008e;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        if (inputA.a[1] == 1) {
            if (subgroupElect()) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10092;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                if (inputA.a[3] == 3) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10095;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                } else {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10098;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                }
            }
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex13]) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1009d;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                {
                    int loopIdx0 = 0;
                    do {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x100a0;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                        if (subgroupElect()) {
                            break;
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
layout(constant_id = 10) const uint cmpIndex0 = 0u;


void main()
{

    {
        int loopIdx0 = 0;
        do {
            if (testBit(uvec4(0x7add8c04, 0x3871181, 0x475415fe, 0x72a638d5), gl_SubgroupInvocationID)) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10002;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            }
            switch (loopIdx0) {
                case 1: {
                    for (int loopIdx1 = 0;
                             loopIdx1 < gl_SubgroupInvocationID + 1;
                             loopIdx1++) {
                        for (int loopIdx2 = 0;;loopIdx2++,                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect()) {
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10009;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                            if (subgroupElect()) {
                                outputC.loc[gl_LocalInvocationIndex]++;
                                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000c;
                                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                                break;
                            }
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10010;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                        }
                    }
                    break;
                }
                case 2: {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10016;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    if (subgroupElect()) {
                        if (inputA.a[3] == 3) {
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001a;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                        }
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001d;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                        {
                            int loopIdx1 = 0;
                            do {
                                outputC.loc[gl_LocalInvocationIndex]++;
                                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10020;
                                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                                if (subgroupElect()) {
                                    if (testBit(uvec4(0xd42c613d, 0xdc94d4ee, 0x164d5461, 0x5a6d4ffb), gl_SubgroupInvocationID)) {
                                        break;
                                    } else {
                                        break;
                                    }
                                }
                                outputC.loc[gl_LocalInvocationIndex]++;
                                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10029;
                                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                                loopIdx1++;
                            } while (true);
                        }
                    }
                    break;
                }
                default: {
                    switch (gl_SubgroupInvocationID & 3) {
                        case 0:
                        case 1:
                        {
                            if (gl_SubgroupInvocationID == loopIdx0) {
                            }
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10033;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                            if (testBit(uvec4(0xdb9660d6, 0x6c04c1e2, 0x97265183, 0xebb4fec8), gl_SubgroupInvocationID)) {
                                outputC.loc[gl_LocalInvocationIndex]++;
                                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10036;
                                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                            }
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10039;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                            break;
                        }
                        case 2:
                        case 3:
                        {
                            if (inputA.a[0] == 0) {
                                outputC.loc[gl_LocalInvocationIndex]++;
                                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1003e;
                                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                            } else {
                                outputC.loc[gl_LocalInvocationIndex]++;
                                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1003e;
                                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                            }
                            break;
                        }
                    }
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10046;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    break;
                }
            }
            if (subgroupElect()) {
                break;
            }
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1004e;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                break;
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10051;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            }
            if (subgroupElect()) {
                {
                    int loopIdx1 = 0;
                    do {
                        loopIdx1++;
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
                                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1005a;
                                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                                break;
                            }
                        }
                        for (int loopIdx2 = 0;
                                 loopIdx2 < gl_SubgroupInvocationID + 1;
                                 loopIdx2++) {
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1005f;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                        }
                    } while (loopIdx1 < inputA.a[2]);
                }
                switch (gl_SubgroupInvocationID & 3) {
                    case 0:
                    case 1:
                    {
                        if (subgroupElect()) {
                        }
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10067;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                        if (testBit(uvec4(0xd42c613d, 0xdc94d4ee, 0x164d5461, 0x5a6d4ffb), gl_SubgroupInvocationID)) {
                        } else {
                        }
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1006c;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                        break;
                    }
                    case 2:
                    case 3:
                    {
                        break;
                        if (gl_SubgroupInvocationID == loopIdx0) {
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10072;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                        } else {
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10072;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                        }
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10078;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                        break;
                    }
                }
            }
            loopIdx0++;
        } while (true);
    }
    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1007e;
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


void main()
{

    for (int loopIdx0 = 0;;loopIdx0++,    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true)) {
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10001;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        break;
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10004;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        if (inputA.a[3] == 3) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10007;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        } else {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10007;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000d;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        if (subgroupElect()) {
            break;
        }
        for (int loopIdx1 = 0;;loopIdx1++,        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true)) {
            if (subgroupElect()) {
                break;
            }
        }
    }
    if (subgroupElect()) {
        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001a;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        } else {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001d;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        }
        if (subgroupElect()) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10021;
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

    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10000;
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
    if (inputA.a[3] == 3) {
        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10005;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        {
            int loopIdx0 = 0;
            do {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10008;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                if (subgroupElect()) {
                    break;
                }
                loopIdx0++;
            } while (true);
        }
    }
    {
        int loopIdx0 = 0;
        do {
            loopIdx0++;
            switch (loopIdx0) {
                case 1: {
                    break;
                }
                case 2: {
                    break;
                }
                default: {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10016;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    break;
                }
            }
            break;
        } while (loopIdx0 < inputA.a[3]);
    }
    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001c;
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

    switch (inputA.a[2]) {
        case 3:
        {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10002;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10005;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            } else {
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10009;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            break;
        }
        case 2:
        {
            if (subgroupElect()) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000e;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            }
            break;
        }
        case 4:
        {
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
            }
            break;
        }
    }
    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10017;
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
    for (int loopIdx0 = 0;;loopIdx0++,    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true)) {
        switch (inputA.a[4]) {
            case 5:
            {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001c;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                break;
            }
            case 4:
            {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10020;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                break;
            }
            case 6:
            {
                break;
            }
        }
        break;
        if (subgroupElect()) {
            break;
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002a;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        for (int loopIdx1 = 0;
                 loopIdx1 < inputA.a[3];
                 loopIdx1++) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002d;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10030;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        if (testBit(uvec4(0xd1e6eb46, 0xe442a0b6, 0xf986abd3, 0x7e35676e), gl_SubgroupInvocationID)) {
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10034;
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

    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10000;
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
    if (subgroupElect()) {
        if (inputA.a[2] == 2) {
        } else {
        }
    }
    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10007;
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
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
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000e;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                break;
            }
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10012;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
    }
    for (int loopIdx0 = 0;;loopIdx0++,    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true)) {
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10016;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
        } else {
        }
        if (testBit(uvec4(0xc2d3e3ec, 0xbd6921e5, 0x75c6c187, 0x38b7d6e9), gl_SubgroupInvocationID)) {
        } else {
        }
        if (subgroupElect()) {
            break;
        }
        switch (inputA.a[0]) {
            case 1:
            {
                break;
            }
            case 0:
            {
                break;
            }
            case 2:
            {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10027;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                break;
            }
        }
    }
    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002c;
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

    if (subgroupElect()) {
        if (testBit(uvec4(0x69b22f4b, 0xde19e3d2, 0x570385ca, 0xcb85febe), gl_SubgroupInvocationID)) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10002;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10005;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
    }
    for (int loopIdx0 = 0;
             loopIdx0 < inputA.a[4];
             loopIdx0++) {
        if (subgroupElect()) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000a;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000d;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        break;
    }
    {
        int loopIdx0 = 0;
        do {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10012;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            if (inputA.a[2] == 2) {
            }
            {
                int loopIdx1 = 0;
                do {
                    loopIdx1++;
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10017;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                } while (loopIdx1 < inputA.a[3]);
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001a;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            if (subgroupElect()) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001d;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                break;
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10021;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            {
                int loopIdx1 = 0;
                do {
                    if (subgroupElect()) {
                        break;
                    }
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10027;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    loopIdx1++;
                } while (true);
            }
            if (inputA.a[1] == 1) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002b;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            } else {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002e;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            }
            loopIdx0++;
        } while (true);
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

    for (int loopIdx0 = 0;;loopIdx0++,    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true)) {
        if (inputA.a[2] == 2) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10002;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        } else {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10005;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        }
        break;
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10009;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        if (subgroupElect()) {
            break;
        }
        break;
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000f;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        {
            int loopIdx1 = 0;
            do {
                loopIdx1++;
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10012;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            } while (loopIdx1 < inputA.a[5]);
        }
    }
    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10017;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        if (inputA.a[3] == 3) {
        } else {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001b;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001e;
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

    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
        if (testBit(uvec4(0xba9b2883, 0x627a9aea, 0xe415efee, 0xc7b618da), gl_SubgroupInvocationID)) {
        }
        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10004;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        } else {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10007;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000a;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
    }
    for (int loopIdx0 = 0;;loopIdx0++,    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true)) {
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000e;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        if (inputA.a[0] == 0) {
        }
        if (subgroupElect()) {
            break;
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10015;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        break;
        if (testBit(uvec4(0xfc448fa1, 0x68b83ada, 0xcbbd07ad, 0x21ab9f7d), gl_SubgroupInvocationID)) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10019;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        } else {
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001d;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
    }
    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10020;
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


void main()
{

    {
        int loopIdx0 = 0;
        do {
            if (testBit(uvec4(0x7add8c04, 0x3871181, 0x475415fe, 0x72a638d5), gl_SubgroupInvocationID)) {
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10003;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            if (subgroupElect()) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10006;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                break;
            }
            {
                int loopIdx1 = 0;
                do {
                    loopIdx1++;
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000b;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                } while (loopIdx1 < inputA.a[4]);
            }
            if (gl_SubgroupInvocationID == loopIdx0) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000f;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            }
            loopIdx0++;
        } while (true);
    }
    if (testBit(uvec4(0xd42c613d, 0xdc94d4ee, 0x164d5461, 0x5a6d4ffb), gl_SubgroupInvocationID)) {
    }
    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
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
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001a;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                break;
            }
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
                break;
            }
        }
    } else {
        switch (gl_SubgroupInvocationID & 3) {
            case 0:
            case 1:
            {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10027;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                break;
            }
            case 2:
            case 3:
            {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002b;
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


void main()
{

    for (int loopIdx0 = 0;;loopIdx0++,    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true)) {
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10001;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        break;
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10004;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        if (inputA.a[2] == 2) {
            if (gl_SubgroupInvocationID == loopIdx0) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10008;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            } else {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000b;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            }
        } else {
            if (gl_SubgroupInvocationID == loopIdx0) {
            } else {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10011;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            }
            if (subgroupElect()) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10015;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10018;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        }
        if (subgroupElect()) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001c;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            switch (inputA.a[2]) {
                case 3:
                {
                    break;
                }
                case 2:
                {
                    break;
                }
                case 4:
                {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10024;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    break;
                }
            }
            break;
        }
        for (int loopIdx1 = 0;
                 loopIdx1 < gl_SubgroupInvocationID + 1;
                 loopIdx1++) {
            if (testBit(uvec4(0x73a02751, 0xdca3a206, 0xb07b76af, 0xfde17503), gl_SubgroupInvocationID)) {
                break;
            } else {
                break;
            }
        }
        {
            int loopIdx1 = 0;
            do {
                if (subgroupElect()) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10033;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
                if (subgroupElect()) {
                    break;
                }
                if (gl_SubgroupInvocationID == loopIdx1) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1003a;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                } else {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1003d;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10040;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                return;
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10043;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                loopIdx1++;
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
layout(constant_id = 12) const uint cmpIndex2 = 0u;


void main()
{

    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10000;
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
            {
                int loopIdx0 = 0;
                do {
                    loopIdx0++;
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10005;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                } while (loopIdx0 < inputA.a[1]);
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10008;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            for (int loopIdx0 = 0;;loopIdx0++,            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true)) {
                if (subgroupElect()) {
                    break;
                }
            }
        } else {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10010;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            if (testBit(uvec4(0x1963f897, 0x8b4219b3, 0x92c36785, 0xf2d7d33), gl_SubgroupInvocationID)) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10013;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10016;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        }
        switch (gl_SubgroupInvocationID & 3) {
            case 0:
            case 1:
            {
                if (testBit(uvec4(0x1963f897, 0x8b4219b3, 0x92c36785, 0xf2d7d33), gl_SubgroupInvocationID)) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001c;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                } else {
                }
                break;
            }
            case 2:
            case 3:
            {
                if (testBit(uvec4(0x1963f897, 0x8b4219b3, 0x92c36785, 0xf2d7d33), gl_SubgroupInvocationID)) {
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10024;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                if (subgroupElect()) {
                }
                break;
            }
        }
    } else {
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002b;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        {
            int loopIdx0 = 0;
            do {
                if (inputA.a[2] == 2) {
                } else {
                }
                for (int loopIdx1 = 0;;loopIdx1++,                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true)) {
                    if (subgroupElect()) {
                        break;
                    }
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10035;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10038;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                if (subgroupElect()) {
                    break;
                }
                break;
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1003e;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                if (gl_LocalInvocationIndex >= inputA.a[cmpIndex2]) {
                } else {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10042;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
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
layout(constant_id = 12) const uint cmpIndex2 = 0u;
layout(constant_id = 13) const uint cmpIndex3 = 0u;


void main()
{

    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10000;
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
        if (testBit(uvec4(0x2451177d, 0xdcb3c008, 0xe709f5d7, 0xaa106ff5), gl_SubgroupInvocationID)) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10004;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10007;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            }
            if (subgroupElect()) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000b;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            }
        } else {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000f;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        }
        if (testBit(uvec4(0xee6a85de, 0x830e345, 0xf7a56dfc, 0x3bb1816a), gl_SubgroupInvocationID)) {
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex2]) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10014;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            }
            {
                int loopIdx0 = 0;
                do {
                    if (subgroupElect()) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10019;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        break;
                    }
                    loopIdx0++;
                } while (true);
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001e;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        } else {
            if (subgroupElect()) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10022;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10025;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            {
                int loopIdx0 = 0;
                do {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10028;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    if (subgroupElect()) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002b;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        break;
                    }
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002f;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    loopIdx0++;
                } while (true);
            }
        }
    } else {
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10034;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        if (inputA.a[3] == 3) {
            {
                int loopIdx0 = 0;
                do {
                    if (subgroupElect()) {
                        if (testBit(uvec4(0x2451177d, 0xdcb3c008, 0xe709f5d7, 0xaa106ff5), gl_SubgroupInvocationID)) {
                            break;
                        } else {
                            break;
                        }
                    }
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1003f;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    loopIdx0++;
                } while (true);
            }
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex3]) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10043;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            }
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10047;
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


void main()
{

    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10000;
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10003;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        if (subgroupElect()) {
            switch (gl_SubgroupInvocationID & 3) {
                case 0:
                {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10008;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    break;
                }
                case 1:
                {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000c;
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
    }
    {
        int loopIdx0 = 0;
        do {
            loopIdx0++;
            break;
            if (gl_SubgroupInvocationID == loopIdx0) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001f;
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
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10027;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        break;
                    }
                }
            } else {
                if (gl_SubgroupInvocationID == loopIdx0) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002d;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                } else {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10030;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10033;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                if (gl_SubgroupInvocationID == loopIdx0) {
                }
            }
        } while (loopIdx0 < inputA.a[5]);
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

    {
        int loopIdx0 = 0;
        do {
            loopIdx0++;
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10002;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                if (testBit(uvec4(0x64d5c99f, 0x1808a9af, 0xb00e2b66, 0xd0c9bc22), gl_SubgroupInvocationID)) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10005;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                } else {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10008;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
                for (int loopIdx1 = 0;
                         loopIdx1 < gl_SubgroupInvocationID + 1;
                         loopIdx1++) {
                }
            } else {
                for (int loopIdx1 = 0;
                         loopIdx1 < gl_SubgroupInvocationID + 1;
                         loopIdx1++) {
                }
                if (testBit(uvec4(0x7a40b0b4, 0xdcbb1113, 0xb95e8c54, 0xf401d3ec), gl_SubgroupInvocationID)) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10011;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
            }
            continue;
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10016;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        } while (loopIdx0 < inputA.a[1]);
    }
    if (subgroupElect()) {
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001a;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
    }
    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex2]) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001f;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            for (int loopIdx0 = 0;
                     loopIdx0 < gl_SubgroupInvocationID + 1;
                     loopIdx0++) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10022;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            }
        }
        if (inputA.a[3] == 3) {
            if (testBit(uvec4(0xdcc5ff96, 0x8154a0d3, 0x19ca424f, 0x5a437a79), gl_SubgroupInvocationID)) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10028;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            } else {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10028;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            }
        }
    } else {
        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex3]) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10031;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            if (inputA.a[0] == 0) {
            } else {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10035;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            }
            for (int loopIdx0 = 0;
                     loopIdx0 < gl_SubgroupInvocationID + 1;
                     loopIdx0++) {
            }
        }
        if (inputA.a[3] == 3) {
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex4]) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1003d;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            }
            if (subgroupElect()) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10041;
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


void main()
{

    if (subgroupElect()) {
        if (testBit(uvec4(0x69b22f4b, 0xde19e3d2, 0x570385ca, 0xcb85febe), gl_SubgroupInvocationID)) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10002;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            {
                int loopIdx0 = 0;
                do {
                    loopIdx0++;
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10005;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                } while (loopIdx0 < inputA.a[4]);
            }
        } else {
            switch (gl_SubgroupInvocationID & 3) {
                case 0:
                case 1:
                {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000b;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    break;
                }
                case 2:
                case 3:
                {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000f;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    break;
                }
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10013;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10016;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        for (int loopIdx0 = 0;
                 loopIdx0 < gl_SubgroupInvocationID + 1;
                 loopIdx0++) {
            if (inputA.a[2] == 2) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001a;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            } else {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001d;
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


void main()
{

    for (int loopIdx0 = 0;;loopIdx0++,    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true)) {
        if (inputA.a[0] == 0) {
            {
                int loopIdx1 = 0;
                do {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10003;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    if (subgroupElect()) {
                        break;
                    }
                    loopIdx1++;
                } while (true);
            }
        } else {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000a;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            if (inputA.a[1] == 1) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000d;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            } else {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10010;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10013;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        }
        if (subgroupElect()) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10017;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            {
                int loopIdx1 = 0;
                do {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001a;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    if (subgroupElect()) {
                        break;
                    }
                    loopIdx1++;
                } while (true);
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10020;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10023;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        if (subgroupElect()) {
            break;
        }
        if (gl_SubgroupInvocationID == loopIdx0) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10029;
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
                    break;
                }
            }
            break;
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10036;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
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
layout(constant_id = 10) const uint cmpIndex0 = 0u;
layout(constant_id = 11) const uint cmpIndex1 = 0u;


void main()
{

    {
        int loopIdx0 = 0;
        do {
            loopIdx0++;
            continue;
            if (gl_SubgroupInvocationID == loopIdx0) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10003;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                continue;
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10006;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                for (int loopIdx1 = 0;
                         loopIdx1 < inputA.a[2];
                         loopIdx1++) {
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000a;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            } else {
                {
                    int loopIdx1 = 0;
                    do {
                        loopIdx1++;
                    } while (loopIdx1 < inputA.a[1]);
                }
                {
                    int loopIdx1 = 0;
                    do {
                        loopIdx1++;
                    } while (loopIdx1 < inputA.a[1]);
                }
            }
        } while (loopIdx0 < inputA.a[5]);
    }
    if (inputA.a[0] == 0) {
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10014;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        if (testBit(uvec4(0xfded30bc, 0x9e3bcf7f, 0x28b84885, 0x16997569), gl_SubgroupInvocationID)) {
            if (inputA.a[1] == 1) {
            }
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
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001f;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        if (testBit(uvec4(0x9e3fb15d, 0xf894c5ce, 0xc0dfd81f, 0x7ef2adad), gl_SubgroupInvocationID)) {
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
            }
            if (subgroupElect()) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10025;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            }
        } else {
            for (int loopIdx0 = 0;
                     loopIdx0 < inputA.a[2];
                     loopIdx0++) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002a;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            }
            for (int loopIdx0 = 0;
                     loopIdx0 < gl_SubgroupInvocationID + 1;
                     loopIdx0++) {
            }
        }
    } else {
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10031;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        if (inputA.a[0] == 0) {
            if (inputA.a[3] == 3) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10035;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            } else {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10038;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            }
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1003c;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            } else {
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10040;
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
{

    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
        if (testBit(uvec4(0xba9b2883, 0x627a9aea, 0xe415efee, 0xc7b618da), gl_SubgroupInvocationID)) {
            if (inputA.a[2] == 2) {
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10004;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10007;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        return;
    } else {
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000b;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        if (testBit(uvec4(0x9e3fb15d, 0xf894c5ce, 0xc0dfd81f, 0x7ef2adad), gl_SubgroupInvocationID)) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000e;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            if (inputA.a[0] == 0) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10011;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            }
            if (subgroupElect()) {
            }
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10017;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
    }
    for (int loopIdx0 = 0;
             loopIdx0 < inputA.a[4];
             loopIdx0++) {
        switch (gl_SubgroupInvocationID & 3) {
            case 0:
            {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001d;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                break;
            }
            case 1:
            {
                {
                    int loopIdx1 = 0;
                    do {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10022;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        if (subgroupElect()) {
                            break;
                        }
                        loopIdx1++;
                    } while (true);
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10028;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                break;
            }
            case 2:
            {
                if (gl_SubgroupInvocationID == loopIdx0) {
                }
                break;
            }
            case 3:
            {
                for (int loopIdx1 = 0;
                         loopIdx1 < inputA.a[5];
                         loopIdx1++) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10031;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
                break;
            }
        }
        if (gl_SubgroupInvocationID == loopIdx0) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10037;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            if (subgroupElect()) {
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1003b;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1003e;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10041;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        } else {
            if (inputA.a[1] == 1) {
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10046;
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
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1004e;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
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


void main()
{

    {
        int loopIdx0 = 0;
        do {
            if (testBit(uvec4(0x7add8c04, 0x3871181, 0x475415fe, 0x72a638d5), gl_SubgroupInvocationID)) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10002;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            }
            switch (loopIdx0) {
                case 1: {
                    for (int loopIdx1 = 0;
                             loopIdx1 < gl_SubgroupInvocationID + 1;
                             loopIdx1++) {
                    }
                    break;
                }
                case 2: {
                    for (int loopIdx1 = 0;
                             loopIdx1 < inputA.a[3];
                             loopIdx1++) {
                    }
                    break;
                }
                default: {
                    if (inputA.a[1] == 1) {
                    }
                    break;
                }
            }
            if (subgroupElect()) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10014;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                break;
            }
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
                if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001a;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                } else {
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001e;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                switch (gl_SubgroupInvocationID & 3) {
                    case 0:
                    case 1:
                    {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10022;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        break;
                    }
                    case 2:
                    case 3:
                    {
                        break;
                    }
                }
            } else {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10029;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                if (gl_LocalInvocationIndex >= inputA.a[cmpIndex2]) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002c;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
                break;
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10031;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            switch (gl_SubgroupInvocationID & 3) {
                case 0:
                {
                    break;
                }
                case 1:
                {
                    if (subgroupElect()) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10038;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    }
                    break;
                }
                case 2:
                {
                    for (int loopIdx1 = 0;
                             loopIdx1 < gl_SubgroupInvocationID + 1;
                             loopIdx1++) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1003e;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    }
                    break;
                }
                case 3:
                {
                    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex3]) {
                    }
                    break;
                }
            }
            loopIdx0++;
        } while (true);
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

    if (subgroupElect()) {
        for (int loopIdx0 = 0;;loopIdx0++,        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true)) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10002;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            if (testBit(uvec4(0xd42c613d, 0xdc94d4ee, 0x164d5461, 0x5a6d4ffb), gl_SubgroupInvocationID)) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10005;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10008;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000b;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            }
            if (subgroupElect()) {
                break;
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10011;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10014;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            } else {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10014;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001a;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            if (gl_SubgroupInvocationID == loopIdx0) {
            }
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001f;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        if (subgroupElect()) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10022;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            switch (gl_SubgroupInvocationID & 3) {
                case 0:
                case 1:
                {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10026;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    break;
                }
                case 2:
                case 3:
                {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002a;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    break;
                }
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002e;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            if (testBit(uvec4(0xb59fc2fe, 0xdd679954, 0x5c9ed4c3, 0xf991283b), gl_SubgroupInvocationID)) {
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10032;
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

    for (int loopIdx0 = 0;;loopIdx0++,    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true)) {
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10001;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        break;
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10004;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        if (inputA.a[3] == 3) {
            if (gl_SubgroupInvocationID == loopIdx0) {
                for (int loopIdx1 = 0;
                         loopIdx1 < gl_SubgroupInvocationID + 1;
                         loopIdx1++) {
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000a;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                if (inputA.a[3] == 3) {
                } else {
                }
            } else {
                if (inputA.a[3] == 3) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10011;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10014;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            }
        }
        if (subgroupElect()) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10019;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            break;
        }
        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001e;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            {
                int loopIdx1 = 0;
                do {
                    loopIdx1++;
                    continue;
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10022;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    if (inputA.a[2] == 2) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10025;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    } else {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10028;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    }
                } while (loopIdx1 < inputA.a[3]);
            }
            if (subgroupElect()) {
                if (gl_SubgroupInvocationID == loopIdx0) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002e;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
                {
                    int loopIdx1 = 0;
                    do {
                        if (subgroupElect()) {
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10033;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                            break;
                        }
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10037;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        loopIdx1++;
                    } while (true);
                }
            }
        } else {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001e;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            {
                int loopIdx1 = 0;
                do {
                    loopIdx1++;
                    continue;
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10022;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    if (inputA.a[0] == 0) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10025;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    } else {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10028;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    }
                } while (loopIdx1 < inputA.a[3]);
            }
            if (subgroupElect()) {
                if (gl_SubgroupInvocationID == loopIdx0) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002e;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
                {
                    int loopIdx1 = 0;
                    do {
                        if (subgroupElect()) {
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10033;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                            break;
                        }
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10037;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        loopIdx1++;
                    } while (true);
                }
            }
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1005a;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        break;
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1005d;
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
layout(constant_id = 12) const uint cmpIndex2 = 0u;
layout(constant_id = 13) const uint cmpIndex3 = 0u;


void main()
{

    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10000;
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
            {
                int loopIdx0 = 0;
                do {
                    loopIdx0++;
                    continue;
                    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex2]) {
                    } else {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10008;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    }
                } while (loopIdx0 < inputA.a[1]);
            }
            for (int loopIdx0 = 0;;loopIdx0++,            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true)) {
                {
                    int loopIdx1 = 0;
                    do {
                        loopIdx1++;
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000e;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    } while (loopIdx1 < inputA.a[4]);
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10011;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                return;
                if (subgroupElect()) {
                    break;
                }
                if (gl_SubgroupInvocationID == loopIdx0) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10018;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                } else {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001b;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
                if (inputA.a[1] == 1) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001f;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
            }
        }
        if (testBit(uvec4(0x1963f897, 0x8b4219b3, 0x92c36785, 0xf2d7d33), gl_SubgroupInvocationID)) {
            if (testBit(uvec4(0xf769d02, 0x9d77bef, 0xe2a0008a, 0x6bd6bd3a), gl_SubgroupInvocationID)) {
                if (gl_LocalInvocationIndex >= inputA.a[cmpIndex3]) {
                }
                if (inputA.a[2] == 2) {
                }
            }
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


void main()
{

    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10000;
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
        if (testBit(uvec4(0x2451177d, 0xdcb3c008, 0xe709f5d7, 0xaa106ff5), gl_SubgroupInvocationID)) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10004;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10007;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                if (subgroupElect()) {
                }
            }
            switch (inputA.a[3]) {
                case 4:
                {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000e;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    break;
                }
                case 3:
                {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10012;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    break;
                }
                case 5:
                {
                    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex2]) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10017;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    }
                    break;
                }
            }
        } else {
            switch (gl_SubgroupInvocationID & 3) {
                case 0:
                case 1:
                {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001f;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    break;
                }
                case 2:
                case 3:
                {
                    switch (inputA.a[2]) {
                        case 3:
                        {
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10025;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                            break;
                        }
                        case 2:
                        {
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10029;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                            break;
                        }
                        case 4:
                        {
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002d;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                            break;
                        }
                    }
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10031;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    break;
                }
            }
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex3]) {
                if (inputA.a[2] == 2) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10037;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                } else {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10037;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
                if (gl_LocalInvocationIndex >= inputA.a[cmpIndex4]) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1003e;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                } else {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10041;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
            } else {
                if (gl_LocalInvocationIndex >= inputA.a[cmpIndex5]) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10046;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
                for (int loopIdx0 = 0;
                         loopIdx0 < gl_SubgroupInvocationID + 1;
                         loopIdx0++) {
                }
            }
        }
        for (int loopIdx0 = 0;
                 loopIdx0 < gl_SubgroupInvocationID + 1;
                 loopIdx0++) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1004e;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            if (gl_SubgroupInvocationID == loopIdx0) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10051;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                if (subgroupElect()) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10054;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
                if (gl_SubgroupInvocationID == loopIdx0) {
                } else {
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1005a;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            } else {
                if (subgroupElect()) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1005e;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
                if (gl_SubgroupInvocationID == loopIdx0) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10062;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
            }
        }
    } else {
        if (testBit(uvec4(0x2451177d, 0xdcb3c008, 0xe709f5d7, 0xaa106ff5), gl_SubgroupInvocationID)) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10004;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex6]) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10007;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                if (subgroupElect()) {
                }
            }
            switch (inputA.a[3]) {
                case 4:
                {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000e;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    break;
                }
                case 3:
                {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10012;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    break;
                }
                case 5:
                {
                    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex7]) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10017;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    }
                    break;
                }
            }
        } else {
            switch (gl_SubgroupInvocationID & 3) {
                case 0:
                case 1:
                {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001f;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    break;
                }
                case 2:
                case 3:
                {
                    switch (inputA.a[2]) {
                        case 3:
                        {
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10025;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                            break;
                        }
                        case 2:
                        {
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10029;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                            break;
                        }
                        case 4:
                        {
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002d;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                            break;
                        }
                    }
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10031;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    break;
                }
            }
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex8]) {
                if (inputA.a[1] == 1) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10037;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                } else {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10037;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
                if (gl_LocalInvocationIndex >= inputA.a[cmpIndex9]) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1003e;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                } else {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10041;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
            } else {
                if (gl_LocalInvocationIndex >= inputA.a[cmpIndex10]) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10046;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
                for (int loopIdx0 = 0;
                         loopIdx0 < gl_SubgroupInvocationID + 1;
                         loopIdx0++) {
                }
            }
        }
        for (int loopIdx0 = 0;
                 loopIdx0 < gl_SubgroupInvocationID + 1;
                 loopIdx0++) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1004e;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            if (gl_SubgroupInvocationID == loopIdx0) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10051;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                if (subgroupElect()) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10054;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
                if (gl_SubgroupInvocationID == loopIdx0) {
                } else {
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1005a;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            } else {
                if (subgroupElect()) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1005e;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
                if (gl_SubgroupInvocationID == loopIdx0) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10062;
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


void main()
{

    {
        int loopIdx0 = 0;
        do {
            loopIdx0++;
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10002;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                if (testBit(uvec4(0x64d5c99f, 0x1808a9af, 0xb00e2b66, 0xd0c9bc22), gl_SubgroupInvocationID)) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10005;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    if (gl_SubgroupInvocationID == loopIdx0) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10008;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    } else {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000b;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    }
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000e;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    {
                        int loopIdx1 = 0;
                        do {
                            if (subgroupElect()) {
                                break;
                            }
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10014;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                            loopIdx1++;
                        } while (true);
                    }
                }
                {
                    int loopIdx1 = 0;
                    do {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10019;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        {
                            int loopIdx2 = 0;
                            do {
                                if (subgroupElect()) {
                                    break;
                                }
                                outputC.loc[gl_LocalInvocationIndex]++;
                                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001f;
                                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                                loopIdx2++;
                            } while (true);
                        }
                        if (subgroupElect()) {
                            break;
                        }
                        for (int loopIdx2 = 0;
                                 loopIdx2 < gl_SubgroupInvocationID + 1;
                                 loopIdx2++) {
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10026;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        }
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10029;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        loopIdx1++;
                    } while (true);
                }
            } else {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002d;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                break;
            }
            switch (inputA.a[2]) {
                case 3:
                {
                    switch (gl_SubgroupInvocationID & 3) {
                        case 0:
                        {
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10035;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                            if (inputA.a[1] == 1) {
                                outputC.loc[gl_LocalInvocationIndex]++;
                                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10038;
                                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                            } else {
                            }
                            break;
                        }
                        case 1:
                        {
                            if (gl_SubgroupInvocationID == loopIdx0) {
                                outputC.loc[gl_LocalInvocationIndex]++;
                                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1003f;
                                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                            }
                            break;
                        }
                        case 2:
                        {
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10044;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                            if (subgroupElect()) {
                            }
                            break;
                        }
                        case 3:
                        {
                            for (int loopIdx1 = 0;
                                     loopIdx1 < inputA.a[1];
                                     loopIdx1++) {
                                outputC.loc[gl_LocalInvocationIndex]++;
                                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1004b;
                                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                            }
                            break;
                        }
                    }
                    break;
                }
                case 2:
                {
                    if (gl_SubgroupInvocationID == loopIdx0) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10053;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        if (gl_SubgroupInvocationID == loopIdx0) {
                        } else {
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10057;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        }
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1005a;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    }
                    if (subgroupElect()) {
                        if (testBit(uvec4(0x7a40b0b4, 0xdcbb1113, 0xb95e8c54, 0xf401d3ec), gl_SubgroupInvocationID)) {
                            break;
                        } else {
                            break;
                        }
                        if (inputA.a[1] == 1) {
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10064;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        } else {
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10064;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        }
                    }
                    break;
                }
                case 4:
                {
                    break;
                }
            }
        } while (loopIdx0 < inputA.a[1]);
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

    if (subgroupElect()) {
        if (testBit(uvec4(0x69b22f4b, 0xde19e3d2, 0x570385ca, 0xcb85febe), gl_SubgroupInvocationID)) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10002;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            {
                int loopIdx0 = 0;
                do {
                    loopIdx0++;
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10005;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
                    } else {
                    }
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000a;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    for (int loopIdx1 = 0;
                             loopIdx1 < gl_SubgroupInvocationID + 1;
                             loopIdx1++) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000d;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    }
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10010;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                } while (loopIdx0 < inputA.a[4]);
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10013;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        } else {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10002;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            {
                int loopIdx0 = 0;
                do {
                    loopIdx0++;
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10005;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
                    } else {
                    }
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000a;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    for (int loopIdx1 = 0;
                             loopIdx1 < gl_SubgroupInvocationID + 1;
                             loopIdx1++) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000d;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    }
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10010;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                } while (loopIdx0 < inputA.a[4]);
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10013;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        }
        for (int loopIdx0 = 0;
                 loopIdx0 < inputA.a[5];
                 loopIdx0++) {
            if (subgroupElect()) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002c;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                if (inputA.a[1] == 1) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002f;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10033;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            {
                int loopIdx1 = 0;
                do {
                    {
                        int loopIdx2 = 0;
                        do {
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10037;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                            if (subgroupElect()) {
                                break;
                            }
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1003c;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                            loopIdx2++;
                        } while (true);
                    }
                    {
                        int loopIdx2 = 0;
                        do {
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10040;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                            if (subgroupElect()) {
                                outputC.loc[gl_LocalInvocationIndex]++;
                                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10043;
                                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                                break;
                            }
                            loopIdx2++;
                        } while (true);
                    }
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10048;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    if (subgroupElect()) {
                        break;
                    }
                    for (int loopIdx2 = 0;
                             loopIdx2 < inputA.a[4];
                             loopIdx2++) {
                    }
                    loopIdx1++;
                } while (true);
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
        if (inputA.a[3] == 3) {
            {
                int loopIdx1 = 0;
                do {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10003;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    switch (inputA.a[1]) {
                        case 2:
                        {
                            break;
                        }
                        case 1:
                        {
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10009;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                            break;
                        }
                        case 3:
                        {
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000d;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                            break;
                        }
                    }
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10011;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    {
                        int loopIdx2 = 0;
                        do {
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10014;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                            if (subgroupElect()) {
                                break;
                            }
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10019;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                            loopIdx2++;
                        } while (true);
                    }
                    if (subgroupElect()) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001d;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        break;
                    }
                    switch (loopIdx1) {
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
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10029;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
                    } else {
                    }
                    loopIdx1++;
                } while (true);
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002f;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            break;
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10033;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        if (subgroupElect()) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10036;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            break;
        }
        if (inputA.a[3] == 3) {
            switch (gl_SubgroupInvocationID & 3) {
                case 0:
                {
                    break;
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1003e;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    break;
                }
                case 1:
                {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10042;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
                    }
                    break;
                }
                case 2:
                {
                    break;
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
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1004f;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                            break;
                        }
                        case 5:
                        {
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10053;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                            break;
                        }
                    }
                    break;
                }
            }
            break;
        }
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
layout(constant_id = 15) const uint cmpIndex5 = 0u;
layout(constant_id = 16) const uint cmpIndex6 = 0u;
layout(constant_id = 17) const uint cmpIndex7 = 0u;
layout(constant_id = 18) const uint cmpIndex8 = 0u;
layout(constant_id = 19) const uint cmpIndex9 = 0u;
layout(constant_id = 20) const uint cmpIndex10 = 0u;
layout(constant_id = 21) const uint cmpIndex11 = 0u;
layout(constant_id = 22) const uint cmpIndex12 = 0u;
layout(constant_id = 23) const uint cmpIndex13 = 0u;


void main()
{

    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
        if (testBit(uvec4(0xba9b2883, 0x627a9aea, 0xe415efee, 0xc7b618da), gl_SubgroupInvocationID)) {
            if (inputA.a[0] == 0) {
                for (int loopIdx0 = 0;
                         loopIdx0 < inputA.a[1];
                         loopIdx0++) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10004;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
                if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
                }
            } else {
                if (gl_LocalInvocationIndex >= inputA.a[cmpIndex2]) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000b;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
                if (gl_LocalInvocationIndex >= inputA.a[cmpIndex3]) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000f;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                } else {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10012;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
            }
            if (inputA.a[0] == 0) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10017;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            }
        } else {
            if (inputA.a[1] == 1) {
                for (int loopIdx0 = 0;
                         loopIdx0 < inputA.a[1];
                         loopIdx0++) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10004;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
                if (gl_LocalInvocationIndex >= inputA.a[cmpIndex4]) {
                }
            } else {
                if (gl_LocalInvocationIndex >= inputA.a[cmpIndex5]) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000b;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
                if (gl_LocalInvocationIndex >= inputA.a[cmpIndex6]) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000f;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                } else {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10012;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
            }
            if (inputA.a[2] == 2) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10017;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            }
        }
        if (inputA.a[2] == 2) {
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex7]) {
                if (gl_LocalInvocationIndex >= inputA.a[cmpIndex8]) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10037;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                } else {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10037;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
                if (subgroupElect()) {
                }
            }
            if (inputA.a[0] == 0) {
                if (gl_LocalInvocationIndex >= inputA.a[cmpIndex9]) {
                } else {
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10044;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                {
                    int loopIdx0 = 0;
                    do {
                        loopIdx0++;
                    } while (loopIdx0 < inputA.a[4]);
                }
            } else {
                if (inputA.a[1] == 1) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1004a;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
                if (gl_LocalInvocationIndex >= inputA.a[cmpIndex10]) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1004e;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10051;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            }
        }
    } else {
        if (inputA.a[0] == 0) {
            for (int loopIdx0 = 0;;loopIdx0++,            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true)) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10058;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                if (gl_LocalInvocationIndex >= inputA.a[cmpIndex11]) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1005b;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                } else {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1005e;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
                if (subgroupElect()) {
                    if (testBit(uvec4(0x823c9e27, 0xdc8c87e7, 0x409fc185, 0xc7d8a15), gl_SubgroupInvocationID)) {
                        break;
                    } else {
                        break;
                    }
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10068;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                if (inputA.a[3] == 3) {
                }
                if (gl_LocalInvocationIndex >= inputA.a[cmpIndex12]) {
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1006e;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            }
            for (int loopIdx0 = 0;;loopIdx0++,            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true)) {
                if (gl_SubgroupInvocationID == loopIdx0) {
                }
                if (testBit(uvec4(0xba9b2883, 0x627a9aea, 0xe415efee, 0xc7b618da), gl_SubgroupInvocationID)) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10075;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                } else {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10078;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
                if (subgroupElect()) {
                    break;
                }
                break;
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1007f;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            }
        } else {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10083;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            if (subgroupElect()) {
                for (int loopIdx0 = 0;
                         loopIdx0 < gl_SubgroupInvocationID + 1;
                         loopIdx0++) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10087;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1008b;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1008e;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        if (inputA.a[1] == 1) {
            if (subgroupElect()) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10092;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                if (inputA.a[3] == 3) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10095;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                } else {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10098;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
            }
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex13]) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1009d;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                {
                    int loopIdx0 = 0;
                    do {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x100a0;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        if (subgroupElect()) {
                            break;
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
layout(constant_id = 10) const uint cmpIndex0 = 0u;


void main()
{

    {
        int loopIdx0 = 0;
        do {
            if (testBit(uvec4(0x7add8c04, 0x3871181, 0x475415fe, 0x72a638d5), gl_SubgroupInvocationID)) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10002;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            }
            switch (loopIdx0) {
                case 1: {
                    for (int loopIdx1 = 0;
                             loopIdx1 < gl_SubgroupInvocationID + 1;
                             loopIdx1++) {
                        for (int loopIdx2 = 0;;loopIdx2++,                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true)) {
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10009;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                            if (subgroupElect()) {
                                outputC.loc[gl_LocalInvocationIndex]++;
                                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000c;
                                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                                break;
                            }
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10010;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        }
                    }
                    break;
                }
                case 2: {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10016;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    if (subgroupElect()) {
                        if (inputA.a[3] == 3) {
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001a;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        }
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001d;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        {
                            int loopIdx1 = 0;
                            do {
                                outputC.loc[gl_LocalInvocationIndex]++;
                                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10020;
                                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                                if (subgroupElect()) {
                                    if (testBit(uvec4(0xd42c613d, 0xdc94d4ee, 0x164d5461, 0x5a6d4ffb), gl_SubgroupInvocationID)) {
                                        break;
                                    } else {
                                        break;
                                    }
                                }
                                outputC.loc[gl_LocalInvocationIndex]++;
                                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10029;
                                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                                loopIdx1++;
                            } while (true);
                        }
                    }
                    break;
                }
                default: {
                    switch (gl_SubgroupInvocationID & 3) {
                        case 0:
                        case 1:
                        {
                            if (gl_SubgroupInvocationID == loopIdx0) {
                            }
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10033;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                            if (testBit(uvec4(0xdb9660d6, 0x6c04c1e2, 0x97265183, 0xebb4fec8), gl_SubgroupInvocationID)) {
                                outputC.loc[gl_LocalInvocationIndex]++;
                                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10036;
                                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                            }
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10039;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                            break;
                        }
                        case 2:
                        case 3:
                        {
                            if (inputA.a[0] == 0) {
                                outputC.loc[gl_LocalInvocationIndex]++;
                                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1003e;
                                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                            } else {
                                outputC.loc[gl_LocalInvocationIndex]++;
                                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1003e;
                                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                            }
                            break;
                        }
                    }
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10046;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    break;
                }
            }
            if (subgroupElect()) {
                break;
            }
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1004e;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                break;
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10051;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            }
            if (subgroupElect()) {
                {
                    int loopIdx1 = 0;
                    do {
                        loopIdx1++;
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
                                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1005a;
                                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                                break;
                            }
                        }
                        for (int loopIdx2 = 0;
                                 loopIdx2 < gl_SubgroupInvocationID + 1;
                                 loopIdx2++) {
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1005f;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        }
                    } while (loopIdx1 < inputA.a[2]);
                }
                switch (gl_SubgroupInvocationID & 3) {
                    case 0:
                    case 1:
                    {
                        if (subgroupElect()) {
                        }
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10067;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        if (testBit(uvec4(0xd42c613d, 0xdc94d4ee, 0x164d5461, 0x5a6d4ffb), gl_SubgroupInvocationID)) {
                        } else {
                        }
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1006c;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        break;
                    }
                    case 2:
                    case 3:
                    {
                        break;
                        if (gl_SubgroupInvocationID == loopIdx0) {
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10072;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        } else {
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10072;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        }
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10078;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        break;
                    }
                }
            }
            loopIdx0++;
        } while (true);
    }
    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1007e;
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);



}
