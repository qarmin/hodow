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

    if (testBit(uvec4(0x5c279566, 0x5b0364e5, 0xab19e77b, 0xdf709dc4), gl_SubgroupInvocationID)) {
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10003;
        } else {
        }
    }
    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10007;
    if (testBit(uvec4(0xda273742, 0xbb2e665c, 0xbef28f40, 0xcbead8ea), gl_SubgroupInvocationID)) {
        if (subgroupElect()) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000a;
        }
        if (inputA.a[0] == 0) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000d;
        }
    }
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10011;
    for (int loopIdx0 = 0;
             loopIdx0 < gl_SubgroupInvocationID + 1;
             loopIdx0++) {
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        break;
        continue;
    }
    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10017;
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
        if (subgroupElect()) {
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001d;
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


void main()
[[maximally_reconverges]]
{

    {
        int loopIdx0 = 0;
        do {
            loopIdx0++;
            continue;
            if (testBit(uvec4(0x7a4e2690, 0x432fc58e, 0x9b2bb71a, 0xc785c163), gl_SubgroupInvocationID)) {
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            } else {
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            }
        } while (loopIdx0 < inputA.a[3]);
    }
    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10009;
        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        } else {
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        }
    } else {
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10011;
        switch (gl_SubgroupInvocationID & 3) {
            case 0:
            {
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                break;
            }
            case 1:
            {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10017;
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

    if (testBit(uvec4(0x1f082002, 0xf140f2fe, 0xb896a0de, 0x808a57d0), gl_SubgroupInvocationID)) {
        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
        } else {
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        }
        for (int loopIdx0 = 0;;loopIdx0++,        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true)) {
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            if (subgroupElect()) {
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10009;
                break;
            }
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        }
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
    }
    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10011;
        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex2]) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10013;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        } else {
        }
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
    } else {
        if (testBit(uvec4(0x24be39e6, 0xdcb39833, 0xe7e59864, 0xaaff4173), gl_SubgroupInvocationID)) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001a;
        } else {
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001d;
        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex3]) {
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10020;
        } else {
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10020;
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

    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
    switch (inputA.a[0]) {
        case 1:
        {
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            break;
        }
        case 0:
        {
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            }
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            break;
        }
        case 2:
        {
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            {
                int loopIdx0 = 0;
                do {
                    loopIdx0++;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000f;
                } while (loopIdx0 < inputA.a[5]);
            }
            break;
        }
    }
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10014;
    if (testBit(uvec4(0xeb93571b, 0xd23ee0a9, 0xf2c07cfb, 0x8c5d2c), gl_SubgroupInvocationID)) {
        if (subgroupElect()) {
        }
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        switch (inputA.a[2]) {
            case 3:
            {
                break;
            }
            case 2:
            {
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001e;
                break;
            }
            case 4:
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
layout(constant_id = 10) const uint cmpIndex0 = 0u;


void main()
[[maximally_reconverges]]
{

    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
        for (int loopIdx0 = 0;
                 loopIdx0 < inputA.a[2];
                 loopIdx0++) {
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        }
        {
            int loopIdx0 = 0;
            do {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10006;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                if (subgroupElect()) {
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    if (testBit(uvec4(0xf9c83953, 0xdc833ee1, 0x3b114bed, 0x77893a04), gl_SubgroupInvocationID)) {
                        break;
                    } else {
                        break;
                    }
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10010;
                loopIdx0++;
            } while (true);
        }
    } else {
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
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001d;
                break;
            }
        }
        for (int loopIdx0 = 0;;loopIdx0++,        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true)) {
            if (subgroupElect()) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10022;
                break;
            }
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10026;
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


void main()
[[maximally_reconverges]]
{

    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
        for (int loopIdx0 = 0;
                 loopIdx0 < gl_SubgroupInvocationID + 1;
                 loopIdx0++) {
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        }
    }
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10006;
    if (testBit(uvec4(0x2391070a, 0x7c9f6acd, 0x32b370b4, 0x107dbe47), gl_SubgroupInvocationID)) {
        if (testBit(uvec4(0xa1dd7c26, 0xdc8b0f06, 0x6342d0d2, 0x2f9c6461), gl_SubgroupInvocationID)) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10009;
        } else {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10009;
        }
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
    }
    if (testBit(uvec4(0xed6a2561, 0x5b7f8905, 0x1467e57d, 0x96b378c), gl_SubgroupInvocationID)) {
        if (inputA.a[2] == 2) {
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10012;
        } else {
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10016;
    } else {
        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
        } else {
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001c;
        for (int loopIdx0 = 0;
                 loopIdx0 < gl_SubgroupInvocationID + 1;
                 loopIdx0++) {
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

    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
    switch (gl_SubgroupInvocationID & 3) {
        case 0:
        {
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10004;
            }
            break;
        }
        case 1:
        {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10008;
            {
                int loopIdx0 = 0;
                do {
                    loopIdx0++;
                } while (loopIdx0 < inputA.a[3]);
            }
            break;
        }
        case 2:
        {
            if (inputA.a[0] == 0) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000e;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            }
            break;
        }
        case 3:
        {
            for (int loopIdx0 = 0;
                     loopIdx0 < inputA.a[3];
                     loopIdx0++) {
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            }
            break;
        }
    }
    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10018;
    switch (inputA.a[3]) {
        case 4:
        {
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            if (subgroupElect()) {
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            }
            break;
        }
        case 3:
        {
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            }
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            break;
        }
        case 5:
        {
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex2]) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10028;
            } else {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10028;
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

    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
        for (int loopIdx0 = 0;
                 loopIdx0 < gl_SubgroupInvocationID + 1;
                 loopIdx0++) {
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10005;
        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        } else {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10009;
        }
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000c;
    } else {
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000f;
    }
    switch (gl_SubgroupInvocationID & 3) {
        case 0:
        {
            break;
        }
        case 1:
        {
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex2]) {
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            } else {
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            }
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001b;
            break;
        }
        case 2:
        {
            break;
        }
        case 3:
        {
            {
                int loopIdx0 = 0;
                do {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10021;
                    if (subgroupElect()) {
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        break;
                    }
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    loopIdx0++;
                } while (true);
            }
            break;
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

    if (testBit(uvec4(0x5c279566, 0x5b0364e5, 0xab19e77b, 0xdf709dc4), gl_SubgroupInvocationID)) {
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        } else {
            if (subgroupElect()) {
            }
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            }
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        }
    }
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
    {
        int loopIdx0 = 0;
        do {
            for (int loopIdx1 = 0;;loopIdx1++,            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true)) {
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                switch (inputA.a[2]) {
                    case 3:
                    {
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        break;
                    }
                    case 2:
                    {
                        break;
                    }
                    case 4:
                    {
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        break;
                    }
                }
                if (subgroupElect()) {
                    break;
                }
                {
                    int loopIdx2 = 0;
                    do {
                        if (subgroupElect()) {
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                            if (testBit(uvec4(0x576a093a, 0xdca27a4d, 0x94bc142d, 0xd92b5ff1), gl_SubgroupInvocationID)) {
                                break;
                            } else {
                                break;
                            }
                        }
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10027;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        loopIdx2++;
                    } while (true);
                }
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002b;
                switch (inputA.a[4]) {
                    case 5:
                    {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002e;
                        break;
                    }
                    case 4:
                    {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10031;
                        break;
                    }
                    case 6:
                    {
                        break;
                    }
                }
            }
            if (subgroupElect()) {
                break;
            }
            if (testBit(uvec4(0xda273742, 0xbb2e665c, 0xbef28f40, 0xcbead8ea), gl_SubgroupInvocationID)) {
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                if (subgroupElect()) {
                }
            }
            if (subgroupElect()) {
                if (gl_SubgroupInvocationID == loopIdx0) {
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                } else {
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                break;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
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
            continue;
            if (testBit(uvec4(0x7a4e2690, 0x432fc58e, 0x9b2bb71a, 0xc785c163), gl_SubgroupInvocationID)) {
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                continue;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                if (testBit(uvec4(0xec6f3c8, 0xdcaa4b2a, 0xcd523415, 0x8087be24), gl_SubgroupInvocationID)) {
                    continue;
                } else {
                    continue;
                }
            } else {
                if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
                switch (inputA.a[2]) {
                    case 3:
                    {
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        break;
                    }
                    case 2:
                    {
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10015;
                        break;
                    }
                    case 4:
                    {
                        break;
                    }
                }
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001b;
        } while (loopIdx0 < inputA.a[3]);
    }
    if (testBit(uvec4(0xad64dab0, 0xa6151244, 0x8256645b, 0x440398a6), gl_SubgroupInvocationID)) {
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        {
            int loopIdx0 = 0;
            do {
                loopIdx0++;
                if (inputA.a[0] == 0) {
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10022;
                } else {
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10025;
                if (subgroupElect()) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10027;
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10029;
            } while (loopIdx0 < inputA.a[2]);
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002b;
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

    if (testBit(uvec4(0x1f082002, 0xf140f2fe, 0xb896a0de, 0x808a57d0), gl_SubgroupInvocationID)) {
        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            }
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex2]) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10006;
            }
        } else {
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000a;
            if (inputA.a[3] == 3) {
            }
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        }
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        if (inputA.a[1] == 1) {
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            {
                int loopIdx0 = 0;
                do {
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    if (subgroupElect()) {
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        break;
                    }
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10018;
                    loopIdx0++;
                } while (true);
            }
        } else {
            if (inputA.a[0] == 0) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001c;
            } else {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001c;
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


void main()
[[maximally_reconverges]]
{

    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
    switch (inputA.a[0]) {
        case 1:
        {
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            break;
        }
        case 0:
        {
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
                for (int loopIdx0 = 0;
                         loopIdx0 < gl_SubgroupInvocationID + 1;
                         loopIdx0++) {
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
            } else {
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                if (subgroupElect()) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000d;
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000f;
            }
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
                if (gl_LocalInvocationIndex >= inputA.a[cmpIndex2]) {
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10014;
                } else {
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
                if (inputA.a[1] == 1) {
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                } else {
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
            }
            break;
        }
        case 2:
        {
            for (int loopIdx0 = 0;
                     loopIdx0 < inputA.a[2];
                     loopIdx0++) {
                if (inputA.a[3] == 3) {
                } else {
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10024;
                }
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            }
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
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


void main()
[[maximally_reconverges]]
{

    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
        for (int loopIdx0 = 0;
                 loopIdx0 < inputA.a[2];
                 loopIdx0++) {
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            if (subgroupElect()) {
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            }
            if (subgroupElect()) {
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            }
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000b;
    } else {
        if (subgroupElect()) {
            if (subgroupElect()) {
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            }
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            switch (gl_SubgroupInvocationID & 3) {
                case 0:
                {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10014;
                    break;
                }
                case 1:
                {
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10018;
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
        for (int loopIdx0 = 0;;loopIdx0++,        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true)) {
            if (inputA.a[0] == 0) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10023;
            }
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            if (subgroupElect()) {
                break;
            }
            for (int loopIdx1 = 0;;loopIdx1++,            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true)) {
                if (subgroupElect()) {
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    break;
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002e;
            }
            switch (loopIdx0) {
                case 1: {
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    break;
                }
                case 2: {
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    break;
                }
                default: {
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


void main()
[[maximally_reconverges]]
{

    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
        for (int loopIdx0 = 0;
                 loopIdx0 < gl_SubgroupInvocationID + 1;
                 loopIdx0++) {
            if (testBit(uvec4(0x2391070a, 0x7c9f6acd, 0x32b370b4, 0x107dbe47), gl_SubgroupInvocationID)) {
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            } else {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10005;
            }
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10008;
            break;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        }
    } else {
        for (int loopIdx0 = 0;
                 loopIdx0 < gl_SubgroupInvocationID + 1;
                 loopIdx0++) {
            if (testBit(uvec4(0x2391070a, 0x7c9f6acd, 0x32b370b4, 0x107dbe47), gl_SubgroupInvocationID)) {
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            } else {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10005;
            }
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10008;
            break;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        }
    }
    {
        int loopIdx0 = 0;
        do {
            loopIdx0++;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
                {
                    int loopIdx1 = 0;
                    do {
                        loopIdx1++;
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001d;
                    } while (loopIdx1 < inputA.a[4]);
                }
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                if (inputA.a[3] == 3) {
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                } else {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10023;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            } else {
                for (int loopIdx1 = 0;
                         loopIdx1 < gl_SubgroupInvocationID + 1;
                         loopIdx1++) {
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
                if (testBit(uvec4(0xa1dd7c26, 0xdc8b0f06, 0x6342d0d2, 0x2f9c6461), gl_SubgroupInvocationID)) {
                    continue;
                } else {
                    continue;
                }
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            }
        } while (loopIdx0 < inputA.a[5]);
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
    switch (gl_SubgroupInvocationID & 3) {
        case 0:
        {
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10004;
                if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10006;
                }
            }
            break;
        }
        case 1:
        {
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
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10012;
                    {
                        int loopIdx0 = 0;
                        do {
                            loopIdx0++;
                        } while (loopIdx0 < inputA.a[2]);
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
                    {
                        int loopIdx0 = 0;
                        do {
                            loopIdx0++;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        } while (loopIdx0 < inputA.a[4]);
                    }
                    break;
                }
            }
            break;
        }
        case 2:
        {
            break;
        }
        case 3:
        {
            if (subgroupElect()) {
                if (inputA.a[0] == 0) {
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
                if (testBit(uvec4(0x90a02a95, 0xc9aa12ee, 0x338888b3, 0x4ec35298), gl_SubgroupInvocationID)) {
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                } else {
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
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
    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
        for (int loopIdx0 = 0;
                 loopIdx0 < gl_SubgroupInvocationID + 1;
                 loopIdx0++) {
            break;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            if (gl_SubgroupInvocationID == loopIdx0) {
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10007;
            } else {
            }
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000b;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
    }
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
    } else {
        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex2]) {
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex3]) {
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            }
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        }
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
    }
    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001a;
    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex4]) {
        if (testBit(uvec4(0xeea35134, 0xe6758eea, 0x3c8c5431, 0xea7deee1), gl_SubgroupInvocationID)) {
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            for (int loopIdx0 = 0;;loopIdx0++,            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true)) {
                if (subgroupElect()) {
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    break;
                }
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            }
            {
                int loopIdx0 = 0;
                do {
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    if (subgroupElect()) {
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        break;
                    }
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002b;
                    loopIdx0++;
                } while (true);
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002d;
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

    if (testBit(uvec4(0x5c279566, 0x5b0364e5, 0xab19e77b, 0xdf709dc4), gl_SubgroupInvocationID)) {
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        } else {
            if (subgroupElect()) {
                if (inputA.a[0] == 0) {
                }
            }
        }
    }
    {
        int loopIdx0 = 0;
        do {
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            {
                int loopIdx1 = 0;
                do {
                    for (int loopIdx2 = 0;;loopIdx2++,                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true)) {
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        switch (inputA.a[2]) {
                            case 3:
                            {
                                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                                break;
                            }
                            case 2:
                            {
                                break;
                            }
                            case 4:
                            {
                                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                                break;
                            }
                        }
                        if (subgroupElect()) {
                            break;
                        }
                        {
                            int loopIdx3 = 0;
                            do {
                                if (subgroupElect()) {
                                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                                    if (testBit(uvec4(0x576a093a, 0xdca27a4d, 0x94bc142d, 0xd92b5ff1), gl_SubgroupInvocationID)) {
                                        break;
                                    } else {
                                        break;
                                    }
                                }
                                outputC.loc[gl_LocalInvocationIndex]++;
                                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10026;
                                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                                loopIdx3++;
                            } while (true);
                        }
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002a;
                        switch (inputA.a[4]) {
                            case 5:
                            {
                                outputC.loc[gl_LocalInvocationIndex]++;
                                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002d;
                                break;
                            }
                            case 4:
                            {
                                outputC.loc[gl_LocalInvocationIndex]++;
                                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10030;
                                break;
                            }
                            case 6:
                            {
                                break;
                            }
                        }
                    }
                    if (subgroupElect()) {
                        break;
                    }
                    if (testBit(uvec4(0xda273742, 0xbb2e665c, 0xbef28f40, 0xcbead8ea), gl_SubgroupInvocationID)) {
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        if (subgroupElect()) {
                        }
                    }
                    if (subgroupElect()) {
                        if (gl_SubgroupInvocationID == loopIdx1) {
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        } else {
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        }
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        break;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    }
                    loopIdx1++;
                } while (true);
            }
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            if (subgroupElect()) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1004b;
                break;
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1004e;
            {
                int loopIdx1 = 0;
                do {
                    loopIdx1++;
                    switch (inputA.a[1]) {
                        case 2:
                        {
                            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
                                outputC.loc[gl_LocalInvocationIndex]++;
                                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10053;
                            }
                            break;
                        }
                        case 1:
                        {
                            if (inputA.a[3] == 3) {
                                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                            }
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1005b;
                            continue;
                            break;
                        }
                        case 3:
                        {
                            switch (gl_SubgroupInvocationID & 3) {
                                case 0:
                                {
                                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                                    break;
                                }
                                case 1:
                                {
                                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                                    outputC.loc[gl_LocalInvocationIndex]++;
                                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10065;
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
                    }
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1006e;
                    for (int loopIdx2 = 0;;loopIdx2++,                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true)) {
                        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex2]) {
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10071;
                        } else {
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10073;
                        }
                        break;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        if (subgroupElect()) {
                            break;
                        }
                        break;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex3]) {
                        } else {
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        }
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    }
                } while (loopIdx1 < inputA.a[3]);
            }
            {
                int loopIdx1 = 0;
                do {
                    loopIdx1++;
                    if (testBit(uvec4(0x576a093a, 0xdca27a4d, 0x94bc142d, 0xd92b5ff1), gl_SubgroupInvocationID)) {
                        if (gl_SubgroupInvocationID == loopIdx1) {
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        }
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        if (subgroupElect()) {
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1008a;
                        }
                    } else {
                        {
                            int loopIdx2 = 0;
                            do {
                                loopIdx2++;
                                outputC.loc[gl_LocalInvocationIndex]++;
                                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1008e;
                            } while (loopIdx2 < inputA.a[1]);
                        }
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10091;
                    }
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10093;
                    if (testBit(uvec4(0xda273742, 0xbb2e665c, 0xbef28f40, 0xcbead8ea), gl_SubgroupInvocationID)) {
                        continue;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        for (int loopIdx2 = 0;;loopIdx2++,                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true)) {
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                            if (subgroupElect()) {
                                outputC.loc[gl_LocalInvocationIndex]++;
                                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1009a;
                                break;
                            }
                        }
                    } else {
                        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex4]) {
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x100a0;
                        }
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        if (subgroupElect()) {
                        }
                    }
                } while (loopIdx1 < inputA.a[4]);
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x100a7;
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

    {
        int loopIdx0 = 0;
        do {
            loopIdx0++;
            continue;
            if (testBit(uvec4(0x7a4e2690, 0x432fc58e, 0x9b2bb71a, 0xc785c163), gl_SubgroupInvocationID)) {
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                continue;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                if (testBit(uvec4(0xec6f3c8, 0xdcaa4b2a, 0xcd523415, 0x8087be24), gl_SubgroupInvocationID)) {
                    continue;
                } else {
                    continue;
                }
            } else {
                if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
                    if (inputA.a[2] == 2) {
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    }
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10010;
                    {
                        int loopIdx1 = 0;
                        do {
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10012;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                            if (subgroupElect()) {
                                break;
                            }
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10018;
                            loopIdx1++;
                        } while (true);
                    }
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001a;
                } else {
                    for (int loopIdx1 = 0;;loopIdx1++,                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true)) {
                        if (subgroupElect()) {
                            break;
                        }
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10020;
                    }
                    return;
                }
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                if (subgroupElect()) {
                    for (int loopIdx1 = 0;
                             loopIdx1 < inputA.a[2];
                             loopIdx1++) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10027;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    }
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002a;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    switch (inputA.a[4]) {
                        case 5:
                        {
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                            break;
                        }
                        case 4:
                        {
                            break;
                        }
                        case 6:
                        {
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10033;
                            break;
                        }
                    }
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            }
        } while (loopIdx0 < inputA.a[3]);
    }
    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1003b;



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


void main()
[[maximally_reconverges]]
{

    if (testBit(uvec4(0x1f082002, 0xf140f2fe, 0xb896a0de, 0x808a57d0), gl_SubgroupInvocationID)) {
        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
                {
                    int loopIdx0 = 0;
                    do {
                        loopIdx0++;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    } while (loopIdx0 < inputA.a[4]);
                }
                if (testBit(uvec4(0x1f082002, 0xf140f2fe, 0xb896a0de, 0x808a57d0), gl_SubgroupInvocationID)) {
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                } else {
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000a;
                }
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            } else {
                if (testBit(uvec4(0x20acbc5e, 0x3ac93720, 0xc31450d5, 0xdfc2e34e), gl_SubgroupInvocationID)) {
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                } else {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10011;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
                if (gl_LocalInvocationIndex >= inputA.a[cmpIndex2]) {
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                } else {
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            }
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex3]) {
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
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10023;
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
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002a;
                {
                    int loopIdx0 = 0;
                    do {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002c;
                        if (subgroupElect()) {
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002f;
                            break;
                        }
                        loopIdx0++;
                    } while (true);
                }
            } else {
                switch (gl_SubgroupInvocationID & 3) {
                    case 0:
                    {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10036;
                        break;
                    }
                    case 1:
                    {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10039;
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
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10041;
                if (inputA.a[2] == 2) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10043;
                }
            }
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        }
        if (inputA.a[1] == 1) {
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex4]) {
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                switch (inputA.a[3]) {
                    case 4:
                    {
                        break;
                    }
                    case 3:
                    {
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10050;
                        break;
                    }
                    case 5:
                    {
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        break;
                    }
                }
                if (inputA.a[2] == 2) {
                }
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            }
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex5]) {
                for (int loopIdx0 = 0;
                         loopIdx0 < gl_SubgroupInvocationID + 1;
                         loopIdx0++) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1005d;
                }
                if (testBit(uvec4(0x20acbc5e, 0x3ac93720, 0xc31450d5, 0xdfc2e34e), gl_SubgroupInvocationID)) {
                } else {
                }
            } else {
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10064;
                if (gl_LocalInvocationIndex >= inputA.a[cmpIndex6]) {
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                } else {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10068;
                }
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1006b;
        }
    } else {
        for (int loopIdx0 = 0;
                 loopIdx0 < inputA.a[1];
                 loopIdx0++) {
            if (testBit(uvec4(0x20acbc5e, 0x3ac93720, 0xc31450d5, 0xdfc2e34e), gl_SubgroupInvocationID)) {
                if (inputA.a[1] == 1) {
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                } else {
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10074;
                }
                if (subgroupElect()) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10077;
                }
            } else {
                if (inputA.a[2] == 2) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1007b;
                }
            }
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            for (int loopIdx1 = 0;
                     loopIdx1 < gl_SubgroupInvocationID + 1;
                     loopIdx1++) {
                if (inputA.a[3] == 3) {
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                } else {
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
            }
        }
        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex7]) {
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        } else {
            if (testBit(uvec4(0x1f082002, 0xf140f2fe, 0xb896a0de, 0x808a57d0), gl_SubgroupInvocationID)) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10095;
                if (gl_LocalInvocationIndex >= inputA.a[cmpIndex8]) {
                }
                if (gl_LocalInvocationIndex >= inputA.a[cmpIndex9]) {
                } else {
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1009b;
                }
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            }
            {
                int loopIdx0 = 0;
                do {
                    loopIdx0++;
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
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x100a8;
                } while (loopIdx0 < inputA.a[3]);
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
layout(constant_id = 15) const uint cmpIndex5 = 0u;
layout(constant_id = 16) const uint cmpIndex6 = 0u;
layout(constant_id = 17) const uint cmpIndex7 = 0u;


void main()
[[maximally_reconverges]]
{

    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
    switch (inputA.a[0]) {
        case 1:
        {
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            break;
        }
        case 0:
        {
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
                for (int loopIdx0 = 0;
                         loopIdx0 < gl_SubgroupInvocationID + 1;
                         loopIdx0++) {
                    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    } else {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000b;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    }
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000f;
                if (inputA.a[0] == 0) {
                    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex2]) {
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    } else {
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    }
                    if (testBit(uvec4(0xa6844fcd, 0xd7def1a2, 0x355598c3, 0xc483030c), gl_SubgroupInvocationID)) {
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    }
                } else {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001a;
                    for (int loopIdx0 = 0;;loopIdx0++,                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true)) {
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        if (subgroupElect()) {
                            break;
                        }
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    }
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
            } else {
                if (subgroupElect()) {
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex3]) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10028;
                    }
                }
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                if (subgroupElect()) {
                    switch (inputA.a[4]) {
                        case 5:
                        {
                            break;
                        }
                        case 4:
                        {
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                            break;
                        }
                        case 6:
                        {
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10035;
                            break;
                        }
                    }
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10038;
                }
            }
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex4]) {
                if (subgroupElect()) {
                    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex5]) {
                    } else {
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    }
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex6]) {
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    } else {
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    }
                }
                {
                    int loopIdx0 = 0;
                    do {
                        loopIdx0++;
                        if (testBit(uvec4(0xa6844fcd, 0xd7def1a2, 0x355598c3, 0xc483030c), gl_SubgroupInvocationID)) {
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1004a;
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
                                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                                outputC.loc[gl_LocalInvocationIndex]++;
                                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10056;
                                break;
                            }
                            case 3:
                            {
                                break;
                            }
                        }
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    } while (loopIdx0 < inputA.a[1]);
                }
            } else {
                switch (inputA.a[2]) {
                    case 3:
                    {
                        break;
                    }
                    case 2:
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
                                break;
                            }
                            case 3:
                            {
                                break;
                            }
                        }
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        {
                            int loopIdx0 = 0;
                            do {
                                outputC.loc[gl_LocalInvocationIndex]++;
                                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1006e;
                                if (subgroupElect()) {
                                    break;
                                }
                                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                                outputC.loc[gl_LocalInvocationIndex]++;
                                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10073;
                                loopIdx0++;
                            } while (true);
                        }
                        break;
                    }
                    case 4:
                    {
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        break;
                    }
                }
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            }
            break;
        }
        case 2:
        {
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            if (subgroupElect()) {
                if (inputA.a[1] == 1) {
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex7]) {
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10084;
                    } else {
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    }
                }
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                for (int loopIdx0 = 0;
                         loopIdx0 < gl_SubgroupInvocationID + 1;
                         loopIdx0++) {
                    {
                        int loopIdx1 = 0;
                        do {
                            if (subgroupElect()) {
                                break;
                            }
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1008f;
                            loopIdx1++;
                        } while (true);
                    }
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10091;
                    if (gl_SubgroupInvocationID == loopIdx0) {
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10094;
                    }
                }
            }
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
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
layout(constant_id = 13) const uint cmpIndex3 = 0u;
layout(constant_id = 14) const uint cmpIndex4 = 0u;
layout(constant_id = 15) const uint cmpIndex5 = 0u;
layout(constant_id = 16) const uint cmpIndex6 = 0u;


void main()
[[maximally_reconverges]]
{

    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
        for (int loopIdx0 = 0;
                 loopIdx0 < inputA.a[2];
                 loopIdx0++) {
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            if (subgroupElect()) {
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                continue;
            }
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            switch (gl_SubgroupInvocationID & 3) {
                case 0:
                {
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    for (int loopIdx1 = 0;;loopIdx1++,                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true)) {
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        if (subgroupElect()) {
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000f;
                            break;
                        }
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    }
                    break;
                }
                case 1:
                {
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10018;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    } else {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001b;
                    }
                    break;
                }
                case 2:
                {
                    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex2]) {
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10021;
                    } else {
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    }
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    break;
                }
                case 3:
                {
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
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002f;
                            break;
                        }
                        case 3:
                        {
                            break;
                        }
                    }
                    break;
                }
            }
        }
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        switch (gl_SubgroupInvocationID & 3) {
            case 0:
            {
                for (int loopIdx0 = 0;
                         loopIdx0 < inputA.a[5];
                         loopIdx0++) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1003b;
                    if (inputA.a[1] == 1) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1003d;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    }
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10041;
                break;
            }
            case 1:
            {
                if (subgroupElect()) {
                    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex3]) {
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    } else {
                    }
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1004a;
                    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex4]) {
                    }
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1004e;
                break;
            }
            case 2:
            {
                if (inputA.a[2] == 2) {
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex5]) {
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    } else {
                    }
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex6]) {
                    }
                }
                break;
            }
            case 3:
            {
                if (testBit(uvec4(0xf9c83953, 0xdc833ee1, 0x3b114bed, 0x77893a04), gl_SubgroupInvocationID)) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1005e;
                    if (testBit(uvec4(0x461ab27e, 0xfea00e58, 0xc9829b62, 0x787df9a3), gl_SubgroupInvocationID)) {
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    } else {
                    }
                    {
                        int loopIdx0 = 0;
                        do {
                            if (subgroupElect()) {
                                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                                break;
                            }
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10069;
                            loopIdx0++;
                        } while (true);
                    }
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

    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
        for (int loopIdx0 = 0;
                 loopIdx0 < gl_SubgroupInvocationID + 1;
                 loopIdx0++) {
            if (testBit(uvec4(0x2391070a, 0x7c9f6acd, 0x32b370b4, 0x107dbe47), gl_SubgroupInvocationID)) {
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
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
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000c;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            } else {
                if (gl_SubgroupInvocationID == loopIdx0) {
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10011;
                } else {
                }
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                break;
            }
            for (int loopIdx1 = 0;;loopIdx1++,            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true)) {
                switch (loopIdx0) {
                    case 1: {
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001b;
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
                if (testBit(uvec4(0xa1dd7c26, 0xdc8b0f06, 0x6342d0d2, 0x2f9c6461), gl_SubgroupInvocationID)) {
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10026;
                if (subgroupElect()) {
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    break;
                }
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002c;
                if (testBit(uvec4(0xed6a2561, 0x5b7f8905, 0x1467e57d, 0x96b378c), gl_SubgroupInvocationID)) {
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
                if (inputA.a[1] == 1) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10031;
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
layout(constant_id = 15) const uint cmpIndex5 = 0u;


void main()
[[maximally_reconverges]]
{

    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
    switch (gl_SubgroupInvocationID & 3) {
        case 0:
        {
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10004;
                if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
                    if (inputA.a[3] == 3) {
                    }
                    {
                        int loopIdx0 = 0;
                        do {
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10009;
                            if (subgroupElect()) {
                                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                                break;
                            }
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000e;
                            loopIdx0++;
                        } while (true);
                    }
                }
            }
            break;
        }
        case 1:
        {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10014;
            switch (inputA.a[3]) {
                case 4:
                {
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    if (subgroupElect()) {
                        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex2]) {
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        } else {
                        }
                    }
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    break;
                }
                case 3:
                {
                    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex3]) {
                        for (int loopIdx0 = 0;
                                 loopIdx0 < gl_SubgroupInvocationID + 1;
                                 loopIdx0++) {
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        }
                    } else {
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
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10033;
                        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex4]) {
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10035;
                        } else {
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        }
                    }
                    {
                        int loopIdx0 = 0;
                        do {
                            loopIdx0++;
                            if (subgroupElect()) {
                            }
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                            break;
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1003f;
                        } while (loopIdx0 < inputA.a[3]);
                    }
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    break;
                }
                case 5:
                {
                    if (inputA.a[2] == 2) {
                        if (testBit(uvec4(0x90a02a95, 0xc9aa12ee, 0x338888b3, 0x4ec35298), gl_SubgroupInvocationID)) {
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        }
                        {
                            int loopIdx0 = 0;
                            do {
                                loopIdx0++;
                                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                            } while (loopIdx0 < inputA.a[1]);
                        }
                    } else {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1004c;
                        if (inputA.a[3] == 3) {
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        } else {
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10050;
                        }
                    }
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    break;
                }
            }
            break;
        }
        case 2:
        {
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            if (testBit(uvec4(0x987d2de, 0x211b278, 0xf3463852, 0x94df3666), gl_SubgroupInvocationID)) {
                for (int loopIdx0 = 0;;loopIdx0++,                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true)) {
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1005c;
                    {
                        int loopIdx1 = 0;
                        do {
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1005e;
                            if (subgroupElect()) {
                                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                                break;
                            }
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10063;
                            loopIdx1++;
                        } while (true);
                    }
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    if (subgroupElect()) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10067;
                    }
                    if (subgroupElect()) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1006a;
                        break;
                    }
                    if (inputA.a[1] == 1) {
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    }
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    for (int loopIdx1 = 0;
                             loopIdx1 < gl_SubgroupInvocationID + 1;
                             loopIdx1++) {
                    }
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10074;
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10076;
            break;
        }
        case 3:
        {
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex5]) {
                for (int loopIdx0 = 0;;loopIdx0++,                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true)) {
                    if (gl_SubgroupInvocationID == loopIdx0) {
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    }
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1007e;
                    if (subgroupElect()) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10080;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        break;
                    }
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    for (int loopIdx1 = 0;
                             loopIdx1 < gl_SubgroupInvocationID + 1;
                             loopIdx1++) {
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    }
                }
                for (int loopIdx0 = 0;
                         loopIdx0 < gl_SubgroupInvocationID + 1;
                         loopIdx0++) {
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1008b;
                    if (testBit(uvec4(0x4dc2923c, 0xdc935c2f, 0x8f9e5516, 0xc383a7ce), gl_SubgroupInvocationID)) {
                        continue;
                    } else {
                        continue;
                    }
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    if (subgroupElect()) {
                    }
                }
            }
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
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

    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
        for (int loopIdx0 = 0;
                 loopIdx0 < gl_SubgroupInvocationID + 1;
                 loopIdx0++) {
            break;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            if (gl_SubgroupInvocationID == loopIdx0) {
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                {
                    int loopIdx1 = 0;
                    do {
                        loopIdx1++;
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10008;
                    } while (loopIdx1 < inputA.a[1]);
                }
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000d;
                } else {
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
            } else {
                break;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                switch (loopIdx0) {
                    case 1: {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10016;
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

    switch (inputA.a[2]) {
        case 3:
        {
            break;
        }
        case 2:
        {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10004;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            if (testBit(uvec4(0x5c279566, 0x5b0364e5, 0xab19e77b, 0xdf709dc4), gl_SubgroupInvocationID)) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10007;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            } else {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000a;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            }
            {
                int loopIdx0 = 0;
                do {
                    if (subgroupElect()) {
                        break;
                    }
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10011;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    loopIdx0++;
                } while (true);
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10014;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            break;
        }
        case 4:
        {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10018;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001b;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            } else {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001e;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            }
            break;
        }
    }
    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10023;
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

    if (testBit(uvec4(0x5c279566, 0x5b0364e5, 0xab19e77b, 0xdf709dc4), gl_SubgroupInvocationID)) {
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10001;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
        } else {
        }
    }
    if (testBit(uvec4(0xda273742, 0xbb2e665c, 0xbef28f40, 0xcbead8ea), gl_SubgroupInvocationID)) {
        if (subgroupElect()) {
        }
        if (inputA.a[0] == 0) {
        }
    }
    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000d;
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
    for (int loopIdx0 = 0;
             loopIdx0 < gl_SubgroupInvocationID + 1;
             loopIdx0++) {
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10010;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        break;
        continue;
    }
    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10015;
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
        if (subgroupElect()) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10019;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001c;
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
            continue;
            if (testBit(uvec4(0x7a4e2690, 0x432fc58e, 0x9b2bb71a, 0xc785c163), gl_SubgroupInvocationID)) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10003;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            } else {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10003;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            }
        } while (loopIdx0 < inputA.a[3]);
    }
    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000c;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        } else {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000f;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        }
    } else {
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10013;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        switch (gl_SubgroupInvocationID & 3) {
            case 0:
            case 1:
            {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10017;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                break;
            }
            case 2:
            case 3:
            {
                break;
            }
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
layout(constant_id = 12) const uint cmpIndex2 = 0u;
layout(constant_id = 13) const uint cmpIndex3 = 0u;


void main()
[[subgroup_uniform_control_flow]]
{

    if (testBit(uvec4(0x1f082002, 0xf140f2fe, 0xb896a0de, 0x808a57d0), gl_SubgroupInvocationID)) {
        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
        } else {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10003;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        }
        for (int loopIdx0 = 0;;loopIdx0++,        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect()) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10007;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            if (subgroupElect()) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000a;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                break;
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000e;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10011;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
    }
    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex2]) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10016;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        } else {
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001a;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
    } else {
        if (testBit(uvec4(0x24be39e6, 0xdcb39833, 0xe7e59864, 0xaaff4173), gl_SubgroupInvocationID)) {
        } else {
        }
        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex3]) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10021;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        } else {
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
    switch (inputA.a[0]) {
        case 1:
        {
            if (testBit(uvec4(0x20acbc5e, 0x3ac93720, 0xc31450d5, 0xdfc2e34e), gl_SubgroupInvocationID)) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10005;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            } else {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10008;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            }
            break;
        }
        case 0:
        {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000d;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            if (subgroupElect()) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10010;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            }
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10014;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            }
            break;
        }
        case 2:
        {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10019;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            {
                int loopIdx0 = 0;
                do {
                    loopIdx0++;
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001c;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                } while (loopIdx0 < inputA.a[1]);
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001f;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
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


void main()
[[subgroup_uniform_control_flow]]
{

    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10000;
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
    switch (inputA.a[0]) {
        case 1:
        {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10004;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            break;
        }
        case 0:
        {
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10009;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000c;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            break;
        }
        case 2:
        {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10010;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            {
                int loopIdx0 = 0;
                do {
                    loopIdx0++;
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10013;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                } while (loopIdx0 < inputA.a[5]);
            }
            break;
        }
    }
    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10018;
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
    if (testBit(uvec4(0xeb93571b, 0xd23ee0a9, 0xf2c07cfb, 0x8c5d2c), gl_SubgroupInvocationID)) {
        if (subgroupElect()) {
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001d;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        switch (inputA.a[2]) {
            case 3:
            {
                break;
            }
            case 2:
            {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10023;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                break;
            }
            case 4:
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
layout(local_size_x_id = 0, local_size_y_id = 1, local_size_z = 1) in;
layout(set=0, binding=2) coherent buffer OutputC { uint loc[]; } outputC;
layout(set=0, binding=1) coherent buffer OutputB { uvec4 b[]; } outputB;
layout(set=0, binding=0) coherent buffer InputA  { uint  a[]; } inputA;
layout(push_constant) uniform PC {
   // set to the real stride when writing out ballots, or zero when just counting
   int  invocationStride;
   // wildcard fields, for an example the dimensions of rendered area in the case of graphics shaders
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
        for (int loopIdx0 = 0;
                 loopIdx0 < gl_SubgroupInvocationID + 1;
                 loopIdx0++) {
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10005;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10008;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000b;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
    } else {
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000e;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
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
        if (subgroupElect()) {
        }
    }
    switch (gl_SubgroupInvocationID & 3) {
        case 0:
        case 1:
        {
            for (int loopIdx0 = 0;
                     loopIdx0 < inputA.a[3];
                     loopIdx0++) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10020;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10023;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            if (subgroupElect()) {
            }
            break;
        }
        case 2:
        case 3:
        {
            {
                int loopIdx0 = 0;
                do {
                    if (subgroupElect()) {
                        break;
                    }
                    loopIdx0++;
                } while (true);
            }
            if (inputA.a[3] == 3) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002f;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            } else {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10032;
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


void main()
[[subgroup_uniform_control_flow]]
{

    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10000;
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
        for (int loopIdx0 = 0;
                 loopIdx0 < inputA.a[2];
                 loopIdx0++) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10004;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        }
        {
            int loopIdx0 = 0;
            do {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10008;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                if (subgroupElect()) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000b;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    if (testBit(uvec4(0xf9c83953, 0xdc833ee1, 0x3b114bed, 0x77893a04), gl_SubgroupInvocationID)) {
                        break;
                    } else {
                        break;
                    }
                }
                loopIdx0++;
            } while (true);
        }
    } else {
        switch (gl_SubgroupInvocationID & 3) {
            case 0:
            case 1:
            {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10017;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                break;
            }
            case 2:
            case 3:
            {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001b;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                break;
            }
        }
        for (int loopIdx0 = 0;;loopIdx0++,        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect()) {
            if (subgroupElect()) {
                break;
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10023;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10026;
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
        for (int loopIdx0 = 0;
                 loopIdx0 < gl_SubgroupInvocationID + 1;
                 loopIdx0++) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10002;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        }
    }
    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10006;
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
    if (testBit(uvec4(0x2391070a, 0x7c9f6acd, 0x32b370b4, 0x107dbe47), gl_SubgroupInvocationID)) {
        if (testBit(uvec4(0xa1dd7c26, 0xdc8b0f06, 0x6342d0d2, 0x2f9c6461), gl_SubgroupInvocationID)) {
        } else {
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000c;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
    }
    if (testBit(uvec4(0xed6a2561, 0x5b7f8905, 0x1467e57d, 0x96b378c), gl_SubgroupInvocationID)) {
        if (inputA.a[2] == 2) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10011;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        } else {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10014;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        }
    } else {
        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
        } else {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001a;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        }
        for (int loopIdx0 = 0;
                 loopIdx0 < gl_SubgroupInvocationID + 1;
                 loopIdx0++) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001e;
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


void main()
[[subgroup_uniform_control_flow]]
{

    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10000;
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
    switch (gl_SubgroupInvocationID & 3) {
        case 0:
        case 1:
        {
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
            }
            {
                int loopIdx0 = 0;
                do {
                    loopIdx0++;
                } while (loopIdx0 < inputA.a[3]);
            }
            break;
        }
        case 2:
        case 3:
        {
            if (inputA.a[0] == 0) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000b;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            }
            for (int loopIdx0 = 0;
                     loopIdx0 < inputA.a[3];
                     loopIdx0++) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000f;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            }
            break;
        }
    }
    switch (inputA.a[3]) {
        case 4:
        {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10016;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            if (subgroupElect()) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10019;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            }
            break;
        }
        case 3:
        {
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001f;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10022;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            break;
        }
        case 5:
        {
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex2]) {
            } else {
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

    for (int loopIdx0 = 0;
             loopIdx0 < inputA.a[3];
             loopIdx0++) {
        if (inputA.a[2] == 2) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10002;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10005;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        if (subgroupElect()) {
        }
    }
    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000a;
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
    for (int loopIdx0 = 0;
             loopIdx0 < inputA.a[1];
             loopIdx0++) {
        if (inputA.a[1] == 1) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000e;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        } else {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10011;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        }
        for (int loopIdx1 = 0;;loopIdx1++,        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect()) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10015;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            if (subgroupElect()) {
                break;
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001a;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
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
layout(constant_id = 12) const uint cmpIndex2 = 0u;


void main()
[[subgroup_uniform_control_flow]]
{

    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10000;
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
    for (int loopIdx0 = 0;
             loopIdx0 < inputA.a[5];
             loopIdx0++) {
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10003;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        break;
        if (testBit(uvec4(0xf5200d72, 0xdc94acf1, 0x37427b06, 0x7b612795), gl_SubgroupInvocationID)) {
        }
    }
    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000a;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
    } else {
        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000f;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex2]) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10012;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        }
    }
    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10016;
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
    for (int loopIdx0 = 0;;loopIdx0++,    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect()) {
        {
            int loopIdx1 = 0;
            do {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001a;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                if (subgroupElect()) {
                    break;
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001f;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                loopIdx1++;
            } while (true);
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10022;
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
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002a;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                break;
            }
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002e;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        if (subgroupElect()) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10031;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            break;
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10035;
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


void main()
[[subgroup_uniform_control_flow]]
{

    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10000;
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
        for (int loopIdx0 = 0;
                 loopIdx0 < gl_SubgroupInvocationID + 1;
                 loopIdx0++) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10004;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        }
        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10008;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        } else {
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000c;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
    } else {
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000f;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
    }
    switch (gl_SubgroupInvocationID & 3) {
        case 0:
        {
            break;
        }
        case 1:
        {
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex2]) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10017;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            } else {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001a;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001d;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            break;
        }
        case 2:
        {
            break;
        }
        case 3:
        {
            {
                int loopIdx0 = 0;
                do {
                    if (subgroupElect()) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10025;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                        break;
                    }
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10029;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    loopIdx0++;
                } while (true);
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

    if (testBit(uvec4(0x5c279566, 0x5b0364e5, 0xab19e77b, 0xdf709dc4), gl_SubgroupInvocationID)) {
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10001;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10004;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        } else {
            if (subgroupElect()) {
            }
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000a;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000d;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        }
    }
    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10011;
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
    {
        int loopIdx0 = 0;
        do {
            for (int loopIdx1 = 0;;loopIdx1++,            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect()) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10015;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                switch (inputA.a[2]) {
                    case 3:
                    {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10019;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                        break;
                    }
                    case 2:
                    {
                        break;
                    }
                    case 4:
                    {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001f;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                        break;
                    }
                }
                if (subgroupElect()) {
                    break;
                }
                {
                    int loopIdx2 = 0;
                    do {
                        if (subgroupElect()) {
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10028;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                            if (testBit(uvec4(0x576a093a, 0xdca27a4d, 0x94bc142d, 0xd92b5ff1), gl_SubgroupInvocationID)) {
                                break;
                            } else {
                                break;
                            }
                        }
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10030;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                        loopIdx2++;
                    } while (true);
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10033;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                switch (inputA.a[4]) {
                    case 5:
                    {
                        break;
                    }
                    case 4:
                    {
                        break;
                    }
                    case 6:
                    {
                        break;
                    }
                }
            }
            if (subgroupElect()) {
                break;
            }
            if (testBit(uvec4(0xda273742, 0xbb2e665c, 0xbef28f40, 0xcbead8ea), gl_SubgroupInvocationID)) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10042;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                if (subgroupElect()) {
                }
            }
            if (subgroupElect()) {
                if (gl_SubgroupInvocationID == loopIdx0) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10049;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                } else {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1004c;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1004f;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                break;
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10052;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            }
            loopIdx0++;
        } while (true);
    }
    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10056;
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
            loopIdx0++;
            continue;
            if (testBit(uvec4(0x7a4e2690, 0x432fc58e, 0x9b2bb71a, 0xc785c163), gl_SubgroupInvocationID)) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10003;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                continue;
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10006;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                if (testBit(uvec4(0xec6f3c8, 0xdcaa4b2a, 0xcd523415, 0x8087be24), gl_SubgroupInvocationID)) {
                    continue;
                } else {
                    continue;
                }
            } else {
                if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000f;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                }
                switch (inputA.a[2]) {
                    case 3:
                    {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10014;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                        break;
                    }
                    case 2:
                    {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10018;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                        break;
                    }
                    case 4:
                    {
                        break;
                    }
                }
            }
        } while (loopIdx0 < inputA.a[3]);
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

    if (testBit(uvec4(0x1f082002, 0xf140f2fe, 0xb896a0de, 0x808a57d0), gl_SubgroupInvocationID)) {
        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10003;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            }
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex2]) {
            }
        } else {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10009;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            if (inputA.a[3] == 3) {
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000d;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10010;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        if (inputA.a[1] == 1) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10013;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            {
                int loopIdx0 = 0;
                do {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10016;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    if (subgroupElect()) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10019;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                        break;
                    }
                    loopIdx0++;
                } while (true);
            }
        } else {
            if (inputA.a[0] == 0) {
            } else {
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10022;
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


void main()
[[subgroup_uniform_control_flow]]
{

    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10000;
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
    switch (inputA.a[0]) {
        case 1:
        {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10004;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            break;
        }
        case 0:
        {
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
                for (int loopIdx0 = 0;
                         loopIdx0 < gl_SubgroupInvocationID + 1;
                         loopIdx0++) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000a;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                }
            } else {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000e;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                if (subgroupElect()) {
                }
            }
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
                if (gl_LocalInvocationIndex >= inputA.a[cmpIndex2]) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10015;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                } else {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10018;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                }
                if (inputA.a[1] == 1) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001c;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                } else {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001c;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                }
            }
            break;
        }
        case 2:
        {
            for (int loopIdx0 = 0;
                     loopIdx0 < inputA.a[2];
                     loopIdx0++) {
                if (inputA.a[3] == 3) {
                } else {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10028;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002b;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002e;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
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


void main()
[[subgroup_uniform_control_flow]]
{

    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10000;
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
        for (int loopIdx0 = 0;
                 loopIdx0 < inputA.a[2];
                 loopIdx0++) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10004;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            if (subgroupElect()) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10007;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            }
            if (subgroupElect()) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000b;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            }
        }
    } else {
        if (subgroupElect()) {
            if (subgroupElect()) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10012;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10015;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            switch (gl_SubgroupInvocationID & 3) {
                case 0:
                {
                    break;
                }
                case 1:
                {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001b;
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
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10021;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    break;
                }
            }
        }
        for (int loopIdx0 = 0;;loopIdx0++,        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect()) {
            if (inputA.a[0] == 0) {
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10029;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            if (subgroupElect()) {
                break;
            }
            for (int loopIdx1 = 0;;loopIdx1++,            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect()) {
                if (subgroupElect()) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10030;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    break;
                }
            }
            switch (loopIdx0) {
                case 1: {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10037;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    break;
                }
                case 2: {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1003b;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    break;
                }
                default: {
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


void main()
[[subgroup_uniform_control_flow]]
{

    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
        for (int loopIdx0 = 0;
                 loopIdx0 < gl_SubgroupInvocationID + 1;
                 loopIdx0++) {
            if (testBit(uvec4(0x2391070a, 0x7c9f6acd, 0x32b370b4, 0x107dbe47), gl_SubgroupInvocationID)) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10003;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            } else {
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10007;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            break;
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000a;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        }
    } else {
        for (int loopIdx0 = 0;
                 loopIdx0 < gl_SubgroupInvocationID + 1;
                 loopIdx0++) {
            if (testBit(uvec4(0x2391070a, 0x7c9f6acd, 0x32b370b4, 0x107dbe47), gl_SubgroupInvocationID)) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10003;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            } else {
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10007;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            break;
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000a;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        }
    }
    {
        int loopIdx0 = 0;
        do {
            loopIdx0++;
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001c;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
                {
                    int loopIdx1 = 0;
                    do {
                        loopIdx1++;
                    } while (loopIdx1 < inputA.a[4]);
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10021;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                if (inputA.a[3] == 3) {
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
            } else {
                for (int loopIdx1 = 0;
                         loopIdx1 < gl_SubgroupInvocationID + 1;
                         loopIdx1++) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002e;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                }
                if (testBit(uvec4(0xa1dd7c26, 0xdc8b0f06, 0x6342d0d2, 0x2f9c6461), gl_SubgroupInvocationID)) {
                    continue;
                } else {
                    continue;
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10036;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
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


void main()
[[subgroup_uniform_control_flow]]
{

    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10000;
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
    switch (gl_SubgroupInvocationID & 3) {
        case 0:
        case 1:
        {
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
                if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
                }
            }
            switch (gl_SubgroupInvocationID & 3) {
                case 0:
                case 1:
                {
                    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex2]) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000b;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    }
                    {
                        int loopIdx0 = 0;
                        do {
                            loopIdx0++;
                        } while (loopIdx0 < inputA.a[2]);
                    }
                    break;
                }
                case 2:
                case 3:
                {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10012;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    {
                        int loopIdx0 = 0;
                        do {
                            loopIdx0++;
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10015;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                        } while (loopIdx0 < inputA.a[4]);
                    }
                    break;
                }
            }
            break;
        }
        case 2:
        case 3:
        {
            if (subgroupElect()) {
                if (inputA.a[0] == 0) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001e;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                }
                if (testBit(uvec4(0x90a02a95, 0xc9aa12ee, 0x338888b3, 0x4ec35298), gl_SubgroupInvocationID)) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10022;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                } else {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10025;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10028;
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
layout(constant_id = 13) const uint cmpIndex3 = 0u;


void main()
[[subgroup_uniform_control_flow]]
{

    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10000;
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
        for (int loopIdx0 = 0;
                 loopIdx0 < gl_SubgroupInvocationID + 1;
                 loopIdx0++) {
            break;
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10005;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            if (gl_SubgroupInvocationID == loopIdx0) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10008;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            } else {
            }
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000d;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
    }
    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10010;
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10013;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
    } else {
        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex2]) {
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex3]) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10018;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            }
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


void main()
[[subgroup_uniform_control_flow]]
{

    {
        int loopIdx0 = 0;
        do {
            loopIdx0++;
            continue;
            if (testBit(uvec4(0x7a4e2690, 0x432fc58e, 0x9b2bb71a, 0xc785c163), gl_SubgroupInvocationID)) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10003;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                continue;
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10006;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                if (testBit(uvec4(0xec6f3c8, 0xdcaa4b2a, 0xcd523415, 0x8087be24), gl_SubgroupInvocationID)) {
                    continue;
                } else {
                    continue;
                }
            } else {
                if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
                    if (inputA.a[2] == 2) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10010;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    }
                    {
                        int loopIdx1 = 0;
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
                            loopIdx1++;
                        } while (true);
                    }
                } else {
                    for (int loopIdx1 = 0;;loopIdx1++,                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect()) {
                        if (subgroupElect()) {
                            break;
                        }
                    }
                    return;
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10024;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                if (subgroupElect()) {
                    for (int loopIdx1 = 0;
                             loopIdx1 < inputA.a[2];
                             loopIdx1++) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10028;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    }
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002b;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    switch (inputA.a[4]) {
                        case 5:
                        {
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002f;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                            break;
                        }
                        case 4:
                        {
                            break;
                        }
                        case 6:
                        {
                            break;
                        }
                    }
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10037;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1003a;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            }
        } while (loopIdx0 < inputA.a[3]);
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


void main()
[[subgroup_uniform_control_flow]]
{

    if (testBit(uvec4(0x1f082002, 0xf140f2fe, 0xb896a0de, 0x808a57d0), gl_SubgroupInvocationID)) {
        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
                {
                    int loopIdx0 = 0;
                    do {
                        loopIdx0++;
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10004;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    } while (loopIdx0 < inputA.a[4]);
                }
                if (testBit(uvec4(0x1f082002, 0xf140f2fe, 0xb896a0de, 0x808a57d0), gl_SubgroupInvocationID)) {
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
            } else {
                if (testBit(uvec4(0x20acbc5e, 0x3ac93720, 0xc31450d5, 0xdfc2e34e), gl_SubgroupInvocationID)) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10012;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                } else {
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
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex3]) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10023;
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
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10029;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                        break;
                    }
                }
                {
                    int loopIdx0 = 0;
                    do {
                        if (subgroupElect()) {
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002f;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                            break;
                        }
                        loopIdx0++;
                    } while (true);
                }
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
                        break;
                    }
                    case 3:
                    {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1003d;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                        break;
                    }
                }
                if (inputA.a[2] == 2) {
                }
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10044;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        }
        if (inputA.a[1] == 1) {
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex4]) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10049;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
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
                if (inputA.a[2] == 2) {
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10059;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1005c;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex5]) {
                for (int loopIdx0 = 0;
                         loopIdx0 < gl_SubgroupInvocationID + 1;
                         loopIdx0++) {
                }
                if (testBit(uvec4(0x20acbc5e, 0x3ac93720, 0xc31450d5, 0xdfc2e34e), gl_SubgroupInvocationID)) {
                } else {
                }
            } else {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10065;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                if (gl_LocalInvocationIndex >= inputA.a[cmpIndex6]) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10068;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                } else {
                }
            }
        }
    } else {
        for (int loopIdx0 = 0;
                 loopIdx0 < inputA.a[1];
                 loopIdx0++) {
            if (testBit(uvec4(0x20acbc5e, 0x3ac93720, 0xc31450d5, 0xdfc2e34e), gl_SubgroupInvocationID)) {
                if (inputA.a[1] == 1) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10072;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                } else {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10075;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                }
                if (subgroupElect()) {
                }
            } else {
                if (inputA.a[2] == 2) {
                }
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1007e;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            for (int loopIdx1 = 0;
                     loopIdx1 < gl_SubgroupInvocationID + 1;
                     loopIdx1++) {
                if (inputA.a[3] == 3) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10082;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                } else {
                }
                switch (gl_SubgroupInvocationID & 3) {
                    case 0:
                    {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10088;
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
            }
        }
        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex7]) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10095;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        } else {
            if (testBit(uvec4(0x1f082002, 0xf140f2fe, 0xb896a0de, 0x808a57d0), gl_SubgroupInvocationID)) {
                if (gl_LocalInvocationIndex >= inputA.a[cmpIndex8]) {
                }
                if (gl_LocalInvocationIndex >= inputA.a[cmpIndex9]) {
                } else {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1009d;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x100a0;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            }
            {
                int loopIdx0 = 0;
                do {
                    loopIdx0++;
                    {
                        int loopIdx1 = 0;
                        do {
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x100a5;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                            if (subgroupElect()) {
                                outputC.loc[gl_LocalInvocationIndex]++;
                                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x100a8;
                                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                                break;
                            }
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x100ac;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                            loopIdx1++;
                        } while (true);
                    }
                } while (loopIdx0 < inputA.a[3]);
            }
        }
    }
    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x100b2;
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
layout(constant_id = 17) const uint cmpIndex7 = 0u;


void main()
[[subgroup_uniform_control_flow]]
{

    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10000;
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
    switch (inputA.a[0]) {
        case 1:
        {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10004;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            break;
        }
        case 0:
        {
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
                for (int loopIdx0 = 0;
                         loopIdx0 < gl_SubgroupInvocationID + 1;
                         loopIdx0++) {
                    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000b;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    } else {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000e;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    }
                }
                if (inputA.a[0] == 0) {
                    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex2]) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10014;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    } else {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10017;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    }
                    if (testBit(uvec4(0xa6844fcd, 0xd7def1a2, 0x355598c3, 0xc483030c), gl_SubgroupInvocationID)) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001b;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    }
                } else {
                    for (int loopIdx0 = 0;;loopIdx0++,                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect()) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10020;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                        if (subgroupElect()) {
                            break;
                        }
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10025;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    }
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10028;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                }
            } else {
                if (subgroupElect()) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002d;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex3]) {
                    }
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10032;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                if (subgroupElect()) {
                    switch (inputA.a[4]) {
                        case 5:
                        {
                            break;
                        }
                        case 4:
                        {
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10039;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                            break;
                        }
                        case 6:
                        {
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1003d;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                            break;
                        }
                    }
                }
            }
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex4]) {
                if (subgroupElect()) {
                    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex5]) {
                    } else {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10047;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    }
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1004a;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex6]) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1004d;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    } else {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1004d;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    }
                }
                {
                    int loopIdx0 = 0;
                    do {
                        loopIdx0++;
                        if (testBit(uvec4(0xa6844fcd, 0xd7def1a2, 0x355598c3, 0xc483030c), gl_SubgroupInvocationID)) {
                        } else {
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10057;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                        }
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1005a;
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
                                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10060;
                                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                                break;
                            }
                        }
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10064;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    } while (loopIdx0 < inputA.a[1]);
                }
            } else {
                switch (inputA.a[2]) {
                    case 3:
                    {
                        break;
                    }
                    case 2:
                    {
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
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10072;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                        {
                            int loopIdx0 = 0;
                            do {
                                if (subgroupElect()) {
                                    break;
                                }
                                outputC.loc[gl_LocalInvocationIndex]++;
                                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10078;
                                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                                loopIdx0++;
                            } while (true);
                        }
                        break;
                    }
                    case 4:
                    {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1007d;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                        break;
                    }
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10081;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            }
            break;
        }
        case 2:
        {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10086;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            if (subgroupElect()) {
                if (inputA.a[1] == 1) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1008a;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex7]) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1008d;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    } else {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10090;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    }
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10094;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                for (int loopIdx0 = 0;
                         loopIdx0 < gl_SubgroupInvocationID + 1;
                         loopIdx0++) {
                    {
                        int loopIdx1 = 0;
                        do {
                            if (subgroupElect()) {
                                break;
                            }
                            loopIdx1++;
                        } while (true);
                    }
                    if (gl_SubgroupInvocationID == loopIdx0) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1009d;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    }
                }
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x100a2;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
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
layout(constant_id = 13) const uint cmpIndex3 = 0u;
layout(constant_id = 14) const uint cmpIndex4 = 0u;


void main()
[[subgroup_uniform_control_flow]]
{

    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10000;
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
        return;
        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
            if (testBit(uvec4(0xa4b4530d, 0x37ae9ec4, 0xee17c242, 0x339316d9), gl_SubgroupInvocationID)) {
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10007;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex2]) {
                {
                    int loopIdx0 = 0;
                    do {
                        if (subgroupElect()) {
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000c;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                            break;
                        }
                        loopIdx0++;
                    } while (true);
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10011;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            }
        }
    }
    {
        int loopIdx0 = 0;
        do {
            loopIdx0++;
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10017;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            if (subgroupElect()) {
                if (gl_LocalInvocationIndex >= inputA.a[cmpIndex3]) {
                    if (testBit(uvec4(0xab263b6d, 0xad0c39fa, 0x50fd028b, 0xa8d50e), gl_SubgroupInvocationID)) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001c;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    } else {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001f;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    }
                }
                if (gl_LocalInvocationIndex >= inputA.a[cmpIndex4]) {
                    if (inputA.a[1] == 1) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10025;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    }
                    if (subgroupElect()) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10029;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    }
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002c;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                } else {
                    if (inputA.a[2] == 2) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10025;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    }
                    if (subgroupElect()) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10029;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    }
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002c;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                }
            }
            if (gl_SubgroupInvocationID == loopIdx0) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1003c;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                if (testBit(uvec4(0xab263b6d, 0xad0c39fa, 0x50fd028b, 0xa8d50e), gl_SubgroupInvocationID)) {
                    switch (inputA.a[1]) {
                        case 2:
                        {
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10041;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                            break;
                        }
                        case 1:
                        {
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10045;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                            break;
                        }
                        case 3:
                        {
                            break;
                        }
                    }
                    break;
                } else {
                    for (int loopIdx1 = 0;
                             loopIdx1 < gl_SubgroupInvocationID + 1;
                             loopIdx1++) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1004e;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    }
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10051;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                }
                {
                    int loopIdx1 = 0;
                    do {
                        loopIdx1++;
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10055;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                        {
                            int loopIdx2 = 0;
                            do {
                                loopIdx2++;
                            } while (loopIdx2 < inputA.a[2]);
                        }
                    } while (loopIdx1 < inputA.a[5]);
                }
            }
        } while (loopIdx0 < inputA.a[4]);
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


void main()
[[subgroup_uniform_control_flow]]
{

    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10000;
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
        for (int loopIdx0 = 0;
                 loopIdx0 < inputA.a[2];
                 loopIdx0++) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10004;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            if (subgroupElect()) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10007;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                continue;
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000b;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            switch (gl_SubgroupInvocationID & 3) {
                case 0:
                {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000f;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    for (int loopIdx1 = 0;;loopIdx1++,                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect()) {
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
                    break;
                }
                case 1:
                {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001c;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001f;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    } else {
                    }
                    break;
                }
                case 2:
                {
                    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex2]) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10026;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    } else {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10029;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    }
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002c;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    break;
                }
                case 3:
                {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10030;
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
                }
            }
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1003f;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        switch (gl_SubgroupInvocationID & 3) {
            case 0:
            {
                for (int loopIdx0 = 0;
                         loopIdx0 < inputA.a[5];
                         loopIdx0++) {
                    if (inputA.a[1] == 1) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10045;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    }
                }
                break;
            }
            case 1:
            {
                if (subgroupElect()) {
                    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex3]) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1004d;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    } else {
                    }
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10051;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex4]) {
                    }
                }
                break;
            }
            case 2:
            {
                if (inputA.a[2] == 2) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10059;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex5]) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1005c;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    } else {
                    }
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10060;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex6]) {
                    }
                }
                break;
            }
            case 3:
            {
                if (testBit(uvec4(0xf9c83953, 0xdc833ee1, 0x3b114bed, 0x77893a04), gl_SubgroupInvocationID)) {
                    if (testBit(uvec4(0x461ab27e, 0xfea00e58, 0xc9829b62, 0x787df9a3), gl_SubgroupInvocationID)) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10069;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    } else {
                    }
                    {
                        int loopIdx0 = 0;
                        do {
                            if (subgroupElect()) {
                                outputC.loc[gl_LocalInvocationIndex]++;
                                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1006f;
                                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                                break;
                            }
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10073;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                            loopIdx0++;
                        } while (true);
                    }
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10076;
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
layout(constant_id = 12) const uint cmpIndex2 = 0u;
layout(constant_id = 13) const uint cmpIndex3 = 0u;
layout(constant_id = 14) const uint cmpIndex4 = 0u;
layout(constant_id = 15) const uint cmpIndex5 = 0u;
layout(constant_id = 16) const uint cmpIndex6 = 0u;
layout(constant_id = 17) const uint cmpIndex7 = 0u;


void main()
[[subgroup_uniform_control_flow]]
{

    if (testBit(uvec4(0xed6a2561, 0x5b7f8905, 0x1467e57d, 0x96b378c), gl_SubgroupInvocationID)) {
        switch (gl_SubgroupInvocationID & 3) {
            case 0:
            case 1:
            {
                if (inputA.a[3] == 3) {
                    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10005;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    } else {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10008;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    }
                    if (testBit(uvec4(0xed6a2561, 0x5b7f8905, 0x1467e57d, 0x96b378c), gl_SubgroupInvocationID)) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000c;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    } else {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000c;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    }
                } else {
                    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10005;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    } else {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10008;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    }
                    if (testBit(uvec4(0xed6a2561, 0x5b7f8905, 0x1467e57d, 0x96b378c), gl_SubgroupInvocationID)) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000c;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    } else {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000c;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    }
                }
                if (gl_LocalInvocationIndex >= inputA.a[cmpIndex2]) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10023;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex3]) {
                    }
                }
                break;
            }
            case 2:
            case 3:
            {
                for (int loopIdx0 = 0;
                         loopIdx0 < inputA.a[5];
                         loopIdx0++) {
                    if (inputA.a[0] == 0) {
                    }
                    if (gl_SubgroupInvocationID == loopIdx0) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002e;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    } else {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10031;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    }
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10035;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                if (inputA.a[0] == 0) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10038;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1003b;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                break;
            }
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1003f;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
    } else {
        switch (gl_SubgroupInvocationID & 3) {
            case 0:
            case 1:
            {
                if (inputA.a[3] == 3) {
                    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex4]) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10005;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    } else {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10008;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    }
                    if (testBit(uvec4(0xed6a2561, 0x5b7f8905, 0x1467e57d, 0x96b378c), gl_SubgroupInvocationID)) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000c;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    } else {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000c;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    }
                } else {
                    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex5]) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10005;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    } else {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10008;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    }
                    if (testBit(uvec4(0xed6a2561, 0x5b7f8905, 0x1467e57d, 0x96b378c), gl_SubgroupInvocationID)) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000c;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    } else {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000c;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    }
                }
                if (gl_LocalInvocationIndex >= inputA.a[cmpIndex6]) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10023;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex7]) {
                    }
                }
                break;
            }
            case 2:
            case 3:
            {
                for (int loopIdx0 = 0;
                         loopIdx0 < inputA.a[5];
                         loopIdx0++) {
                    if (inputA.a[0] == 0) {
                    }
                    if (gl_SubgroupInvocationID == loopIdx0) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002e;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    } else {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10031;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    }
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10035;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                if (inputA.a[2] == 2) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10038;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1003b;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                break;
            }
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1003f;
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

    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
        for (int loopIdx0 = 0;
                 loopIdx0 < gl_SubgroupInvocationID + 1;
                 loopIdx0++) {
            if (testBit(uvec4(0x2391070a, 0x7c9f6acd, 0x32b370b4, 0x107dbe47), gl_SubgroupInvocationID)) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10003;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
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
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000d;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            } else {
                if (gl_SubgroupInvocationID == loopIdx0) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10011;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                } else {
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10015;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                break;
            }
            for (int loopIdx1 = 0;;loopIdx1++,            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect()) {
                switch (loopIdx0) {
                    case 1: {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001c;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                        break;
                    }
                    case 2: {
                        break;
                    }
                    default: {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10022;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                        break;
                    }
                }
                if (testBit(uvec4(0xa1dd7c26, 0xdc8b0f06, 0x6342d0d2, 0x2f9c6461), gl_SubgroupInvocationID)) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10027;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                }
                if (subgroupElect()) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002b;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    break;
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002f;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                if (testBit(uvec4(0xed6a2561, 0x5b7f8905, 0x1467e57d, 0x96b378c), gl_SubgroupInvocationID)) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10032;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                }
                if (inputA.a[1] == 1) {
                }
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
layout(constant_id = 10) const uint cmpIndex0 = 0u;
layout(constant_id = 11) const uint cmpIndex1 = 0u;
layout(constant_id = 12) const uint cmpIndex2 = 0u;
layout(constant_id = 13) const uint cmpIndex3 = 0u;
layout(constant_id = 14) const uint cmpIndex4 = 0u;
layout(constant_id = 15) const uint cmpIndex5 = 0u;


void main()
[[subgroup_uniform_control_flow]]
{

    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10000;
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
    switch (gl_SubgroupInvocationID & 3) {
        case 0:
        case 1:
        {
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
                if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
                    if (inputA.a[3] == 3) {
                    }
                    {
                        int loopIdx0 = 0;
                        do {
                            if (subgroupElect()) {
                                outputC.loc[gl_LocalInvocationIndex]++;
                                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000a;
                                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                                break;
                            }
                            loopIdx0++;
                        } while (true);
                    }
                }
            }
            switch (inputA.a[3]) {
                case 4:
                {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10013;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    if (subgroupElect()) {
                        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex2]) {
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10017;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                        } else {
                        }
                    }
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001c;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    break;
                }
                case 3:
                {
                    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex3]) {
                        for (int loopIdx0 = 0;
                                 loopIdx0 < gl_SubgroupInvocationID + 1;
                                 loopIdx0++) {
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10022;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                        }
                    } else {
                        switch (gl_SubgroupInvocationID & 3) {
                            case 0:
                            case 1:
                            {
                                outputC.loc[gl_LocalInvocationIndex]++;
                                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10028;
                                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                                break;
                            }
                            case 2:
                            case 3:
                            {
                                outputC.loc[gl_LocalInvocationIndex]++;
                                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002c;
                                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                                break;
                            }
                        }
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10030;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex4]) {
                        } else {
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10034;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                        }
                    }
                    {
                        int loopIdx0 = 0;
                        do {
                            loopIdx0++;
                            if (subgroupElect()) {
                            }
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1003b;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                            break;
                        } while (loopIdx0 < inputA.a[3]);
                    }
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1003f;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    break;
                }
                case 5:
                {
                    if (inputA.a[2] == 2) {
                        if (testBit(uvec4(0x90a02a95, 0xc9aa12ee, 0x338888b3, 0x4ec35298), gl_SubgroupInvocationID)) {
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10045;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                        }
                        {
                            int loopIdx0 = 0;
                            do {
                                loopIdx0++;
                                outputC.loc[gl_LocalInvocationIndex]++;
                                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10049;
                                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                            } while (loopIdx0 < inputA.a[1]);
                        }
                    } else {
                        if (inputA.a[3] == 3) {
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1004e;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                        } else {
                        }
                    }
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10053;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    break;
                }
            }
            break;
        }
        case 2:
        case 3:
        {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10059;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            if (testBit(uvec4(0x987d2de, 0x211b278, 0xf3463852, 0x94df3666), gl_SubgroupInvocationID)) {
                for (int loopIdx0 = 0;;loopIdx0++,                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect()) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1005d;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    {
                        int loopIdx1 = 0;
                        do {
                            if (subgroupElect()) {
                                outputC.loc[gl_LocalInvocationIndex]++;
                                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10061;
                                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                                break;
                            }
                            loopIdx1++;
                        } while (true);
                    }
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10066;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    if (subgroupElect()) {
                    }
                    if (subgroupElect()) {
                        break;
                    }
                    if (inputA.a[1] == 1) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1006e;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    }
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10071;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    for (int loopIdx1 = 0;
                             loopIdx1 < gl_SubgroupInvocationID + 1;
                             loopIdx1++) {
                    }
                }
            }
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex5]) {
                for (int loopIdx0 = 0;;loopIdx0++,                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect()) {
                    if (gl_SubgroupInvocationID == loopIdx0) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1007a;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    }
                    if (subgroupElect()) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1007e;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                        break;
                    }
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10082;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    for (int loopIdx1 = 0;
                             loopIdx1 < gl_SubgroupInvocationID + 1;
                             loopIdx1++) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10085;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    }
                }
                for (int loopIdx0 = 0;
                         loopIdx0 < gl_SubgroupInvocationID + 1;
                         loopIdx0++) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1008a;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    if (testBit(uvec4(0x4dc2923c, 0xdc935c2f, 0x8f9e5516, 0xc383a7ce), gl_SubgroupInvocationID)) {
                        continue;
                    } else {
                        continue;
                    }
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10091;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    if (subgroupElect()) {
                    }
                }
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10097;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
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

    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10000;
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
        for (int loopIdx0 = 0;
                 loopIdx0 < gl_SubgroupInvocationID + 1;
                 loopIdx0++) {
            break;
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10005;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            if (gl_SubgroupInvocationID == loopIdx0) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10008;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                {
                    int loopIdx1 = 0;
                    do {
                        loopIdx1++;
                    } while (loopIdx1 < inputA.a[1]);
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000c;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000f;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                } else {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10012;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                }
            } else {
                break;
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10017;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
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


void main()
[[subgroup_uniform_control_flow]]
{

    switch (inputA.a[2]) {
        case 3:
        {
            break;
        }
        case 2:
        {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10004;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            if (testBit(uvec4(0x5c279566, 0x5b0364e5, 0xab19e77b, 0xdf709dc4), gl_SubgroupInvocationID)) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10007;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            } else {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000a;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            }
            {
                int loopIdx0 = 0;
                do {
                    if (subgroupElect()) {
                        break;
                    }
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10011;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    loopIdx0++;
                } while (true);
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10014;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            break;
        }
        case 4:
        {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10018;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001b;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            } else {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001e;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            }
            break;
        }
    }
    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10023;
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

    if (testBit(uvec4(0x5c279566, 0x5b0364e5, 0xab19e77b, 0xdf709dc4), gl_SubgroupInvocationID)) {
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10001;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
        } else {
        }
    }
    if (testBit(uvec4(0xda273742, 0xbb2e665c, 0xbef28f40, 0xcbead8ea), gl_SubgroupInvocationID)) {
        if (subgroupElect()) {
        }
        if (inputA.a[0] == 0) {
        }
    }
    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000d;
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
    for (int loopIdx0 = 0;
             loopIdx0 < gl_SubgroupInvocationID + 1;
             loopIdx0++) {
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10010;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        break;
        continue;
    }
    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10015;
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
        if (subgroupElect()) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10019;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001c;
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
            continue;
            if (testBit(uvec4(0x7a4e2690, 0x432fc58e, 0x9b2bb71a, 0xc785c163), gl_SubgroupInvocationID)) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10003;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            } else {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10003;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            }
        } while (loopIdx0 < inputA.a[3]);
    }
    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000c;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        } else {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000f;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        }
    } else {
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10013;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        switch (gl_SubgroupInvocationID & 3) {
            case 0:
            case 1:
            {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10017;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                break;
            }
            case 2:
            case 3:
            {
                break;
            }
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
layout(constant_id = 12) const uint cmpIndex2 = 0u;
layout(constant_id = 13) const uint cmpIndex3 = 0u;


void main()
[[subgroup_uniform_control_flow]]
{

    if (testBit(uvec4(0x1f082002, 0xf140f2fe, 0xb896a0de, 0x808a57d0), gl_SubgroupInvocationID)) {
        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
        } else {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10003;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        }
        for (int loopIdx0 = 0;;loopIdx0++,        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true)) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10007;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            if (subgroupElect()) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000a;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                break;
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000e;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10011;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
    }
    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex2]) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10016;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        } else {
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001a;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
    } else {
        if (testBit(uvec4(0x24be39e6, 0xdcb39833, 0xe7e59864, 0xaaff4173), gl_SubgroupInvocationID)) {
        } else {
        }
        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex3]) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10021;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        } else {
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
    switch (inputA.a[0]) {
        case 1:
        {
            if (testBit(uvec4(0x20acbc5e, 0x3ac93720, 0xc31450d5, 0xdfc2e34e), gl_SubgroupInvocationID)) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10005;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            } else {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10008;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            }
            break;
        }
        case 0:
        {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000d;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            if (subgroupElect()) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10010;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            }
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10014;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            }
            break;
        }
        case 2:
        {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10019;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            {
                int loopIdx0 = 0;
                do {
                    loopIdx0++;
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001c;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                } while (loopIdx0 < inputA.a[1]);
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001f;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
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


void main()
[[subgroup_uniform_control_flow]]
{

    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10000;
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
    switch (inputA.a[0]) {
        case 1:
        {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10004;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            break;
        }
        case 0:
        {
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10009;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000c;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            break;
        }
        case 2:
        {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10010;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            {
                int loopIdx0 = 0;
                do {
                    loopIdx0++;
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10013;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                } while (loopIdx0 < inputA.a[5]);
            }
            break;
        }
    }
    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10018;
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
    if (testBit(uvec4(0xeb93571b, 0xd23ee0a9, 0xf2c07cfb, 0x8c5d2c), gl_SubgroupInvocationID)) {
        if (subgroupElect()) {
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001d;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        switch (inputA.a[2]) {
            case 3:
            {
                break;
            }
            case 2:
            {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10023;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                break;
            }
            case 4:
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
layout(local_size_x_id = 0, local_size_y_id = 1, local_size_z = 1) in;
layout(set=0, binding=2) coherent buffer OutputC { uint loc[]; } outputC;
layout(set=0, binding=1) coherent buffer OutputB { uvec4 b[]; } outputB;
layout(set=0, binding=0) coherent buffer InputA  { uint  a[]; } inputA;
layout(push_constant) uniform PC {
   // set to the real stride when writing out ballots, or zero when just counting
   int  invocationStride;
   // wildcard fields, for an example the dimensions of rendered area in the case of graphics shaders
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
        for (int loopIdx0 = 0;
                 loopIdx0 < gl_SubgroupInvocationID + 1;
                 loopIdx0++) {
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10005;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10008;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000b;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
    } else {
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000e;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
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
        if (subgroupElect()) {
        }
    }
    switch (gl_SubgroupInvocationID & 3) {
        case 0:
        case 1:
        {
            for (int loopIdx0 = 0;
                     loopIdx0 < inputA.a[3];
                     loopIdx0++) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10020;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10023;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            if (subgroupElect()) {
            }
            break;
        }
        case 2:
        case 3:
        {
            {
                int loopIdx0 = 0;
                do {
                    if (subgroupElect()) {
                        break;
                    }
                    loopIdx0++;
                } while (true);
            }
            if (inputA.a[3] == 3) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002f;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            } else {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10032;
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


void main()
[[subgroup_uniform_control_flow]]
{

    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10000;
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
        for (int loopIdx0 = 0;
                 loopIdx0 < inputA.a[2];
                 loopIdx0++) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10004;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        }
        {
            int loopIdx0 = 0;
            do {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10008;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                if (subgroupElect()) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000b;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    if (testBit(uvec4(0xf9c83953, 0xdc833ee1, 0x3b114bed, 0x77893a04), gl_SubgroupInvocationID)) {
                        break;
                    } else {
                        break;
                    }
                }
                loopIdx0++;
            } while (true);
        }
    } else {
        switch (gl_SubgroupInvocationID & 3) {
            case 0:
            case 1:
            {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10017;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                break;
            }
            case 2:
            case 3:
            {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001b;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                break;
            }
        }
        for (int loopIdx0 = 0;;loopIdx0++,        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true)) {
            if (subgroupElect()) {
                break;
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10023;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10026;
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
        for (int loopIdx0 = 0;
                 loopIdx0 < gl_SubgroupInvocationID + 1;
                 loopIdx0++) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10002;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        }
    }
    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10006;
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
    if (testBit(uvec4(0x2391070a, 0x7c9f6acd, 0x32b370b4, 0x107dbe47), gl_SubgroupInvocationID)) {
        if (testBit(uvec4(0xa1dd7c26, 0xdc8b0f06, 0x6342d0d2, 0x2f9c6461), gl_SubgroupInvocationID)) {
        } else {
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000c;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
    }
    if (testBit(uvec4(0xed6a2561, 0x5b7f8905, 0x1467e57d, 0x96b378c), gl_SubgroupInvocationID)) {
        if (inputA.a[2] == 2) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10011;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        } else {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10014;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        }
    } else {
        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
        } else {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001a;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        }
        for (int loopIdx0 = 0;
                 loopIdx0 < gl_SubgroupInvocationID + 1;
                 loopIdx0++) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001e;
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


void main()
[[subgroup_uniform_control_flow]]
{

    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10000;
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
    switch (gl_SubgroupInvocationID & 3) {
        case 0:
        case 1:
        {
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
            }
            {
                int loopIdx0 = 0;
                do {
                    loopIdx0++;
                } while (loopIdx0 < inputA.a[3]);
            }
            break;
        }
        case 2:
        case 3:
        {
            if (inputA.a[0] == 0) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000b;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            }
            for (int loopIdx0 = 0;
                     loopIdx0 < inputA.a[3];
                     loopIdx0++) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000f;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            }
            break;
        }
    }
    switch (inputA.a[3]) {
        case 4:
        {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10016;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            if (subgroupElect()) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10019;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            }
            break;
        }
        case 3:
        {
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001f;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10022;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            break;
        }
        case 5:
        {
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex2]) {
            } else {
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

    for (int loopIdx0 = 0;
             loopIdx0 < inputA.a[3];
             loopIdx0++) {
        if (inputA.a[2] == 2) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10002;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10005;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        if (subgroupElect()) {
        }
    }
    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000a;
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
    for (int loopIdx0 = 0;
             loopIdx0 < inputA.a[1];
             loopIdx0++) {
        if (inputA.a[1] == 1) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000e;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        } else {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10011;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        }
        for (int loopIdx1 = 0;;loopIdx1++,        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true)) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10015;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            if (subgroupElect()) {
                break;
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001a;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
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
layout(constant_id = 12) const uint cmpIndex2 = 0u;


void main()
[[subgroup_uniform_control_flow]]
{

    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10000;
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
    for (int loopIdx0 = 0;
             loopIdx0 < inputA.a[5];
             loopIdx0++) {
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10003;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        break;
        if (testBit(uvec4(0xf5200d72, 0xdc94acf1, 0x37427b06, 0x7b612795), gl_SubgroupInvocationID)) {
        }
    }
    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000a;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
    } else {
        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000f;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex2]) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10012;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        }
    }
    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10016;
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
    for (int loopIdx0 = 0;;loopIdx0++,    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true)) {
        {
            int loopIdx1 = 0;
            do {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001a;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                if (subgroupElect()) {
                    break;
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001f;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                loopIdx1++;
            } while (true);
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10022;
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
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002a;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                break;
            }
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002e;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        if (subgroupElect()) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10031;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            break;
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10035;
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


void main()
[[subgroup_uniform_control_flow]]
{

    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10000;
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
        for (int loopIdx0 = 0;
                 loopIdx0 < gl_SubgroupInvocationID + 1;
                 loopIdx0++) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10004;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        }
        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10008;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        } else {
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000c;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
    } else {
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000f;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
    }
    switch (gl_SubgroupInvocationID & 3) {
        case 0:
        {
            break;
        }
        case 1:
        {
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex2]) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10017;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            } else {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001a;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            }
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
            {
                int loopIdx0 = 0;
                do {
                    if (subgroupElect()) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10025;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        break;
                    }
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10029;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    loopIdx0++;
                } while (true);
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

    if (testBit(uvec4(0x5c279566, 0x5b0364e5, 0xab19e77b, 0xdf709dc4), gl_SubgroupInvocationID)) {
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10001;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10004;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        } else {
            if (subgroupElect()) {
            }
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000a;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000d;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        }
    }
    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10011;
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
    {
        int loopIdx0 = 0;
        do {
            for (int loopIdx1 = 0;;loopIdx1++,            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true)) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10015;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                switch (inputA.a[2]) {
                    case 3:
                    {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10019;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        break;
                    }
                    case 2:
                    {
                        break;
                    }
                    case 4:
                    {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001f;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        break;
                    }
                }
                if (subgroupElect()) {
                    break;
                }
                {
                    int loopIdx2 = 0;
                    do {
                        if (subgroupElect()) {
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10028;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                            if (testBit(uvec4(0x576a093a, 0xdca27a4d, 0x94bc142d, 0xd92b5ff1), gl_SubgroupInvocationID)) {
                                break;
                            } else {
                                break;
                            }
                        }
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10030;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        loopIdx2++;
                    } while (true);
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10033;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                switch (inputA.a[4]) {
                    case 5:
                    {
                        break;
                    }
                    case 4:
                    {
                        break;
                    }
                    case 6:
                    {
                        break;
                    }
                }
            }
            if (subgroupElect()) {
                break;
            }
            if (testBit(uvec4(0xda273742, 0xbb2e665c, 0xbef28f40, 0xcbead8ea), gl_SubgroupInvocationID)) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10042;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                if (subgroupElect()) {
                }
            }
            if (subgroupElect()) {
                if (gl_SubgroupInvocationID == loopIdx0) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10049;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                } else {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1004c;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1004f;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                break;
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10052;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            }
            loopIdx0++;
        } while (true);
    }
    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10056;
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
            loopIdx0++;
            continue;
            if (testBit(uvec4(0x7a4e2690, 0x432fc58e, 0x9b2bb71a, 0xc785c163), gl_SubgroupInvocationID)) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10003;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                continue;
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10006;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                if (testBit(uvec4(0xec6f3c8, 0xdcaa4b2a, 0xcd523415, 0x8087be24), gl_SubgroupInvocationID)) {
                    continue;
                } else {
                    continue;
                }
            } else {
                if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000f;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
                switch (inputA.a[2]) {
                    case 3:
                    {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10014;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        break;
                    }
                    case 2:
                    {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10018;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        break;
                    }
                    case 4:
                    {
                        break;
                    }
                }
            }
        } while (loopIdx0 < inputA.a[3]);
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

    if (testBit(uvec4(0x1f082002, 0xf140f2fe, 0xb896a0de, 0x808a57d0), gl_SubgroupInvocationID)) {
        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10003;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            }
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex2]) {
            }
        } else {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10009;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            if (inputA.a[3] == 3) {
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000d;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10010;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        if (inputA.a[1] == 1) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10013;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            {
                int loopIdx0 = 0;
                do {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10016;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    if (subgroupElect()) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10019;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        break;
                    }
                    loopIdx0++;
                } while (true);
            }
        } else {
            if (inputA.a[0] == 0) {
            } else {
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10022;
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


void main()
[[subgroup_uniform_control_flow]]
{

    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10000;
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
    switch (inputA.a[0]) {
        case 1:
        {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10004;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            break;
        }
        case 0:
        {
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
                for (int loopIdx0 = 0;
                         loopIdx0 < gl_SubgroupInvocationID + 1;
                         loopIdx0++) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000a;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
            } else {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000e;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                if (subgroupElect()) {
                }
            }
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
                if (gl_LocalInvocationIndex >= inputA.a[cmpIndex2]) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10015;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                } else {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10018;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
                if (inputA.a[1] == 1) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001c;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                } else {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001c;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
            }
            break;
        }
        case 2:
        {
            for (int loopIdx0 = 0;
                     loopIdx0 < inputA.a[2];
                     loopIdx0++) {
                if (inputA.a[3] == 3) {
                } else {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10028;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002b;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002e;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
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


void main()
[[subgroup_uniform_control_flow]]
{

    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10000;
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
        for (int loopIdx0 = 0;
                 loopIdx0 < inputA.a[2];
                 loopIdx0++) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10004;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            if (subgroupElect()) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10007;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            }
            if (subgroupElect()) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000b;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            }
        }
    } else {
        if (subgroupElect()) {
            if (subgroupElect()) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10012;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10015;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            switch (gl_SubgroupInvocationID & 3) {
                case 0:
                {
                    break;
                }
                case 1:
                {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001b;
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
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10021;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    break;
                }
            }
        }
        for (int loopIdx0 = 0;;loopIdx0++,        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true)) {
            if (inputA.a[0] == 0) {
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10029;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            if (subgroupElect()) {
                break;
            }
            for (int loopIdx1 = 0;;loopIdx1++,            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true)) {
                if (subgroupElect()) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10030;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    break;
                }
            }
            switch (loopIdx0) {
                case 1: {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10037;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    break;
                }
                case 2: {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1003b;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    break;
                }
                default: {
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


void main()
[[subgroup_uniform_control_flow]]
{

    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
        for (int loopIdx0 = 0;
                 loopIdx0 < gl_SubgroupInvocationID + 1;
                 loopIdx0++) {
            if (testBit(uvec4(0x2391070a, 0x7c9f6acd, 0x32b370b4, 0x107dbe47), gl_SubgroupInvocationID)) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10003;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            } else {
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10007;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            break;
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000a;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        }
    } else {
        for (int loopIdx0 = 0;
                 loopIdx0 < gl_SubgroupInvocationID + 1;
                 loopIdx0++) {
            if (testBit(uvec4(0x2391070a, 0x7c9f6acd, 0x32b370b4, 0x107dbe47), gl_SubgroupInvocationID)) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10003;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            } else {
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10007;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            break;
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000a;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        }
    }
    {
        int loopIdx0 = 0;
        do {
            loopIdx0++;
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001c;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
                {
                    int loopIdx1 = 0;
                    do {
                        loopIdx1++;
                    } while (loopIdx1 < inputA.a[4]);
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10021;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                if (inputA.a[3] == 3) {
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
            } else {
                for (int loopIdx1 = 0;
                         loopIdx1 < gl_SubgroupInvocationID + 1;
                         loopIdx1++) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002e;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
                if (testBit(uvec4(0xa1dd7c26, 0xdc8b0f06, 0x6342d0d2, 0x2f9c6461), gl_SubgroupInvocationID)) {
                    continue;
                } else {
                    continue;
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10036;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
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


void main()
[[subgroup_uniform_control_flow]]
{

    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10000;
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
    switch (gl_SubgroupInvocationID & 3) {
        case 0:
        case 1:
        {
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
                if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
                }
            }
            switch (gl_SubgroupInvocationID & 3) {
                case 0:
                case 1:
                {
                    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex2]) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000b;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    }
                    {
                        int loopIdx0 = 0;
                        do {
                            loopIdx0++;
                        } while (loopIdx0 < inputA.a[2]);
                    }
                    break;
                }
                case 2:
                case 3:
                {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10012;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    {
                        int loopIdx0 = 0;
                        do {
                            loopIdx0++;
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10015;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        } while (loopIdx0 < inputA.a[4]);
                    }
                    break;
                }
            }
            break;
        }
        case 2:
        case 3:
        {
            if (subgroupElect()) {
                if (inputA.a[0] == 0) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001e;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
                if (testBit(uvec4(0x90a02a95, 0xc9aa12ee, 0x338888b3, 0x4ec35298), gl_SubgroupInvocationID)) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10022;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                } else {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10025;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10028;
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
layout(constant_id = 13) const uint cmpIndex3 = 0u;


void main()
[[subgroup_uniform_control_flow]]
{

    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10000;
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
        for (int loopIdx0 = 0;
                 loopIdx0 < gl_SubgroupInvocationID + 1;
                 loopIdx0++) {
            break;
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10005;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            if (gl_SubgroupInvocationID == loopIdx0) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10008;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            } else {
            }
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000d;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
    }
    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10010;
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10013;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
    } else {
        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex2]) {
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex3]) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10018;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            }
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


void main()
[[subgroup_uniform_control_flow]]
{

    {
        int loopIdx0 = 0;
        do {
            loopIdx0++;
            continue;
            if (testBit(uvec4(0x7a4e2690, 0x432fc58e, 0x9b2bb71a, 0xc785c163), gl_SubgroupInvocationID)) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10003;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                continue;
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10006;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                if (testBit(uvec4(0xec6f3c8, 0xdcaa4b2a, 0xcd523415, 0x8087be24), gl_SubgroupInvocationID)) {
                    continue;
                } else {
                    continue;
                }
            } else {
                if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
                    if (inputA.a[2] == 2) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10010;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    }
                    {
                        int loopIdx1 = 0;
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
                            loopIdx1++;
                        } while (true);
                    }
                } else {
                    for (int loopIdx1 = 0;;loopIdx1++,                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true)) {
                        if (subgroupElect()) {
                            break;
                        }
                    }
                    return;
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10024;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                if (subgroupElect()) {
                    for (int loopIdx1 = 0;
                             loopIdx1 < inputA.a[2];
                             loopIdx1++) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10028;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    }
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002b;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    switch (inputA.a[4]) {
                        case 5:
                        {
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002f;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                            break;
                        }
                        case 4:
                        {
                            break;
                        }
                        case 6:
                        {
                            break;
                        }
                    }
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10037;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1003a;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            }
        } while (loopIdx0 < inputA.a[3]);
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


void main()
[[subgroup_uniform_control_flow]]
{

    if (testBit(uvec4(0x1f082002, 0xf140f2fe, 0xb896a0de, 0x808a57d0), gl_SubgroupInvocationID)) {
        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
                {
                    int loopIdx0 = 0;
                    do {
                        loopIdx0++;
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10004;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    } while (loopIdx0 < inputA.a[4]);
                }
                if (testBit(uvec4(0x1f082002, 0xf140f2fe, 0xb896a0de, 0x808a57d0), gl_SubgroupInvocationID)) {
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
            } else {
                if (testBit(uvec4(0x20acbc5e, 0x3ac93720, 0xc31450d5, 0xdfc2e34e), gl_SubgroupInvocationID)) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10012;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                } else {
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
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex3]) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10023;
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
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10029;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        break;
                    }
                }
                {
                    int loopIdx0 = 0;
                    do {
                        if (subgroupElect()) {
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002f;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                            break;
                        }
                        loopIdx0++;
                    } while (true);
                }
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
                        break;
                    }
                    case 3:
                    {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1003d;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        break;
                    }
                }
                if (inputA.a[2] == 2) {
                }
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10044;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        }
        if (inputA.a[1] == 1) {
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex4]) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10049;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
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
                if (inputA.a[2] == 2) {
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10059;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1005c;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex5]) {
                for (int loopIdx0 = 0;
                         loopIdx0 < gl_SubgroupInvocationID + 1;
                         loopIdx0++) {
                }
                if (testBit(uvec4(0x20acbc5e, 0x3ac93720, 0xc31450d5, 0xdfc2e34e), gl_SubgroupInvocationID)) {
                } else {
                }
            } else {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10065;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                if (gl_LocalInvocationIndex >= inputA.a[cmpIndex6]) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10068;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                } else {
                }
            }
        }
    } else {
        for (int loopIdx0 = 0;
                 loopIdx0 < inputA.a[1];
                 loopIdx0++) {
            if (testBit(uvec4(0x20acbc5e, 0x3ac93720, 0xc31450d5, 0xdfc2e34e), gl_SubgroupInvocationID)) {
                if (inputA.a[1] == 1) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10072;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                } else {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10075;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
                if (subgroupElect()) {
                }
            } else {
                if (inputA.a[2] == 2) {
                }
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1007e;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            for (int loopIdx1 = 0;
                     loopIdx1 < gl_SubgroupInvocationID + 1;
                     loopIdx1++) {
                if (inputA.a[3] == 3) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10082;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                } else {
                }
                switch (gl_SubgroupInvocationID & 3) {
                    case 0:
                    {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10088;
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
            }
        }
        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex7]) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10095;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        } else {
            if (testBit(uvec4(0x1f082002, 0xf140f2fe, 0xb896a0de, 0x808a57d0), gl_SubgroupInvocationID)) {
                if (gl_LocalInvocationIndex >= inputA.a[cmpIndex8]) {
                }
                if (gl_LocalInvocationIndex >= inputA.a[cmpIndex9]) {
                } else {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1009d;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x100a0;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            }
            {
                int loopIdx0 = 0;
                do {
                    loopIdx0++;
                    {
                        int loopIdx1 = 0;
                        do {
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x100a5;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                            if (subgroupElect()) {
                                outputC.loc[gl_LocalInvocationIndex]++;
                                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x100a8;
                                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                                break;
                            }
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x100ac;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                            loopIdx1++;
                        } while (true);
                    }
                } while (loopIdx0 < inputA.a[3]);
            }
        }
    }
    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x100b2;
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
layout(constant_id = 17) const uint cmpIndex7 = 0u;


void main()
[[subgroup_uniform_control_flow]]
{

    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10000;
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
    switch (inputA.a[0]) {
        case 1:
        {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10004;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            break;
        }
        case 0:
        {
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
                for (int loopIdx0 = 0;
                         loopIdx0 < gl_SubgroupInvocationID + 1;
                         loopIdx0++) {
                    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000b;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    } else {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000e;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    }
                }
                if (inputA.a[0] == 0) {
                    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex2]) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10014;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    } else {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10017;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    }
                    if (testBit(uvec4(0xa6844fcd, 0xd7def1a2, 0x355598c3, 0xc483030c), gl_SubgroupInvocationID)) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001b;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    }
                } else {
                    for (int loopIdx0 = 0;;loopIdx0++,                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true)) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10020;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        if (subgroupElect()) {
                            break;
                        }
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10025;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    }
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10028;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
            } else {
                if (subgroupElect()) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002d;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex3]) {
                    }
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10032;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                if (subgroupElect()) {
                    switch (inputA.a[4]) {
                        case 5:
                        {
                            break;
                        }
                        case 4:
                        {
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10039;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                            break;
                        }
                        case 6:
                        {
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1003d;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                            break;
                        }
                    }
                }
            }
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex4]) {
                if (subgroupElect()) {
                    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex5]) {
                    } else {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10047;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    }
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1004a;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex6]) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1004d;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    } else {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1004d;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    }
                }
                {
                    int loopIdx0 = 0;
                    do {
                        loopIdx0++;
                        if (testBit(uvec4(0xa6844fcd, 0xd7def1a2, 0x355598c3, 0xc483030c), gl_SubgroupInvocationID)) {
                        } else {
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10057;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        }
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1005a;
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
                                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10060;
                                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                                break;
                            }
                        }
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10064;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    } while (loopIdx0 < inputA.a[1]);
                }
            } else {
                switch (inputA.a[2]) {
                    case 3:
                    {
                        break;
                    }
                    case 2:
                    {
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
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10072;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        {
                            int loopIdx0 = 0;
                            do {
                                if (subgroupElect()) {
                                    break;
                                }
                                outputC.loc[gl_LocalInvocationIndex]++;
                                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10078;
                                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                                loopIdx0++;
                            } while (true);
                        }
                        break;
                    }
                    case 4:
                    {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1007d;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        break;
                    }
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10081;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            }
            break;
        }
        case 2:
        {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10086;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            if (subgroupElect()) {
                if (inputA.a[1] == 1) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1008a;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex7]) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1008d;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    } else {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10090;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    }
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10094;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                for (int loopIdx0 = 0;
                         loopIdx0 < gl_SubgroupInvocationID + 1;
                         loopIdx0++) {
                    {
                        int loopIdx1 = 0;
                        do {
                            if (subgroupElect()) {
                                break;
                            }
                            loopIdx1++;
                        } while (true);
                    }
                    if (gl_SubgroupInvocationID == loopIdx0) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1009d;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    }
                }
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x100a2;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
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
layout(constant_id = 13) const uint cmpIndex3 = 0u;
layout(constant_id = 14) const uint cmpIndex4 = 0u;


void main()
[[subgroup_uniform_control_flow]]
{

    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10000;
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
        return;
        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
            if (testBit(uvec4(0xa4b4530d, 0x37ae9ec4, 0xee17c242, 0x339316d9), gl_SubgroupInvocationID)) {
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10007;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex2]) {
                {
                    int loopIdx0 = 0;
                    do {
                        if (subgroupElect()) {
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000c;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                            break;
                        }
                        loopIdx0++;
                    } while (true);
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10011;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            }
        }
    }
    {
        int loopIdx0 = 0;
        do {
            loopIdx0++;
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10017;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            if (subgroupElect()) {
                if (gl_LocalInvocationIndex >= inputA.a[cmpIndex3]) {
                    if (testBit(uvec4(0xab263b6d, 0xad0c39fa, 0x50fd028b, 0xa8d50e), gl_SubgroupInvocationID)) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001c;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    } else {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001f;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    }
                }
                if (gl_LocalInvocationIndex >= inputA.a[cmpIndex4]) {
                    if (inputA.a[1] == 1) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10025;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    }
                    if (subgroupElect()) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10029;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    }
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002c;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                } else {
                    if (inputA.a[2] == 2) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10025;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    }
                    if (subgroupElect()) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10029;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    }
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002c;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
            }
            if (gl_SubgroupInvocationID == loopIdx0) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1003c;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                if (testBit(uvec4(0xab263b6d, 0xad0c39fa, 0x50fd028b, 0xa8d50e), gl_SubgroupInvocationID)) {
                    switch (inputA.a[1]) {
                        case 2:
                        {
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10041;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                            break;
                        }
                        case 1:
                        {
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10045;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                            break;
                        }
                        case 3:
                        {
                            break;
                        }
                    }
                    break;
                } else {
                    for (int loopIdx1 = 0;
                             loopIdx1 < gl_SubgroupInvocationID + 1;
                             loopIdx1++) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1004e;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    }
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10051;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
                {
                    int loopIdx1 = 0;
                    do {
                        loopIdx1++;
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10055;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        {
                            int loopIdx2 = 0;
                            do {
                                loopIdx2++;
                            } while (loopIdx2 < inputA.a[2]);
                        }
                    } while (loopIdx1 < inputA.a[5]);
                }
            }
        } while (loopIdx0 < inputA.a[4]);
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


void main()
[[subgroup_uniform_control_flow]]
{

    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10000;
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
        for (int loopIdx0 = 0;
                 loopIdx0 < inputA.a[2];
                 loopIdx0++) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10004;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            if (subgroupElect()) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10007;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                continue;
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000b;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            switch (gl_SubgroupInvocationID & 3) {
                case 0:
                {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000f;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    for (int loopIdx1 = 0;;loopIdx1++,                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true)) {
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
                    break;
                }
                case 1:
                {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001c;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001f;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    } else {
                    }
                    break;
                }
                case 2:
                {
                    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex2]) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10026;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    } else {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10029;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    }
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002c;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    break;
                }
                case 3:
                {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10030;
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
                }
            }
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1003f;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        switch (gl_SubgroupInvocationID & 3) {
            case 0:
            {
                for (int loopIdx0 = 0;
                         loopIdx0 < inputA.a[5];
                         loopIdx0++) {
                    if (inputA.a[1] == 1) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10045;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    }
                }
                break;
            }
            case 1:
            {
                if (subgroupElect()) {
                    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex3]) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1004d;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    } else {
                    }
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10051;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex4]) {
                    }
                }
                break;
            }
            case 2:
            {
                if (inputA.a[2] == 2) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10059;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex5]) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1005c;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    } else {
                    }
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10060;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex6]) {
                    }
                }
                break;
            }
            case 3:
            {
                if (testBit(uvec4(0xf9c83953, 0xdc833ee1, 0x3b114bed, 0x77893a04), gl_SubgroupInvocationID)) {
                    if (testBit(uvec4(0x461ab27e, 0xfea00e58, 0xc9829b62, 0x787df9a3), gl_SubgroupInvocationID)) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10069;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    } else {
                    }
                    {
                        int loopIdx0 = 0;
                        do {
                            if (subgroupElect()) {
                                outputC.loc[gl_LocalInvocationIndex]++;
                                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1006f;
                                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                                break;
                            }
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10073;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                            loopIdx0++;
                        } while (true);
                    }
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10076;
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
layout(constant_id = 12) const uint cmpIndex2 = 0u;
layout(constant_id = 13) const uint cmpIndex3 = 0u;
layout(constant_id = 14) const uint cmpIndex4 = 0u;
layout(constant_id = 15) const uint cmpIndex5 = 0u;
layout(constant_id = 16) const uint cmpIndex6 = 0u;
layout(constant_id = 17) const uint cmpIndex7 = 0u;


void main()
[[subgroup_uniform_control_flow]]
{

    if (testBit(uvec4(0xed6a2561, 0x5b7f8905, 0x1467e57d, 0x96b378c), gl_SubgroupInvocationID)) {
        switch (gl_SubgroupInvocationID & 3) {
            case 0:
            case 1:
            {
                if (inputA.a[3] == 3) {
                    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10005;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    } else {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10008;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    }
                    if (testBit(uvec4(0xed6a2561, 0x5b7f8905, 0x1467e57d, 0x96b378c), gl_SubgroupInvocationID)) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000c;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    } else {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000c;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    }
                } else {
                    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10005;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    } else {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10008;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    }
                    if (testBit(uvec4(0xed6a2561, 0x5b7f8905, 0x1467e57d, 0x96b378c), gl_SubgroupInvocationID)) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000c;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    } else {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000c;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    }
                }
                if (gl_LocalInvocationIndex >= inputA.a[cmpIndex2]) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10023;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex3]) {
                    }
                }
                break;
            }
            case 2:
            case 3:
            {
                for (int loopIdx0 = 0;
                         loopIdx0 < inputA.a[5];
                         loopIdx0++) {
                    if (inputA.a[0] == 0) {
                    }
                    if (gl_SubgroupInvocationID == loopIdx0) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002e;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    } else {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10031;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    }
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10035;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                if (inputA.a[0] == 0) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10038;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1003b;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                break;
            }
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1003f;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
    } else {
        switch (gl_SubgroupInvocationID & 3) {
            case 0:
            case 1:
            {
                if (inputA.a[3] == 3) {
                    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex4]) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10005;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    } else {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10008;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    }
                    if (testBit(uvec4(0xed6a2561, 0x5b7f8905, 0x1467e57d, 0x96b378c), gl_SubgroupInvocationID)) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000c;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    } else {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000c;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    }
                } else {
                    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex5]) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10005;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    } else {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10008;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    }
                    if (testBit(uvec4(0xed6a2561, 0x5b7f8905, 0x1467e57d, 0x96b378c), gl_SubgroupInvocationID)) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000c;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    } else {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000c;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    }
                }
                if (gl_LocalInvocationIndex >= inputA.a[cmpIndex6]) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10023;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex7]) {
                    }
                }
                break;
            }
            case 2:
            case 3:
            {
                for (int loopIdx0 = 0;
                         loopIdx0 < inputA.a[5];
                         loopIdx0++) {
                    if (inputA.a[0] == 0) {
                    }
                    if (gl_SubgroupInvocationID == loopIdx0) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002e;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    } else {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10031;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    }
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10035;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                if (inputA.a[2] == 2) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10038;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1003b;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                break;
            }
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1003f;
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

    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
        for (int loopIdx0 = 0;
                 loopIdx0 < gl_SubgroupInvocationID + 1;
                 loopIdx0++) {
            if (testBit(uvec4(0x2391070a, 0x7c9f6acd, 0x32b370b4, 0x107dbe47), gl_SubgroupInvocationID)) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10003;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
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
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000d;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            } else {
                if (gl_SubgroupInvocationID == loopIdx0) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10011;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                } else {
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10015;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                break;
            }
            for (int loopIdx1 = 0;;loopIdx1++,            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true)) {
                switch (loopIdx0) {
                    case 1: {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001c;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        break;
                    }
                    case 2: {
                        break;
                    }
                    default: {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10022;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        break;
                    }
                }
                if (testBit(uvec4(0xa1dd7c26, 0xdc8b0f06, 0x6342d0d2, 0x2f9c6461), gl_SubgroupInvocationID)) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10027;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
                if (subgroupElect()) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002b;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    break;
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002f;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                if (testBit(uvec4(0xed6a2561, 0x5b7f8905, 0x1467e57d, 0x96b378c), gl_SubgroupInvocationID)) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10032;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
                if (inputA.a[1] == 1) {
                }
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
layout(constant_id = 10) const uint cmpIndex0 = 0u;
layout(constant_id = 11) const uint cmpIndex1 = 0u;
layout(constant_id = 12) const uint cmpIndex2 = 0u;
layout(constant_id = 13) const uint cmpIndex3 = 0u;
layout(constant_id = 14) const uint cmpIndex4 = 0u;
layout(constant_id = 15) const uint cmpIndex5 = 0u;


void main()
[[subgroup_uniform_control_flow]]
{

    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10000;
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
    switch (gl_SubgroupInvocationID & 3) {
        case 0:
        case 1:
        {
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
                if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
                    if (inputA.a[3] == 3) {
                    }
                    {
                        int loopIdx0 = 0;
                        do {
                            if (subgroupElect()) {
                                outputC.loc[gl_LocalInvocationIndex]++;
                                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000a;
                                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                                break;
                            }
                            loopIdx0++;
                        } while (true);
                    }
                }
            }
            switch (inputA.a[3]) {
                case 4:
                {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10013;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    if (subgroupElect()) {
                        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex2]) {
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10017;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        } else {
                        }
                    }
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001c;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    break;
                }
                case 3:
                {
                    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex3]) {
                        for (int loopIdx0 = 0;
                                 loopIdx0 < gl_SubgroupInvocationID + 1;
                                 loopIdx0++) {
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10022;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        }
                    } else {
                        switch (gl_SubgroupInvocationID & 3) {
                            case 0:
                            case 1:
                            {
                                outputC.loc[gl_LocalInvocationIndex]++;
                                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10028;
                                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                                break;
                            }
                            case 2:
                            case 3:
                            {
                                outputC.loc[gl_LocalInvocationIndex]++;
                                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002c;
                                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                                break;
                            }
                        }
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10030;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex4]) {
                        } else {
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10034;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        }
                    }
                    {
                        int loopIdx0 = 0;
                        do {
                            loopIdx0++;
                            if (subgroupElect()) {
                            }
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1003b;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                            break;
                        } while (loopIdx0 < inputA.a[3]);
                    }
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1003f;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    break;
                }
                case 5:
                {
                    if (inputA.a[2] == 2) {
                        if (testBit(uvec4(0x90a02a95, 0xc9aa12ee, 0x338888b3, 0x4ec35298), gl_SubgroupInvocationID)) {
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10045;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        }
                        {
                            int loopIdx0 = 0;
                            do {
                                loopIdx0++;
                                outputC.loc[gl_LocalInvocationIndex]++;
                                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10049;
                                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                            } while (loopIdx0 < inputA.a[1]);
                        }
                    } else {
                        if (inputA.a[3] == 3) {
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1004e;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        } else {
                        }
                    }
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10053;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    break;
                }
            }
            break;
        }
        case 2:
        case 3:
        {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10059;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            if (testBit(uvec4(0x987d2de, 0x211b278, 0xf3463852, 0x94df3666), gl_SubgroupInvocationID)) {
                for (int loopIdx0 = 0;;loopIdx0++,                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true)) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1005d;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    {
                        int loopIdx1 = 0;
                        do {
                            if (subgroupElect()) {
                                outputC.loc[gl_LocalInvocationIndex]++;
                                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10061;
                                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                                break;
                            }
                            loopIdx1++;
                        } while (true);
                    }
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10066;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    if (subgroupElect()) {
                    }
                    if (subgroupElect()) {
                        break;
                    }
                    if (inputA.a[1] == 1) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1006e;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    }
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10071;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    for (int loopIdx1 = 0;
                             loopIdx1 < gl_SubgroupInvocationID + 1;
                             loopIdx1++) {
                    }
                }
            }
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex5]) {
                for (int loopIdx0 = 0;;loopIdx0++,                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true)) {
                    if (gl_SubgroupInvocationID == loopIdx0) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1007a;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    }
                    if (subgroupElect()) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1007e;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        break;
                    }
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10082;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    for (int loopIdx1 = 0;
                             loopIdx1 < gl_SubgroupInvocationID + 1;
                             loopIdx1++) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10085;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    }
                }
                for (int loopIdx0 = 0;
                         loopIdx0 < gl_SubgroupInvocationID + 1;
                         loopIdx0++) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1008a;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    if (testBit(uvec4(0x4dc2923c, 0xdc935c2f, 0x8f9e5516, 0xc383a7ce), gl_SubgroupInvocationID)) {
                        continue;
                    } else {
                        continue;
                    }
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10091;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    if (subgroupElect()) {
                    }
                }
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10097;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
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

    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10000;
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
        for (int loopIdx0 = 0;
                 loopIdx0 < gl_SubgroupInvocationID + 1;
                 loopIdx0++) {
            break;
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10005;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            if (gl_SubgroupInvocationID == loopIdx0) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10008;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                {
                    int loopIdx1 = 0;
                    do {
                        loopIdx1++;
                    } while (loopIdx1 < inputA.a[1]);
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000c;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000f;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                } else {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10012;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
            } else {
                break;
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10017;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
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


void main()
{

    switch (inputA.a[2]) {
        case 3:
        {
            break;
        }
        case 2:
        {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10004;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            if (testBit(uvec4(0x5c279566, 0x5b0364e5, 0xab19e77b, 0xdf709dc4), gl_SubgroupInvocationID)) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10007;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            } else {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000a;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            }
            {
                int loopIdx0 = 0;
                do {
                    if (subgroupElect()) {
                        break;
                    }
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10011;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    loopIdx0++;
                } while (true);
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10014;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            break;
        }
        case 4:
        {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10018;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001b;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            } else {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001e;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            }
            break;
        }
    }
    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10023;
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
            if (testBit(uvec4(0x7a4e2690, 0x432fc58e, 0x9b2bb71a, 0xc785c163), gl_SubgroupInvocationID)) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10003;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            } else {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10003;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            }
        } while (loopIdx0 < inputA.a[3]);
    }
    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000c;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        } else {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000f;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        }
    } else {
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10013;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        switch (gl_SubgroupInvocationID & 3) {
            case 0:
            case 1:
            {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10017;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                break;
            }
            case 2:
            case 3:
            {
                break;
            }
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
layout(constant_id = 12) const uint cmpIndex2 = 0u;
layout(constant_id = 13) const uint cmpIndex3 = 0u;


void main()
{

    if (testBit(uvec4(0x1f082002, 0xf140f2fe, 0xb896a0de, 0x808a57d0), gl_SubgroupInvocationID)) {
        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
        } else {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10003;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        }
        for (int loopIdx0 = 0;;loopIdx0++,        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect()) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10007;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            if (subgroupElect()) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000a;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                break;
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000e;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10011;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
    }
    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex2]) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10016;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        } else {
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001a;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
    } else {
        if (testBit(uvec4(0x24be39e6, 0xdcb39833, 0xe7e59864, 0xaaff4173), gl_SubgroupInvocationID)) {
        } else {
        }
        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex3]) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10021;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        } else {
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
    switch (inputA.a[0]) {
        case 1:
        {
            if (testBit(uvec4(0x20acbc5e, 0x3ac93720, 0xc31450d5, 0xdfc2e34e), gl_SubgroupInvocationID)) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10005;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            } else {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10008;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            }
            break;
        }
        case 0:
        {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000d;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            if (subgroupElect()) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10010;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            }
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10014;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            }
            break;
        }
        case 2:
        {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10019;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            {
                int loopIdx0 = 0;
                do {
                    loopIdx0++;
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001c;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                } while (loopIdx0 < inputA.a[1]);
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001f;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
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


void main()
{

    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10000;
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
    switch (inputA.a[0]) {
        case 1:
        {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10004;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            break;
        }
        case 0:
        {
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10009;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000c;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            break;
        }
        case 2:
        {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10010;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            {
                int loopIdx0 = 0;
                do {
                    loopIdx0++;
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10013;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                } while (loopIdx0 < inputA.a[5]);
            }
            break;
        }
    }
    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10018;
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
    if (testBit(uvec4(0xeb93571b, 0xd23ee0a9, 0xf2c07cfb, 0x8c5d2c), gl_SubgroupInvocationID)) {
        if (subgroupElect()) {
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001d;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        switch (inputA.a[2]) {
            case 3:
            {
                break;
            }
            case 2:
            {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10023;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                break;
            }
            case 4:
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
layout(local_size_x_id = 0, local_size_y_id = 1, local_size_z = 1) in;
layout(set=0, binding=2) coherent buffer OutputC { uint loc[]; } outputC;
layout(set=0, binding=1) coherent buffer OutputB { uvec4 b[]; } outputB;
layout(set=0, binding=0) coherent buffer InputA  { uint  a[]; } inputA;
layout(push_constant) uniform PC {
   // set to the real stride when writing out ballots, or zero when just counting
   int  invocationStride;
   // wildcard fields, for an example the dimensions of rendered area in the case of graphics shaders
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
        for (int loopIdx0 = 0;
                 loopIdx0 < gl_SubgroupInvocationID + 1;
                 loopIdx0++) {
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10005;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10008;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000b;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
    } else {
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000e;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
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
        if (subgroupElect()) {
        }
    }
    switch (gl_SubgroupInvocationID & 3) {
        case 0:
        case 1:
        {
            for (int loopIdx0 = 0;
                     loopIdx0 < inputA.a[3];
                     loopIdx0++) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10020;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10023;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            if (subgroupElect()) {
            }
            break;
        }
        case 2:
        case 3:
        {
            {
                int loopIdx0 = 0;
                do {
                    if (subgroupElect()) {
                        break;
                    }
                    loopIdx0++;
                } while (true);
            }
            if (inputA.a[3] == 3) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002f;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            } else {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10032;
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


void main()
{

    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
        for (int loopIdx0 = 0;
                 loopIdx0 < gl_SubgroupInvocationID + 1;
                 loopIdx0++) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10002;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        }
    }
    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10006;
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
    if (testBit(uvec4(0x2391070a, 0x7c9f6acd, 0x32b370b4, 0x107dbe47), gl_SubgroupInvocationID)) {
        if (testBit(uvec4(0xa1dd7c26, 0xdc8b0f06, 0x6342d0d2, 0x2f9c6461), gl_SubgroupInvocationID)) {
        } else {
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000c;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
    }
    if (testBit(uvec4(0xed6a2561, 0x5b7f8905, 0x1467e57d, 0x96b378c), gl_SubgroupInvocationID)) {
        if (inputA.a[2] == 2) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10011;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        } else {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10014;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        }
    } else {
        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
        } else {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001a;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        }
        for (int loopIdx0 = 0;
                 loopIdx0 < gl_SubgroupInvocationID + 1;
                 loopIdx0++) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001e;
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


void main()
{

    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10000;
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
    switch (gl_SubgroupInvocationID & 3) {
        case 0:
        case 1:
        {
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
            }
            {
                int loopIdx0 = 0;
                do {
                    loopIdx0++;
                } while (loopIdx0 < inputA.a[3]);
            }
            break;
        }
        case 2:
        case 3:
        {
            if (inputA.a[0] == 0) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000b;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            }
            for (int loopIdx0 = 0;
                     loopIdx0 < inputA.a[3];
                     loopIdx0++) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000f;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            }
            break;
        }
    }
    switch (inputA.a[3]) {
        case 4:
        {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10016;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            if (subgroupElect()) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10019;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            }
            break;
        }
        case 3:
        {
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001f;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10022;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            break;
        }
        case 5:
        {
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex2]) {
            } else {
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

    for (int loopIdx0 = 0;
             loopIdx0 < inputA.a[3];
             loopIdx0++) {
        if (inputA.a[2] == 2) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10002;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10005;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        if (subgroupElect()) {
        }
    }
    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000a;
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
    for (int loopIdx0 = 0;
             loopIdx0 < inputA.a[1];
             loopIdx0++) {
        if (inputA.a[1] == 1) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000e;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        } else {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10011;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        }
        for (int loopIdx1 = 0;;loopIdx1++,        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect()) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10015;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            if (subgroupElect()) {
                break;
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001a;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
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
layout(constant_id = 12) const uint cmpIndex2 = 0u;


void main()
{

    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10000;
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
    for (int loopIdx0 = 0;
             loopIdx0 < inputA.a[5];
             loopIdx0++) {
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10003;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        break;
        if (testBit(uvec4(0xf5200d72, 0xdc94acf1, 0x37427b06, 0x7b612795), gl_SubgroupInvocationID)) {
        }
    }
    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000a;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
    } else {
        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000f;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex2]) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10012;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        }
    }
    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10016;
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
    for (int loopIdx0 = 0;;loopIdx0++,    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect()) {
        {
            int loopIdx1 = 0;
            do {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001a;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                if (subgroupElect()) {
                    break;
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001f;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                loopIdx1++;
            } while (true);
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10022;
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
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002a;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                break;
            }
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002e;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        if (subgroupElect()) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10031;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            break;
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10035;
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


void main()
{

    if (testBit(uvec4(0x5c279566, 0x5b0364e5, 0xab19e77b, 0xdf709dc4), gl_SubgroupInvocationID)) {
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10001;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10004;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        } else {
            if (subgroupElect()) {
            }
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000a;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000d;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        }
    }
    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10011;
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
    {
        int loopIdx0 = 0;
        do {
            for (int loopIdx1 = 0;;loopIdx1++,            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect()) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10015;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                switch (inputA.a[2]) {
                    case 3:
                    {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10019;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                        break;
                    }
                    case 2:
                    {
                        break;
                    }
                    case 4:
                    {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001f;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                        break;
                    }
                }
                if (subgroupElect()) {
                    break;
                }
                {
                    int loopIdx2 = 0;
                    do {
                        if (subgroupElect()) {
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10028;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                            if (testBit(uvec4(0x576a093a, 0xdca27a4d, 0x94bc142d, 0xd92b5ff1), gl_SubgroupInvocationID)) {
                                break;
                            } else {
                                break;
                            }
                        }
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10030;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                        loopIdx2++;
                    } while (true);
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10033;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                switch (inputA.a[4]) {
                    case 5:
                    {
                        break;
                    }
                    case 4:
                    {
                        break;
                    }
                    case 6:
                    {
                        break;
                    }
                }
            }
            if (subgroupElect()) {
                break;
            }
            if (testBit(uvec4(0xda273742, 0xbb2e665c, 0xbef28f40, 0xcbead8ea), gl_SubgroupInvocationID)) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10042;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                if (subgroupElect()) {
                }
            }
            if (subgroupElect()) {
                if (gl_SubgroupInvocationID == loopIdx0) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10049;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                } else {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1004c;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1004f;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                break;
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10052;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            }
            loopIdx0++;
        } while (true);
    }
    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10056;
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
            loopIdx0++;
            continue;
            if (testBit(uvec4(0x7a4e2690, 0x432fc58e, 0x9b2bb71a, 0xc785c163), gl_SubgroupInvocationID)) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10003;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                continue;
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10006;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                if (testBit(uvec4(0xec6f3c8, 0xdcaa4b2a, 0xcd523415, 0x8087be24), gl_SubgroupInvocationID)) {
                    continue;
                } else {
                    continue;
                }
            } else {
                if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000f;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                }
                switch (inputA.a[2]) {
                    case 3:
                    {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10014;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                        break;
                    }
                    case 2:
                    {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10018;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                        break;
                    }
                    case 4:
                    {
                        break;
                    }
                }
            }
        } while (loopIdx0 < inputA.a[3]);
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

    if (testBit(uvec4(0x1f082002, 0xf140f2fe, 0xb896a0de, 0x808a57d0), gl_SubgroupInvocationID)) {
        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10003;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            }
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex2]) {
            }
        } else {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10009;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            if (inputA.a[3] == 3) {
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000d;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10010;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        if (inputA.a[1] == 1) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10013;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            {
                int loopIdx0 = 0;
                do {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10016;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    if (subgroupElect()) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10019;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                        break;
                    }
                    loopIdx0++;
                } while (true);
            }
        } else {
            if (inputA.a[0] == 0) {
            } else {
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10022;
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


void main()
{

    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10000;
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
    switch (inputA.a[0]) {
        case 1:
        {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10004;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            break;
        }
        case 0:
        {
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
                for (int loopIdx0 = 0;
                         loopIdx0 < gl_SubgroupInvocationID + 1;
                         loopIdx0++) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000a;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                }
            } else {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000e;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                if (subgroupElect()) {
                }
            }
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
                if (gl_LocalInvocationIndex >= inputA.a[cmpIndex2]) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10015;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                } else {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10018;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                }
                if (inputA.a[1] == 1) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001c;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                } else {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001c;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                }
            }
            break;
        }
        case 2:
        {
            for (int loopIdx0 = 0;
                     loopIdx0 < inputA.a[2];
                     loopIdx0++) {
                if (inputA.a[3] == 3) {
                } else {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10028;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002b;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002e;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
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


void main()
{

    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10000;
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
        for (int loopIdx0 = 0;
                 loopIdx0 < inputA.a[2];
                 loopIdx0++) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10004;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            if (subgroupElect()) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10007;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            }
            if (subgroupElect()) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000b;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            }
        }
    } else {
        if (subgroupElect()) {
            if (subgroupElect()) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10012;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10015;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            switch (gl_SubgroupInvocationID & 3) {
                case 0:
                {
                    break;
                }
                case 1:
                {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001b;
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
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10021;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    break;
                }
            }
        }
        for (int loopIdx0 = 0;;loopIdx0++,        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect()) {
            if (inputA.a[0] == 0) {
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10029;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            if (subgroupElect()) {
                break;
            }
            for (int loopIdx1 = 0;;loopIdx1++,            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect()) {
                if (subgroupElect()) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10030;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    break;
                }
            }
            switch (loopIdx0) {
                case 1: {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10037;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    break;
                }
                case 2: {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1003b;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    break;
                }
                default: {
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


void main()
{

    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
        for (int loopIdx0 = 0;
                 loopIdx0 < gl_SubgroupInvocationID + 1;
                 loopIdx0++) {
            if (testBit(uvec4(0x2391070a, 0x7c9f6acd, 0x32b370b4, 0x107dbe47), gl_SubgroupInvocationID)) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10003;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            } else {
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10007;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            break;
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000a;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        }
    } else {
        for (int loopIdx0 = 0;
                 loopIdx0 < gl_SubgroupInvocationID + 1;
                 loopIdx0++) {
            if (testBit(uvec4(0x2391070a, 0x7c9f6acd, 0x32b370b4, 0x107dbe47), gl_SubgroupInvocationID)) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10003;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            } else {
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10007;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            break;
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000a;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        }
    }
    {
        int loopIdx0 = 0;
        do {
            loopIdx0++;
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001c;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
                {
                    int loopIdx1 = 0;
                    do {
                        loopIdx1++;
                    } while (loopIdx1 < inputA.a[4]);
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10021;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                if (inputA.a[3] == 3) {
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
            } else {
                for (int loopIdx1 = 0;
                         loopIdx1 < gl_SubgroupInvocationID + 1;
                         loopIdx1++) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002e;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                }
                if (testBit(uvec4(0xa1dd7c26, 0xdc8b0f06, 0x6342d0d2, 0x2f9c6461), gl_SubgroupInvocationID)) {
                    continue;
                } else {
                    continue;
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10036;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
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


void main()
{

    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10000;
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
    switch (gl_SubgroupInvocationID & 3) {
        case 0:
        case 1:
        {
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
                if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
                }
            }
            switch (gl_SubgroupInvocationID & 3) {
                case 0:
                case 1:
                {
                    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex2]) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000b;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    }
                    {
                        int loopIdx0 = 0;
                        do {
                            loopIdx0++;
                        } while (loopIdx0 < inputA.a[2]);
                    }
                    break;
                }
                case 2:
                case 3:
                {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10012;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    {
                        int loopIdx0 = 0;
                        do {
                            loopIdx0++;
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10015;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                        } while (loopIdx0 < inputA.a[4]);
                    }
                    break;
                }
            }
            break;
        }
        case 2:
        case 3:
        {
            if (subgroupElect()) {
                if (inputA.a[0] == 0) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001e;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                }
                if (testBit(uvec4(0x90a02a95, 0xc9aa12ee, 0x338888b3, 0x4ec35298), gl_SubgroupInvocationID)) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10022;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                } else {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10025;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10028;
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
layout(constant_id = 13) const uint cmpIndex3 = 0u;


void main()
{

    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10000;
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
        for (int loopIdx0 = 0;
                 loopIdx0 < gl_SubgroupInvocationID + 1;
                 loopIdx0++) {
            break;
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10005;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            if (gl_SubgroupInvocationID == loopIdx0) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10008;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            } else {
            }
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000d;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
    }
    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10010;
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10013;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
    } else {
        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex2]) {
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex3]) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10018;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            }
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


void main()
{

    {
        int loopIdx0 = 0;
        do {
            loopIdx0++;
            continue;
            if (testBit(uvec4(0x7a4e2690, 0x432fc58e, 0x9b2bb71a, 0xc785c163), gl_SubgroupInvocationID)) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10003;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                continue;
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10006;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                if (testBit(uvec4(0xec6f3c8, 0xdcaa4b2a, 0xcd523415, 0x8087be24), gl_SubgroupInvocationID)) {
                    continue;
                } else {
                    continue;
                }
            } else {
                if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
                    if (inputA.a[2] == 2) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10010;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    }
                    {
                        int loopIdx1 = 0;
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
                            loopIdx1++;
                        } while (true);
                    }
                } else {
                    for (int loopIdx1 = 0;;loopIdx1++,                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect()) {
                        if (subgroupElect()) {
                            break;
                        }
                    }
                    return;
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10024;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                if (subgroupElect()) {
                    for (int loopIdx1 = 0;
                             loopIdx1 < inputA.a[2];
                             loopIdx1++) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10028;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    }
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002b;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    switch (inputA.a[4]) {
                        case 5:
                        {
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002f;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                            break;
                        }
                        case 4:
                        {
                            break;
                        }
                        case 6:
                        {
                            break;
                        }
                    }
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10037;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1003a;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            }
        } while (loopIdx0 < inputA.a[3]);
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


void main()
{

    if (testBit(uvec4(0x1f082002, 0xf140f2fe, 0xb896a0de, 0x808a57d0), gl_SubgroupInvocationID)) {
        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
                {
                    int loopIdx0 = 0;
                    do {
                        loopIdx0++;
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10004;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    } while (loopIdx0 < inputA.a[4]);
                }
                if (testBit(uvec4(0x1f082002, 0xf140f2fe, 0xb896a0de, 0x808a57d0), gl_SubgroupInvocationID)) {
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
            } else {
                if (testBit(uvec4(0x20acbc5e, 0x3ac93720, 0xc31450d5, 0xdfc2e34e), gl_SubgroupInvocationID)) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10012;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                } else {
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
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex3]) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10023;
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
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10029;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                        break;
                    }
                }
                {
                    int loopIdx0 = 0;
                    do {
                        if (subgroupElect()) {
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002f;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                            break;
                        }
                        loopIdx0++;
                    } while (true);
                }
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
                        break;
                    }
                    case 3:
                    {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1003d;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                        break;
                    }
                }
                if (inputA.a[2] == 2) {
                }
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10044;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        }
        if (inputA.a[1] == 1) {
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex4]) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10049;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
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
                if (inputA.a[2] == 2) {
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10059;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1005c;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex5]) {
                for (int loopIdx0 = 0;
                         loopIdx0 < gl_SubgroupInvocationID + 1;
                         loopIdx0++) {
                }
                if (testBit(uvec4(0x20acbc5e, 0x3ac93720, 0xc31450d5, 0xdfc2e34e), gl_SubgroupInvocationID)) {
                } else {
                }
            } else {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10065;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                if (gl_LocalInvocationIndex >= inputA.a[cmpIndex6]) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10068;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                } else {
                }
            }
        }
    } else {
        for (int loopIdx0 = 0;
                 loopIdx0 < inputA.a[1];
                 loopIdx0++) {
            if (testBit(uvec4(0x20acbc5e, 0x3ac93720, 0xc31450d5, 0xdfc2e34e), gl_SubgroupInvocationID)) {
                if (inputA.a[1] == 1) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10072;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                } else {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10075;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                }
                if (subgroupElect()) {
                }
            } else {
                if (inputA.a[2] == 2) {
                }
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1007e;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            for (int loopIdx1 = 0;
                     loopIdx1 < gl_SubgroupInvocationID + 1;
                     loopIdx1++) {
                if (inputA.a[3] == 3) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10082;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                } else {
                }
                switch (gl_SubgroupInvocationID & 3) {
                    case 0:
                    {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10088;
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
            }
        }
        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex7]) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10095;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        } else {
            if (testBit(uvec4(0x1f082002, 0xf140f2fe, 0xb896a0de, 0x808a57d0), gl_SubgroupInvocationID)) {
                if (gl_LocalInvocationIndex >= inputA.a[cmpIndex8]) {
                }
                if (gl_LocalInvocationIndex >= inputA.a[cmpIndex9]) {
                } else {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1009d;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x100a0;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            }
            {
                int loopIdx0 = 0;
                do {
                    loopIdx0++;
                    {
                        int loopIdx1 = 0;
                        do {
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x100a5;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                            if (subgroupElect()) {
                                outputC.loc[gl_LocalInvocationIndex]++;
                                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x100a8;
                                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                                break;
                            }
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x100ac;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                            loopIdx1++;
                        } while (true);
                    }
                } while (loopIdx0 < inputA.a[3]);
            }
        }
    }
    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x100b2;
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
layout(constant_id = 17) const uint cmpIndex7 = 0u;


void main()
{

    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10000;
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
    switch (inputA.a[0]) {
        case 1:
        {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10004;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            break;
        }
        case 0:
        {
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
                for (int loopIdx0 = 0;
                         loopIdx0 < gl_SubgroupInvocationID + 1;
                         loopIdx0++) {
                    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000b;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    } else {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000e;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    }
                }
                if (inputA.a[0] == 0) {
                    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex2]) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10014;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    } else {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10017;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    }
                    if (testBit(uvec4(0xa6844fcd, 0xd7def1a2, 0x355598c3, 0xc483030c), gl_SubgroupInvocationID)) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001b;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    }
                } else {
                    for (int loopIdx0 = 0;;loopIdx0++,                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect()) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10020;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                        if (subgroupElect()) {
                            break;
                        }
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10025;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    }
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10028;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                }
            } else {
                if (subgroupElect()) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002d;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex3]) {
                    }
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10032;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                if (subgroupElect()) {
                    switch (inputA.a[4]) {
                        case 5:
                        {
                            break;
                        }
                        case 4:
                        {
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10039;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                            break;
                        }
                        case 6:
                        {
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1003d;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                            break;
                        }
                    }
                }
            }
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex4]) {
                if (subgroupElect()) {
                    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex5]) {
                    } else {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10047;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    }
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1004a;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex6]) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1004d;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    } else {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1004d;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    }
                }
                {
                    int loopIdx0 = 0;
                    do {
                        loopIdx0++;
                        if (testBit(uvec4(0xa6844fcd, 0xd7def1a2, 0x355598c3, 0xc483030c), gl_SubgroupInvocationID)) {
                        } else {
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10057;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                        }
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1005a;
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
                                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10060;
                                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                                break;
                            }
                        }
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10064;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    } while (loopIdx0 < inputA.a[1]);
                }
            } else {
                switch (inputA.a[2]) {
                    case 3:
                    {
                        break;
                    }
                    case 2:
                    {
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
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10072;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                        {
                            int loopIdx0 = 0;
                            do {
                                if (subgroupElect()) {
                                    break;
                                }
                                outputC.loc[gl_LocalInvocationIndex]++;
                                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10078;
                                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                                loopIdx0++;
                            } while (true);
                        }
                        break;
                    }
                    case 4:
                    {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1007d;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                        break;
                    }
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10081;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            }
            break;
        }
        case 2:
        {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10086;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            if (subgroupElect()) {
                if (inputA.a[1] == 1) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1008a;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex7]) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1008d;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    } else {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10090;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    }
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10094;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                for (int loopIdx0 = 0;
                         loopIdx0 < gl_SubgroupInvocationID + 1;
                         loopIdx0++) {
                    {
                        int loopIdx1 = 0;
                        do {
                            if (subgroupElect()) {
                                break;
                            }
                            loopIdx1++;
                        } while (true);
                    }
                    if (gl_SubgroupInvocationID == loopIdx0) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1009d;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    }
                }
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x100a2;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
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
layout(constant_id = 13) const uint cmpIndex3 = 0u;
layout(constant_id = 14) const uint cmpIndex4 = 0u;


void main()
{

    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10000;
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
        return;
        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
            if (testBit(uvec4(0xa4b4530d, 0x37ae9ec4, 0xee17c242, 0x339316d9), gl_SubgroupInvocationID)) {
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10007;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex2]) {
                {
                    int loopIdx0 = 0;
                    do {
                        if (subgroupElect()) {
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000c;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                            break;
                        }
                        loopIdx0++;
                    } while (true);
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10011;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            }
        }
    }
    {
        int loopIdx0 = 0;
        do {
            loopIdx0++;
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10017;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            if (subgroupElect()) {
                if (gl_LocalInvocationIndex >= inputA.a[cmpIndex3]) {
                    if (testBit(uvec4(0xab263b6d, 0xad0c39fa, 0x50fd028b, 0xa8d50e), gl_SubgroupInvocationID)) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001c;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    } else {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001f;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    }
                }
                if (gl_LocalInvocationIndex >= inputA.a[cmpIndex4]) {
                    if (inputA.a[1] == 1) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10025;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    }
                    if (subgroupElect()) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10029;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    }
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002c;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                } else {
                    if (inputA.a[2] == 2) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10025;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    }
                    if (subgroupElect()) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10029;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    }
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002c;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                }
            }
            if (gl_SubgroupInvocationID == loopIdx0) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1003c;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                if (testBit(uvec4(0xab263b6d, 0xad0c39fa, 0x50fd028b, 0xa8d50e), gl_SubgroupInvocationID)) {
                    switch (inputA.a[1]) {
                        case 2:
                        {
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10041;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                            break;
                        }
                        case 1:
                        {
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10045;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                            break;
                        }
                        case 3:
                        {
                            break;
                        }
                    }
                    break;
                } else {
                    for (int loopIdx1 = 0;
                             loopIdx1 < gl_SubgroupInvocationID + 1;
                             loopIdx1++) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1004e;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    }
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10051;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                }
                {
                    int loopIdx1 = 0;
                    do {
                        loopIdx1++;
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10055;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                        {
                            int loopIdx2 = 0;
                            do {
                                loopIdx2++;
                            } while (loopIdx2 < inputA.a[2]);
                        }
                    } while (loopIdx1 < inputA.a[5]);
                }
            }
        } while (loopIdx0 < inputA.a[4]);
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


void main()
{

    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10000;
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
        for (int loopIdx0 = 0;
                 loopIdx0 < inputA.a[2];
                 loopIdx0++) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10004;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            if (subgroupElect()) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10007;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                continue;
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000b;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            switch (gl_SubgroupInvocationID & 3) {
                case 0:
                {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000f;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    for (int loopIdx1 = 0;;loopIdx1++,                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect()) {
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
                    break;
                }
                case 1:
                {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001c;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001f;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    } else {
                    }
                    break;
                }
                case 2:
                {
                    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex2]) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10026;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    } else {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10029;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    }
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002c;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    break;
                }
                case 3:
                {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10030;
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
                }
            }
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1003f;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        switch (gl_SubgroupInvocationID & 3) {
            case 0:
            {
                for (int loopIdx0 = 0;
                         loopIdx0 < inputA.a[5];
                         loopIdx0++) {
                    if (inputA.a[1] == 1) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10045;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    }
                }
                break;
            }
            case 1:
            {
                if (subgroupElect()) {
                    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex3]) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1004d;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    } else {
                    }
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10051;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex4]) {
                    }
                }
                break;
            }
            case 2:
            {
                if (inputA.a[2] == 2) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10059;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex5]) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1005c;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    } else {
                    }
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10060;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex6]) {
                    }
                }
                break;
            }
            case 3:
            {
                if (testBit(uvec4(0xf9c83953, 0xdc833ee1, 0x3b114bed, 0x77893a04), gl_SubgroupInvocationID)) {
                    if (testBit(uvec4(0x461ab27e, 0xfea00e58, 0xc9829b62, 0x787df9a3), gl_SubgroupInvocationID)) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10069;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    } else {
                    }
                    {
                        int loopIdx0 = 0;
                        do {
                            if (subgroupElect()) {
                                outputC.loc[gl_LocalInvocationIndex]++;
                                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1006f;
                                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                                break;
                            }
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10073;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                            loopIdx0++;
                        } while (true);
                    }
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10076;
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
layout(constant_id = 12) const uint cmpIndex2 = 0u;
layout(constant_id = 13) const uint cmpIndex3 = 0u;
layout(constant_id = 14) const uint cmpIndex4 = 0u;
layout(constant_id = 15) const uint cmpIndex5 = 0u;
layout(constant_id = 16) const uint cmpIndex6 = 0u;
layout(constant_id = 17) const uint cmpIndex7 = 0u;


void main()
{

    if (testBit(uvec4(0xed6a2561, 0x5b7f8905, 0x1467e57d, 0x96b378c), gl_SubgroupInvocationID)) {
        switch (gl_SubgroupInvocationID & 3) {
            case 0:
            case 1:
            {
                if (inputA.a[3] == 3) {
                    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10005;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    } else {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10008;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    }
                    if (testBit(uvec4(0xed6a2561, 0x5b7f8905, 0x1467e57d, 0x96b378c), gl_SubgroupInvocationID)) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000c;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    } else {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000c;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    }
                } else {
                    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10005;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    } else {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10008;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    }
                    if (testBit(uvec4(0xed6a2561, 0x5b7f8905, 0x1467e57d, 0x96b378c), gl_SubgroupInvocationID)) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000c;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    } else {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000c;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    }
                }
                if (gl_LocalInvocationIndex >= inputA.a[cmpIndex2]) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10023;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex3]) {
                    }
                }
                break;
            }
            case 2:
            case 3:
            {
                for (int loopIdx0 = 0;
                         loopIdx0 < inputA.a[5];
                         loopIdx0++) {
                    if (inputA.a[0] == 0) {
                    }
                    if (gl_SubgroupInvocationID == loopIdx0) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002e;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    } else {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10031;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    }
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10035;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                if (inputA.a[0] == 0) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10038;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1003b;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                break;
            }
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1003f;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
    } else {
        switch (gl_SubgroupInvocationID & 3) {
            case 0:
            case 1:
            {
                if (inputA.a[3] == 3) {
                    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex4]) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10005;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    } else {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10008;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    }
                    if (testBit(uvec4(0xed6a2561, 0x5b7f8905, 0x1467e57d, 0x96b378c), gl_SubgroupInvocationID)) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000c;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    } else {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000c;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    }
                } else {
                    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex5]) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10005;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    } else {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10008;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    }
                    if (testBit(uvec4(0xed6a2561, 0x5b7f8905, 0x1467e57d, 0x96b378c), gl_SubgroupInvocationID)) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000c;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    } else {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000c;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    }
                }
                if (gl_LocalInvocationIndex >= inputA.a[cmpIndex6]) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10023;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex7]) {
                    }
                }
                break;
            }
            case 2:
            case 3:
            {
                for (int loopIdx0 = 0;
                         loopIdx0 < inputA.a[5];
                         loopIdx0++) {
                    if (inputA.a[0] == 0) {
                    }
                    if (gl_SubgroupInvocationID == loopIdx0) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002e;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    } else {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10031;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    }
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10035;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                if (inputA.a[2] == 2) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10038;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1003b;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                break;
            }
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1003f;
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
layout(constant_id = 14) const uint cmpIndex4 = 0u;
layout(constant_id = 15) const uint cmpIndex5 = 0u;


void main()
{

    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10000;
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
    switch (gl_SubgroupInvocationID & 3) {
        case 0:
        case 1:
        {
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
                if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
                    if (inputA.a[3] == 3) {
                    }
                    {
                        int loopIdx0 = 0;
                        do {
                            if (subgroupElect()) {
                                outputC.loc[gl_LocalInvocationIndex]++;
                                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000a;
                                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                                break;
                            }
                            loopIdx0++;
                        } while (true);
                    }
                }
            }
            switch (inputA.a[3]) {
                case 4:
                {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10013;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    if (subgroupElect()) {
                        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex2]) {
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10017;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                        } else {
                        }
                    }
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001c;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    break;
                }
                case 3:
                {
                    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex3]) {
                        for (int loopIdx0 = 0;
                                 loopIdx0 < gl_SubgroupInvocationID + 1;
                                 loopIdx0++) {
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10022;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                        }
                    } else {
                        switch (gl_SubgroupInvocationID & 3) {
                            case 0:
                            case 1:
                            {
                                outputC.loc[gl_LocalInvocationIndex]++;
                                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10028;
                                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                                break;
                            }
                            case 2:
                            case 3:
                            {
                                outputC.loc[gl_LocalInvocationIndex]++;
                                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002c;
                                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                                break;
                            }
                        }
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10030;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex4]) {
                        } else {
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10034;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                        }
                    }
                    {
                        int loopIdx0 = 0;
                        do {
                            loopIdx0++;
                            if (subgroupElect()) {
                            }
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1003b;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                            break;
                        } while (loopIdx0 < inputA.a[3]);
                    }
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1003f;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    break;
                }
                case 5:
                {
                    if (inputA.a[2] == 2) {
                        if (testBit(uvec4(0x90a02a95, 0xc9aa12ee, 0x338888b3, 0x4ec35298), gl_SubgroupInvocationID)) {
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10045;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                        }
                        {
                            int loopIdx0 = 0;
                            do {
                                loopIdx0++;
                                outputC.loc[gl_LocalInvocationIndex]++;
                                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10049;
                                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                            } while (loopIdx0 < inputA.a[1]);
                        }
                    } else {
                        if (inputA.a[3] == 3) {
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1004e;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                        } else {
                        }
                    }
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10053;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    break;
                }
            }
            break;
        }
        case 2:
        case 3:
        {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10059;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            if (testBit(uvec4(0x987d2de, 0x211b278, 0xf3463852, 0x94df3666), gl_SubgroupInvocationID)) {
                for (int loopIdx0 = 0;;loopIdx0++,                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect()) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1005d;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    {
                        int loopIdx1 = 0;
                        do {
                            if (subgroupElect()) {
                                outputC.loc[gl_LocalInvocationIndex]++;
                                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10061;
                                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                                break;
                            }
                            loopIdx1++;
                        } while (true);
                    }
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10066;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    if (subgroupElect()) {
                    }
                    if (subgroupElect()) {
                        break;
                    }
                    if (inputA.a[1] == 1) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1006e;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    }
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10071;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    for (int loopIdx1 = 0;
                             loopIdx1 < gl_SubgroupInvocationID + 1;
                             loopIdx1++) {
                    }
                }
            }
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex5]) {
                for (int loopIdx0 = 0;;loopIdx0++,                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect()) {
                    if (gl_SubgroupInvocationID == loopIdx0) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1007a;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    }
                    if (subgroupElect()) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1007e;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                        break;
                    }
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10082;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    for (int loopIdx1 = 0;
                             loopIdx1 < gl_SubgroupInvocationID + 1;
                             loopIdx1++) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10085;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    }
                }
                for (int loopIdx0 = 0;
                         loopIdx0 < gl_SubgroupInvocationID + 1;
                         loopIdx0++) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1008a;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    if (testBit(uvec4(0x4dc2923c, 0xdc935c2f, 0x8f9e5516, 0xc383a7ce), gl_SubgroupInvocationID)) {
                        continue;
                    } else {
                        continue;
                    }
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10091;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    if (subgroupElect()) {
                    }
                }
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10097;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
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

    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10000;
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
        for (int loopIdx0 = 0;
                 loopIdx0 < gl_SubgroupInvocationID + 1;
                 loopIdx0++) {
            break;
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10005;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            if (gl_SubgroupInvocationID == loopIdx0) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10008;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                {
                    int loopIdx1 = 0;
                    do {
                        loopIdx1++;
                    } while (loopIdx1 < inputA.a[1]);
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000c;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000f;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                } else {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10012;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                }
            } else {
                break;
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10017;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
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


void main()
{

    switch (inputA.a[2]) {
        case 3:
        {
            break;
        }
        case 2:
        {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10004;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            if (testBit(uvec4(0x5c279566, 0x5b0364e5, 0xab19e77b, 0xdf709dc4), gl_SubgroupInvocationID)) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10007;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            } else {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000a;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            }
            {
                int loopIdx0 = 0;
                do {
                    if (subgroupElect()) {
                        break;
                    }
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10011;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    loopIdx0++;
                } while (true);
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10014;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            break;
        }
        case 4:
        {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10018;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001b;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            } else {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001e;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            }
            break;
        }
    }
    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10023;
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
            if (testBit(uvec4(0x7a4e2690, 0x432fc58e, 0x9b2bb71a, 0xc785c163), gl_SubgroupInvocationID)) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10003;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            } else {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10003;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            }
        } while (loopIdx0 < inputA.a[3]);
    }
    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000c;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        } else {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000f;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        }
    } else {
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10013;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        switch (gl_SubgroupInvocationID & 3) {
            case 0:
            case 1:
            {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10017;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                break;
            }
            case 2:
            case 3:
            {
                break;
            }
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
layout(constant_id = 12) const uint cmpIndex2 = 0u;
layout(constant_id = 13) const uint cmpIndex3 = 0u;


void main()
{

    if (testBit(uvec4(0x1f082002, 0xf140f2fe, 0xb896a0de, 0x808a57d0), gl_SubgroupInvocationID)) {
        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
        } else {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10003;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        }
        for (int loopIdx0 = 0;;loopIdx0++,        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true)) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10007;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            if (subgroupElect()) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000a;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                break;
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000e;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10011;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
    }
    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex2]) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10016;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        } else {
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001a;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
    } else {
        if (testBit(uvec4(0x24be39e6, 0xdcb39833, 0xe7e59864, 0xaaff4173), gl_SubgroupInvocationID)) {
        } else {
        }
        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex3]) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10021;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        } else {
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
    switch (inputA.a[0]) {
        case 1:
        {
            if (testBit(uvec4(0x20acbc5e, 0x3ac93720, 0xc31450d5, 0xdfc2e34e), gl_SubgroupInvocationID)) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10005;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            } else {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10008;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            }
            break;
        }
        case 0:
        {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000d;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            if (subgroupElect()) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10010;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            }
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10014;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            }
            break;
        }
        case 2:
        {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10019;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            {
                int loopIdx0 = 0;
                do {
                    loopIdx0++;
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001c;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                } while (loopIdx0 < inputA.a[1]);
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001f;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
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


void main()
{

    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10000;
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
    switch (inputA.a[0]) {
        case 1:
        {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10004;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            break;
        }
        case 0:
        {
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10009;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000c;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            break;
        }
        case 2:
        {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10010;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            {
                int loopIdx0 = 0;
                do {
                    loopIdx0++;
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10013;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                } while (loopIdx0 < inputA.a[5]);
            }
            break;
        }
    }
    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10018;
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
    if (testBit(uvec4(0xeb93571b, 0xd23ee0a9, 0xf2c07cfb, 0x8c5d2c), gl_SubgroupInvocationID)) {
        if (subgroupElect()) {
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001d;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        switch (inputA.a[2]) {
            case 3:
            {
                break;
            }
            case 2:
            {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10023;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                break;
            }
            case 4:
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
layout(local_size_x_id = 0, local_size_y_id = 1, local_size_z = 1) in;
layout(set=0, binding=2) coherent buffer OutputC { uint loc[]; } outputC;
layout(set=0, binding=1) coherent buffer OutputB { uvec4 b[]; } outputB;
layout(set=0, binding=0) coherent buffer InputA  { uint  a[]; } inputA;
layout(push_constant) uniform PC {
   // set to the real stride when writing out ballots, or zero when just counting
   int  invocationStride;
   // wildcard fields, for an example the dimensions of rendered area in the case of graphics shaders
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
        for (int loopIdx0 = 0;
                 loopIdx0 < gl_SubgroupInvocationID + 1;
                 loopIdx0++) {
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10005;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10008;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000b;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
    } else {
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000e;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
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
        if (subgroupElect()) {
        }
    }
    switch (gl_SubgroupInvocationID & 3) {
        case 0:
        case 1:
        {
            for (int loopIdx0 = 0;
                     loopIdx0 < inputA.a[3];
                     loopIdx0++) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10020;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10023;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            if (subgroupElect()) {
            }
            break;
        }
        case 2:
        case 3:
        {
            {
                int loopIdx0 = 0;
                do {
                    if (subgroupElect()) {
                        break;
                    }
                    loopIdx0++;
                } while (true);
            }
            if (inputA.a[3] == 3) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002f;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            } else {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10032;
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


void main()
{

    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
        for (int loopIdx0 = 0;
                 loopIdx0 < gl_SubgroupInvocationID + 1;
                 loopIdx0++) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10002;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        }
    }
    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10006;
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
    if (testBit(uvec4(0x2391070a, 0x7c9f6acd, 0x32b370b4, 0x107dbe47), gl_SubgroupInvocationID)) {
        if (testBit(uvec4(0xa1dd7c26, 0xdc8b0f06, 0x6342d0d2, 0x2f9c6461), gl_SubgroupInvocationID)) {
        } else {
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000c;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
    }
    if (testBit(uvec4(0xed6a2561, 0x5b7f8905, 0x1467e57d, 0x96b378c), gl_SubgroupInvocationID)) {
        if (inputA.a[2] == 2) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10011;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        } else {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10014;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        }
    } else {
        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
        } else {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001a;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        }
        for (int loopIdx0 = 0;
                 loopIdx0 < gl_SubgroupInvocationID + 1;
                 loopIdx0++) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001e;
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


void main()
{

    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10000;
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
    switch (gl_SubgroupInvocationID & 3) {
        case 0:
        case 1:
        {
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
            }
            {
                int loopIdx0 = 0;
                do {
                    loopIdx0++;
                } while (loopIdx0 < inputA.a[3]);
            }
            break;
        }
        case 2:
        case 3:
        {
            if (inputA.a[0] == 0) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000b;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            }
            for (int loopIdx0 = 0;
                     loopIdx0 < inputA.a[3];
                     loopIdx0++) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000f;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            }
            break;
        }
    }
    switch (inputA.a[3]) {
        case 4:
        {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10016;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            if (subgroupElect()) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10019;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            }
            break;
        }
        case 3:
        {
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001f;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10022;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            break;
        }
        case 5:
        {
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex2]) {
            } else {
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

    for (int loopIdx0 = 0;
             loopIdx0 < inputA.a[3];
             loopIdx0++) {
        if (inputA.a[2] == 2) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10002;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10005;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        if (subgroupElect()) {
        }
    }
    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000a;
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
    for (int loopIdx0 = 0;
             loopIdx0 < inputA.a[1];
             loopIdx0++) {
        if (inputA.a[1] == 1) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000e;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        } else {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10011;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        }
        for (int loopIdx1 = 0;;loopIdx1++,        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true)) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10015;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            if (subgroupElect()) {
                break;
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001a;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
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
layout(constant_id = 12) const uint cmpIndex2 = 0u;


void main()
{

    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10000;
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
    for (int loopIdx0 = 0;
             loopIdx0 < inputA.a[5];
             loopIdx0++) {
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10003;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        break;
        if (testBit(uvec4(0xf5200d72, 0xdc94acf1, 0x37427b06, 0x7b612795), gl_SubgroupInvocationID)) {
        }
    }
    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000a;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
    } else {
        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000f;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex2]) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10012;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        }
    }
    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10016;
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
    for (int loopIdx0 = 0;;loopIdx0++,    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true)) {
        {
            int loopIdx1 = 0;
            do {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001a;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                if (subgroupElect()) {
                    break;
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001f;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                loopIdx1++;
            } while (true);
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10022;
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
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002a;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                break;
            }
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002e;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        if (subgroupElect()) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10031;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            break;
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10035;
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


void main()
{

    if (testBit(uvec4(0x5c279566, 0x5b0364e5, 0xab19e77b, 0xdf709dc4), gl_SubgroupInvocationID)) {
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10001;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10004;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        } else {
            if (subgroupElect()) {
            }
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000a;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000d;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        }
    }
    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10011;
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
    {
        int loopIdx0 = 0;
        do {
            for (int loopIdx1 = 0;;loopIdx1++,            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true)) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10015;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                switch (inputA.a[2]) {
                    case 3:
                    {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10019;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        break;
                    }
                    case 2:
                    {
                        break;
                    }
                    case 4:
                    {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001f;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        break;
                    }
                }
                if (subgroupElect()) {
                    break;
                }
                {
                    int loopIdx2 = 0;
                    do {
                        if (subgroupElect()) {
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10028;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                            if (testBit(uvec4(0x576a093a, 0xdca27a4d, 0x94bc142d, 0xd92b5ff1), gl_SubgroupInvocationID)) {
                                break;
                            } else {
                                break;
                            }
                        }
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10030;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        loopIdx2++;
                    } while (true);
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10033;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                switch (inputA.a[4]) {
                    case 5:
                    {
                        break;
                    }
                    case 4:
                    {
                        break;
                    }
                    case 6:
                    {
                        break;
                    }
                }
            }
            if (subgroupElect()) {
                break;
            }
            if (testBit(uvec4(0xda273742, 0xbb2e665c, 0xbef28f40, 0xcbead8ea), gl_SubgroupInvocationID)) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10042;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                if (subgroupElect()) {
                }
            }
            if (subgroupElect()) {
                if (gl_SubgroupInvocationID == loopIdx0) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10049;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                } else {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1004c;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1004f;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                break;
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10052;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            }
            loopIdx0++;
        } while (true);
    }
    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10056;
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
            loopIdx0++;
            continue;
            if (testBit(uvec4(0x7a4e2690, 0x432fc58e, 0x9b2bb71a, 0xc785c163), gl_SubgroupInvocationID)) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10003;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                continue;
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10006;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                if (testBit(uvec4(0xec6f3c8, 0xdcaa4b2a, 0xcd523415, 0x8087be24), gl_SubgroupInvocationID)) {
                    continue;
                } else {
                    continue;
                }
            } else {
                if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000f;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
                switch (inputA.a[2]) {
                    case 3:
                    {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10014;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        break;
                    }
                    case 2:
                    {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10018;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        break;
                    }
                    case 4:
                    {
                        break;
                    }
                }
            }
        } while (loopIdx0 < inputA.a[3]);
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

    if (testBit(uvec4(0x1f082002, 0xf140f2fe, 0xb896a0de, 0x808a57d0), gl_SubgroupInvocationID)) {
        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10003;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            }
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex2]) {
            }
        } else {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10009;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            if (inputA.a[3] == 3) {
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000d;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10010;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        if (inputA.a[1] == 1) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10013;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            {
                int loopIdx0 = 0;
                do {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10016;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    if (subgroupElect()) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10019;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        break;
                    }
                    loopIdx0++;
                } while (true);
            }
        } else {
            if (inputA.a[0] == 0) {
            } else {
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10022;
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


void main()
{

    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10000;
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
    switch (inputA.a[0]) {
        case 1:
        {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10004;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            break;
        }
        case 0:
        {
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
                for (int loopIdx0 = 0;
                         loopIdx0 < gl_SubgroupInvocationID + 1;
                         loopIdx0++) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000a;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
            } else {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000e;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                if (subgroupElect()) {
                }
            }
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
                if (gl_LocalInvocationIndex >= inputA.a[cmpIndex2]) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10015;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                } else {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10018;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
                if (inputA.a[1] == 1) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001c;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                } else {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001c;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
            }
            break;
        }
        case 2:
        {
            for (int loopIdx0 = 0;
                     loopIdx0 < inputA.a[2];
                     loopIdx0++) {
                if (inputA.a[3] == 3) {
                } else {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10028;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002b;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002e;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
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


void main()
{

    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10000;
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
        for (int loopIdx0 = 0;
                 loopIdx0 < inputA.a[2];
                 loopIdx0++) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10004;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            if (subgroupElect()) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10007;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            }
            if (subgroupElect()) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000b;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            }
        }
    } else {
        if (subgroupElect()) {
            if (subgroupElect()) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10012;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10015;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            switch (gl_SubgroupInvocationID & 3) {
                case 0:
                {
                    break;
                }
                case 1:
                {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001b;
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
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10021;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    break;
                }
            }
        }
        for (int loopIdx0 = 0;;loopIdx0++,        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true)) {
            if (inputA.a[0] == 0) {
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10029;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            if (subgroupElect()) {
                break;
            }
            for (int loopIdx1 = 0;;loopIdx1++,            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true)) {
                if (subgroupElect()) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10030;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    break;
                }
            }
            switch (loopIdx0) {
                case 1: {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10037;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    break;
                }
                case 2: {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1003b;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    break;
                }
                default: {
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


void main()
{

    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
        for (int loopIdx0 = 0;
                 loopIdx0 < gl_SubgroupInvocationID + 1;
                 loopIdx0++) {
            if (testBit(uvec4(0x2391070a, 0x7c9f6acd, 0x32b370b4, 0x107dbe47), gl_SubgroupInvocationID)) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10003;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            } else {
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10007;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            break;
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000a;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        }
    } else {
        for (int loopIdx0 = 0;
                 loopIdx0 < gl_SubgroupInvocationID + 1;
                 loopIdx0++) {
            if (testBit(uvec4(0x2391070a, 0x7c9f6acd, 0x32b370b4, 0x107dbe47), gl_SubgroupInvocationID)) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10003;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            } else {
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10007;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            break;
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000a;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        }
    }
    {
        int loopIdx0 = 0;
        do {
            loopIdx0++;
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001c;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
                {
                    int loopIdx1 = 0;
                    do {
                        loopIdx1++;
                    } while (loopIdx1 < inputA.a[4]);
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10021;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                if (inputA.a[3] == 3) {
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
            } else {
                for (int loopIdx1 = 0;
                         loopIdx1 < gl_SubgroupInvocationID + 1;
                         loopIdx1++) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002e;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
                if (testBit(uvec4(0xa1dd7c26, 0xdc8b0f06, 0x6342d0d2, 0x2f9c6461), gl_SubgroupInvocationID)) {
                    continue;
                } else {
                    continue;
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10036;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
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


void main()
{

    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10000;
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
    switch (gl_SubgroupInvocationID & 3) {
        case 0:
        case 1:
        {
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
                if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
                }
            }
            switch (gl_SubgroupInvocationID & 3) {
                case 0:
                case 1:
                {
                    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex2]) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000b;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    }
                    {
                        int loopIdx0 = 0;
                        do {
                            loopIdx0++;
                        } while (loopIdx0 < inputA.a[2]);
                    }
                    break;
                }
                case 2:
                case 3:
                {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10012;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    {
                        int loopIdx0 = 0;
                        do {
                            loopIdx0++;
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10015;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        } while (loopIdx0 < inputA.a[4]);
                    }
                    break;
                }
            }
            break;
        }
        case 2:
        case 3:
        {
            if (subgroupElect()) {
                if (inputA.a[0] == 0) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001e;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
                if (testBit(uvec4(0x90a02a95, 0xc9aa12ee, 0x338888b3, 0x4ec35298), gl_SubgroupInvocationID)) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10022;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                } else {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10025;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10028;
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
layout(constant_id = 13) const uint cmpIndex3 = 0u;


void main()
{

    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10000;
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
        for (int loopIdx0 = 0;
                 loopIdx0 < gl_SubgroupInvocationID + 1;
                 loopIdx0++) {
            break;
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10005;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            if (gl_SubgroupInvocationID == loopIdx0) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10008;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            } else {
            }
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000d;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
    }
    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10010;
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10013;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
    } else {
        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex2]) {
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex3]) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10018;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            }
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


void main()
{

    {
        int loopIdx0 = 0;
        do {
            loopIdx0++;
            continue;
            if (testBit(uvec4(0x7a4e2690, 0x432fc58e, 0x9b2bb71a, 0xc785c163), gl_SubgroupInvocationID)) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10003;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                continue;
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10006;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                if (testBit(uvec4(0xec6f3c8, 0xdcaa4b2a, 0xcd523415, 0x8087be24), gl_SubgroupInvocationID)) {
                    continue;
                } else {
                    continue;
                }
            } else {
                if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
                    if (inputA.a[2] == 2) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10010;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    }
                    {
                        int loopIdx1 = 0;
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
                            loopIdx1++;
                        } while (true);
                    }
                } else {
                    for (int loopIdx1 = 0;;loopIdx1++,                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true)) {
                        if (subgroupElect()) {
                            break;
                        }
                    }
                    return;
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10024;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                if (subgroupElect()) {
                    for (int loopIdx1 = 0;
                             loopIdx1 < inputA.a[2];
                             loopIdx1++) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10028;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    }
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002b;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    switch (inputA.a[4]) {
                        case 5:
                        {
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002f;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                            break;
                        }
                        case 4:
                        {
                            break;
                        }
                        case 6:
                        {
                            break;
                        }
                    }
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10037;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1003a;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            }
        } while (loopIdx0 < inputA.a[3]);
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


void main()
{

    if (testBit(uvec4(0x1f082002, 0xf140f2fe, 0xb896a0de, 0x808a57d0), gl_SubgroupInvocationID)) {
        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
                {
                    int loopIdx0 = 0;
                    do {
                        loopIdx0++;
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10004;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    } while (loopIdx0 < inputA.a[4]);
                }
                if (testBit(uvec4(0x1f082002, 0xf140f2fe, 0xb896a0de, 0x808a57d0), gl_SubgroupInvocationID)) {
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
            } else {
                if (testBit(uvec4(0x20acbc5e, 0x3ac93720, 0xc31450d5, 0xdfc2e34e), gl_SubgroupInvocationID)) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10012;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                } else {
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
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex3]) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10023;
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
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10029;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        break;
                    }
                }
                {
                    int loopIdx0 = 0;
                    do {
                        if (subgroupElect()) {
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002f;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                            break;
                        }
                        loopIdx0++;
                    } while (true);
                }
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
                        break;
                    }
                    case 3:
                    {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1003d;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        break;
                    }
                }
                if (inputA.a[2] == 2) {
                }
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10044;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        }
        if (inputA.a[1] == 1) {
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex4]) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10049;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
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
                if (inputA.a[2] == 2) {
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10059;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1005c;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex5]) {
                for (int loopIdx0 = 0;
                         loopIdx0 < gl_SubgroupInvocationID + 1;
                         loopIdx0++) {
                }
                if (testBit(uvec4(0x20acbc5e, 0x3ac93720, 0xc31450d5, 0xdfc2e34e), gl_SubgroupInvocationID)) {
                } else {
                }
            } else {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10065;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                if (gl_LocalInvocationIndex >= inputA.a[cmpIndex6]) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10068;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                } else {
                }
            }
        }
    } else {
        for (int loopIdx0 = 0;
                 loopIdx0 < inputA.a[1];
                 loopIdx0++) {
            if (testBit(uvec4(0x20acbc5e, 0x3ac93720, 0xc31450d5, 0xdfc2e34e), gl_SubgroupInvocationID)) {
                if (inputA.a[1] == 1) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10072;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                } else {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10075;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
                if (subgroupElect()) {
                }
            } else {
                if (inputA.a[2] == 2) {
                }
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1007e;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            for (int loopIdx1 = 0;
                     loopIdx1 < gl_SubgroupInvocationID + 1;
                     loopIdx1++) {
                if (inputA.a[3] == 3) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10082;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                } else {
                }
                switch (gl_SubgroupInvocationID & 3) {
                    case 0:
                    {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10088;
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
            }
        }
        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex7]) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10095;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        } else {
            if (testBit(uvec4(0x1f082002, 0xf140f2fe, 0xb896a0de, 0x808a57d0), gl_SubgroupInvocationID)) {
                if (gl_LocalInvocationIndex >= inputA.a[cmpIndex8]) {
                }
                if (gl_LocalInvocationIndex >= inputA.a[cmpIndex9]) {
                } else {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1009d;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x100a0;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            }
            {
                int loopIdx0 = 0;
                do {
                    loopIdx0++;
                    {
                        int loopIdx1 = 0;
                        do {
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x100a5;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                            if (subgroupElect()) {
                                outputC.loc[gl_LocalInvocationIndex]++;
                                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x100a8;
                                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                                break;
                            }
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x100ac;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                            loopIdx1++;
                        } while (true);
                    }
                } while (loopIdx0 < inputA.a[3]);
            }
        }
    }
    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x100b2;
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
layout(constant_id = 17) const uint cmpIndex7 = 0u;


void main()
{

    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10000;
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
    switch (inputA.a[0]) {
        case 1:
        {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10004;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            break;
        }
        case 0:
        {
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
                for (int loopIdx0 = 0;
                         loopIdx0 < gl_SubgroupInvocationID + 1;
                         loopIdx0++) {
                    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000b;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    } else {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000e;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    }
                }
                if (inputA.a[0] == 0) {
                    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex2]) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10014;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    } else {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10017;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    }
                    if (testBit(uvec4(0xa6844fcd, 0xd7def1a2, 0x355598c3, 0xc483030c), gl_SubgroupInvocationID)) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001b;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    }
                } else {
                    for (int loopIdx0 = 0;;loopIdx0++,                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true)) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10020;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        if (subgroupElect()) {
                            break;
                        }
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10025;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    }
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10028;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
            } else {
                if (subgroupElect()) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002d;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex3]) {
                    }
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10032;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                if (subgroupElect()) {
                    switch (inputA.a[4]) {
                        case 5:
                        {
                            break;
                        }
                        case 4:
                        {
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10039;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                            break;
                        }
                        case 6:
                        {
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1003d;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                            break;
                        }
                    }
                }
            }
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex4]) {
                if (subgroupElect()) {
                    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex5]) {
                    } else {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10047;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    }
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1004a;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex6]) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1004d;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    } else {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1004d;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    }
                }
                {
                    int loopIdx0 = 0;
                    do {
                        loopIdx0++;
                        if (testBit(uvec4(0xa6844fcd, 0xd7def1a2, 0x355598c3, 0xc483030c), gl_SubgroupInvocationID)) {
                        } else {
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10057;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        }
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1005a;
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
                                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10060;
                                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                                break;
                            }
                        }
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10064;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    } while (loopIdx0 < inputA.a[1]);
                }
            } else {
                switch (inputA.a[2]) {
                    case 3:
                    {
                        break;
                    }
                    case 2:
                    {
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
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10072;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        {
                            int loopIdx0 = 0;
                            do {
                                if (subgroupElect()) {
                                    break;
                                }
                                outputC.loc[gl_LocalInvocationIndex]++;
                                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10078;
                                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                                loopIdx0++;
                            } while (true);
                        }
                        break;
                    }
                    case 4:
                    {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1007d;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        break;
                    }
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10081;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            }
            break;
        }
        case 2:
        {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10086;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            if (subgroupElect()) {
                if (inputA.a[1] == 1) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1008a;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex7]) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1008d;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    } else {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10090;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    }
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10094;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                for (int loopIdx0 = 0;
                         loopIdx0 < gl_SubgroupInvocationID + 1;
                         loopIdx0++) {
                    {
                        int loopIdx1 = 0;
                        do {
                            if (subgroupElect()) {
                                break;
                            }
                            loopIdx1++;
                        } while (true);
                    }
                    if (gl_SubgroupInvocationID == loopIdx0) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1009d;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    }
                }
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x100a2;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
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
layout(constant_id = 13) const uint cmpIndex3 = 0u;
layout(constant_id = 14) const uint cmpIndex4 = 0u;


void main()
{

    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10000;
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
        return;
        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
            if (testBit(uvec4(0xa4b4530d, 0x37ae9ec4, 0xee17c242, 0x339316d9), gl_SubgroupInvocationID)) {
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10007;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex2]) {
                {
                    int loopIdx0 = 0;
                    do {
                        if (subgroupElect()) {
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000c;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                            break;
                        }
                        loopIdx0++;
                    } while (true);
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10011;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            }
        }
    }
    {
        int loopIdx0 = 0;
        do {
            loopIdx0++;
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10017;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            if (subgroupElect()) {
                if (gl_LocalInvocationIndex >= inputA.a[cmpIndex3]) {
                    if (testBit(uvec4(0xab263b6d, 0xad0c39fa, 0x50fd028b, 0xa8d50e), gl_SubgroupInvocationID)) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001c;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    } else {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001f;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    }
                }
                if (gl_LocalInvocationIndex >= inputA.a[cmpIndex4]) {
                    if (inputA.a[1] == 1) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10025;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    }
                    if (subgroupElect()) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10029;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    }
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002c;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                } else {
                    if (inputA.a[2] == 2) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10025;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    }
                    if (subgroupElect()) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10029;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    }
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002c;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
            }
            if (gl_SubgroupInvocationID == loopIdx0) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1003c;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                if (testBit(uvec4(0xab263b6d, 0xad0c39fa, 0x50fd028b, 0xa8d50e), gl_SubgroupInvocationID)) {
                    switch (inputA.a[1]) {
                        case 2:
                        {
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10041;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                            break;
                        }
                        case 1:
                        {
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10045;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                            break;
                        }
                        case 3:
                        {
                            break;
                        }
                    }
                    break;
                } else {
                    for (int loopIdx1 = 0;
                             loopIdx1 < gl_SubgroupInvocationID + 1;
                             loopIdx1++) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1004e;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    }
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10051;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
                {
                    int loopIdx1 = 0;
                    do {
                        loopIdx1++;
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10055;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        {
                            int loopIdx2 = 0;
                            do {
                                loopIdx2++;
                            } while (loopIdx2 < inputA.a[2]);
                        }
                    } while (loopIdx1 < inputA.a[5]);
                }
            }
        } while (loopIdx0 < inputA.a[4]);
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


void main()
{

    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10000;
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
        for (int loopIdx0 = 0;
                 loopIdx0 < inputA.a[2];
                 loopIdx0++) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10004;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            if (subgroupElect()) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10007;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                continue;
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000b;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            switch (gl_SubgroupInvocationID & 3) {
                case 0:
                {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000f;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    for (int loopIdx1 = 0;;loopIdx1++,                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true)) {
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
                    break;
                }
                case 1:
                {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001c;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001f;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    } else {
                    }
                    break;
                }
                case 2:
                {
                    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex2]) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10026;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    } else {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10029;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    }
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002c;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    break;
                }
                case 3:
                {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10030;
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
                }
            }
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1003f;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        switch (gl_SubgroupInvocationID & 3) {
            case 0:
            {
                for (int loopIdx0 = 0;
                         loopIdx0 < inputA.a[5];
                         loopIdx0++) {
                    if (inputA.a[1] == 1) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10045;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    }
                }
                break;
            }
            case 1:
            {
                if (subgroupElect()) {
                    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex3]) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1004d;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    } else {
                    }
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10051;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex4]) {
                    }
                }
                break;
            }
            case 2:
            {
                if (inputA.a[2] == 2) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10059;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex5]) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1005c;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    } else {
                    }
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10060;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex6]) {
                    }
                }
                break;
            }
            case 3:
            {
                if (testBit(uvec4(0xf9c83953, 0xdc833ee1, 0x3b114bed, 0x77893a04), gl_SubgroupInvocationID)) {
                    if (testBit(uvec4(0x461ab27e, 0xfea00e58, 0xc9829b62, 0x787df9a3), gl_SubgroupInvocationID)) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10069;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    } else {
                    }
                    {
                        int loopIdx0 = 0;
                        do {
                            if (subgroupElect()) {
                                outputC.loc[gl_LocalInvocationIndex]++;
                                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1006f;
                                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                                break;
                            }
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10073;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                            loopIdx0++;
                        } while (true);
                    }
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10076;
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
layout(constant_id = 12) const uint cmpIndex2 = 0u;
layout(constant_id = 13) const uint cmpIndex3 = 0u;
layout(constant_id = 14) const uint cmpIndex4 = 0u;
layout(constant_id = 15) const uint cmpIndex5 = 0u;
layout(constant_id = 16) const uint cmpIndex6 = 0u;
layout(constant_id = 17) const uint cmpIndex7 = 0u;


void main()
{

    if (testBit(uvec4(0xed6a2561, 0x5b7f8905, 0x1467e57d, 0x96b378c), gl_SubgroupInvocationID)) {
        switch (gl_SubgroupInvocationID & 3) {
            case 0:
            case 1:
            {
                if (inputA.a[3] == 3) {
                    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10005;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    } else {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10008;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    }
                    if (testBit(uvec4(0xed6a2561, 0x5b7f8905, 0x1467e57d, 0x96b378c), gl_SubgroupInvocationID)) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000c;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    } else {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000c;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    }
                } else {
                    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10005;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    } else {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10008;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    }
                    if (testBit(uvec4(0xed6a2561, 0x5b7f8905, 0x1467e57d, 0x96b378c), gl_SubgroupInvocationID)) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000c;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    } else {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000c;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    }
                }
                if (gl_LocalInvocationIndex >= inputA.a[cmpIndex2]) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10023;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex3]) {
                    }
                }
                break;
            }
            case 2:
            case 3:
            {
                for (int loopIdx0 = 0;
                         loopIdx0 < inputA.a[5];
                         loopIdx0++) {
                    if (inputA.a[0] == 0) {
                    }
                    if (gl_SubgroupInvocationID == loopIdx0) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002e;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    } else {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10031;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    }
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10035;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                if (inputA.a[0] == 0) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10038;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1003b;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                break;
            }
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1003f;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
    } else {
        switch (gl_SubgroupInvocationID & 3) {
            case 0:
            case 1:
            {
                if (inputA.a[3] == 3) {
                    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex4]) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10005;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    } else {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10008;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    }
                    if (testBit(uvec4(0xed6a2561, 0x5b7f8905, 0x1467e57d, 0x96b378c), gl_SubgroupInvocationID)) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000c;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    } else {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000c;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    }
                } else {
                    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex5]) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10005;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    } else {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10008;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    }
                    if (testBit(uvec4(0xed6a2561, 0x5b7f8905, 0x1467e57d, 0x96b378c), gl_SubgroupInvocationID)) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000c;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    } else {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000c;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    }
                }
                if (gl_LocalInvocationIndex >= inputA.a[cmpIndex6]) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10023;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex7]) {
                    }
                }
                break;
            }
            case 2:
            case 3:
            {
                for (int loopIdx0 = 0;
                         loopIdx0 < inputA.a[5];
                         loopIdx0++) {
                    if (inputA.a[0] == 0) {
                    }
                    if (gl_SubgroupInvocationID == loopIdx0) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002e;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    } else {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10031;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    }
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10035;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                if (inputA.a[2] == 2) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10038;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1003b;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                break;
            }
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1003f;
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
layout(constant_id = 14) const uint cmpIndex4 = 0u;
layout(constant_id = 15) const uint cmpIndex5 = 0u;


void main()
{

    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10000;
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
    switch (gl_SubgroupInvocationID & 3) {
        case 0:
        case 1:
        {
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
                if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
                    if (inputA.a[3] == 3) {
                    }
                    {
                        int loopIdx0 = 0;
                        do {
                            if (subgroupElect()) {
                                outputC.loc[gl_LocalInvocationIndex]++;
                                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000a;
                                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                                break;
                            }
                            loopIdx0++;
                        } while (true);
                    }
                }
            }
            switch (inputA.a[3]) {
                case 4:
                {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10013;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    if (subgroupElect()) {
                        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex2]) {
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10017;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        } else {
                        }
                    }
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001c;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    break;
                }
                case 3:
                {
                    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex3]) {
                        for (int loopIdx0 = 0;
                                 loopIdx0 < gl_SubgroupInvocationID + 1;
                                 loopIdx0++) {
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10022;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        }
                    } else {
                        switch (gl_SubgroupInvocationID & 3) {
                            case 0:
                            case 1:
                            {
                                outputC.loc[gl_LocalInvocationIndex]++;
                                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10028;
                                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                                break;
                            }
                            case 2:
                            case 3:
                            {
                                outputC.loc[gl_LocalInvocationIndex]++;
                                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002c;
                                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                                break;
                            }
                        }
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10030;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex4]) {
                        } else {
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10034;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        }
                    }
                    {
                        int loopIdx0 = 0;
                        do {
                            loopIdx0++;
                            if (subgroupElect()) {
                            }
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1003b;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                            break;
                        } while (loopIdx0 < inputA.a[3]);
                    }
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1003f;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    break;
                }
                case 5:
                {
                    if (inputA.a[2] == 2) {
                        if (testBit(uvec4(0x90a02a95, 0xc9aa12ee, 0x338888b3, 0x4ec35298), gl_SubgroupInvocationID)) {
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10045;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        }
                        {
                            int loopIdx0 = 0;
                            do {
                                loopIdx0++;
                                outputC.loc[gl_LocalInvocationIndex]++;
                                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10049;
                                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                            } while (loopIdx0 < inputA.a[1]);
                        }
                    } else {
                        if (inputA.a[3] == 3) {
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1004e;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        } else {
                        }
                    }
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10053;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    break;
                }
            }
            break;
        }
        case 2:
        case 3:
        {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10059;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            if (testBit(uvec4(0x987d2de, 0x211b278, 0xf3463852, 0x94df3666), gl_SubgroupInvocationID)) {
                for (int loopIdx0 = 0;;loopIdx0++,                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true)) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1005d;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    {
                        int loopIdx1 = 0;
                        do {
                            if (subgroupElect()) {
                                outputC.loc[gl_LocalInvocationIndex]++;
                                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10061;
                                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                                break;
                            }
                            loopIdx1++;
                        } while (true);
                    }
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10066;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    if (subgroupElect()) {
                    }
                    if (subgroupElect()) {
                        break;
                    }
                    if (inputA.a[1] == 1) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1006e;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    }
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10071;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    for (int loopIdx1 = 0;
                             loopIdx1 < gl_SubgroupInvocationID + 1;
                             loopIdx1++) {
                    }
                }
            }
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex5]) {
                for (int loopIdx0 = 0;;loopIdx0++,                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true)) {
                    if (gl_SubgroupInvocationID == loopIdx0) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1007a;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    }
                    if (subgroupElect()) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1007e;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        break;
                    }
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10082;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    for (int loopIdx1 = 0;
                             loopIdx1 < gl_SubgroupInvocationID + 1;
                             loopIdx1++) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10085;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    }
                }
                for (int loopIdx0 = 0;
                         loopIdx0 < gl_SubgroupInvocationID + 1;
                         loopIdx0++) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1008a;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    if (testBit(uvec4(0x4dc2923c, 0xdc935c2f, 0x8f9e5516, 0xc383a7ce), gl_SubgroupInvocationID)) {
                        continue;
                    } else {
                        continue;
                    }
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10091;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    if (subgroupElect()) {
                    }
                }
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10097;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
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

    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10000;
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
        for (int loopIdx0 = 0;
                 loopIdx0 < gl_SubgroupInvocationID + 1;
                 loopIdx0++) {
            break;
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10005;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            if (gl_SubgroupInvocationID == loopIdx0) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10008;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                {
                    int loopIdx1 = 0;
                    do {
                        loopIdx1++;
                    } while (loopIdx1 < inputA.a[1]);
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000c;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000f;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                } else {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10012;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
            } else {
                break;
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10017;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
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
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10023;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
    }



}
