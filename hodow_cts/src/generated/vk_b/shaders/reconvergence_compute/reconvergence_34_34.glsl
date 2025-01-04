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
        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10003;
        } else {
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10007;
        if (inputA.a[3] == 3) {
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        }
    }
    for (int loopIdx0 = 0;;loopIdx0++,    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true)) {
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        {
            int loopIdx1 = 0;
            do {
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10010;
                if (subgroupElect()) {
                    break;
                }
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10015;
                loopIdx1++;
            } while (true);
        }
        if (gl_SubgroupInvocationID == loopIdx0) {
        }
        if (subgroupElect()) {
            break;
        }
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex2]) {
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001f;
        }
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10022;
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

    if (inputA.a[2] == 2) {
        {
            int loopIdx0 = 0;
            do {
                loopIdx0++;
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10002;
            } while (loopIdx0 < inputA.a[3]);
        }
        if (inputA.a[3] == 3) {
        } else {
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        }
    }
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
    if (inputA.a[3] == 3) {
        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000e;
        if (subgroupElect()) {
        }
    }
    {
        int loopIdx0 = 0;
        do {
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10015;
            } else {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10017;
            }
            if (gl_SubgroupInvocationID == loopIdx0) {
            }
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            if (subgroupElect()) {
                break;
            }
            if (gl_SubgroupInvocationID == loopIdx0) {
            }
            {
                int loopIdx1 = 0;
                do {
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10023;
                    if (subgroupElect()) {
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        break;
                    }
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10029;
                    loopIdx1++;
                } while (true);
            }
            loopIdx0++;
        } while (true);
    }
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002d;



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
    for (int loopIdx0 = 0;
             loopIdx0 < inputA.a[1];
             loopIdx0++) {
        if (testBit(uvec4(0xaa771a7e, 0xdcb3e81d, 0x692e392c, 0x24367332), gl_SubgroupInvocationID)) {
            continue;
        } else {
            continue;
        }
        if (subgroupElect()) {
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        }
    }
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000c;
    {
        int loopIdx0 = 0;
        do {
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            for (int loopIdx1 = 0;;loopIdx1++,            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true)) {
                if (subgroupElect()) {
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10012;
                    break;
                }
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            }
            if (subgroupElect()) {
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                break;
            }
            {
                int loopIdx1 = 0;
                do {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001c;
                    if (subgroupElect()) {
                        break;
                    }
                    loopIdx1++;
                } while (true);
            }
            if (gl_SubgroupInvocationID == loopIdx0) {
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            } else {
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
    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10001;
    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10003;
        for (int loopIdx0 = 0;
                 loopIdx0 < inputA.a[4];
                 loopIdx0++) {
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10006;
        }
    } else {
        for (int loopIdx0 = 0;
                 loopIdx0 < inputA.a[4];
                 loopIdx0++) {
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        }
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        if (inputA.a[2] == 2) {
        }
    }
    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex2]) {
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10015;
    }
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10018;
    if (testBit(uvec4(0xe8b71b60, 0x17871b8, 0x2f9b730c, 0x5b7e9f39), gl_SubgroupInvocationID)) {
        if (subgroupElect()) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001b;
        }
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex3]) {
        }
    } else {
    }
    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10022;



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
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10007;
                break;
            }
            case 6:
            {
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                break;
            }
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000d;
        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
        }
    }
    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10011;
    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
        switch (gl_SubgroupInvocationID & 3) {
            case 0:
            {
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
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                break;
            }
            case 3:
            {
                break;
            }
        }
        switch (inputA.a[4]) {
            case 5:
            {
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10022;
                break;
            }
            case 4:
            {
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                break;
            }
            case 6:
            {
                break;
            }
        }
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
    } else {
        switch (gl_SubgroupInvocationID & 3) {
            case 0:
            {
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
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                break;
            }
            case 3:
            {
                break;
            }
        }
        switch (inputA.a[4]) {
            case 5:
            {
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10022;
                break;
            }
            case 4:
            {
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                break;
            }
            case 6:
            {
                break;
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


void main()
[[maximally_reconverges]]
{

    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10002;
    for (int loopIdx0 = 0;
             loopIdx0 < inputA.a[5];
             loopIdx0++) {
        {
            int loopIdx1 = 0;
            do {
                loopIdx1++;
            } while (loopIdx1 < inputA.a[2]);
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10006;
    }
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
    {
        int loopIdx0 = 0;
        do {
            loopIdx0++;
            if (subgroupElect()) {
            }
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            for (int loopIdx1 = 0;
                     loopIdx1 < gl_SubgroupInvocationID + 1;
                     loopIdx1++) {
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            }
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        } while (loopIdx0 < inputA.a[3]);
    }
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
    {
        int loopIdx0 = 0;
        do {
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            if (inputA.a[0] == 12345) {
                while (true) {
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10016;
            if (subgroupElect()) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10018;
                break;
            }
            {
                int loopIdx1 = 0;
                do {
                    loopIdx1++;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001d;
                } while (loopIdx1 < inputA.a[3]);
            }
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
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
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002b;
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


void main()
[[maximally_reconverges]]
{

    switch (gl_SubgroupInvocationID & 3) {
        case 0:
        {
            {
                int loopIdx0 = 0;
                do {
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    if (subgroupElect()) {
                        break;
                    }
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    loopIdx0++;
                } while (true);
            }
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            break;
        }
        case 1:
        {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000c;
            break;
        }
        case 2:
        {
            for (int loopIdx0 = 0;
                     loopIdx0 < gl_SubgroupInvocationID + 1;
                     loopIdx0++) {
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10011;
            }
            break;
        }
        case 3:
        {
            if (testBit(uvec4(0xe6375dad, 0xc9d99e62, 0x6a71d594, 0xdb41b3c8), gl_SubgroupInvocationID)) {
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10018;
            break;
        }
    }
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
    if (testBit(uvec4(0x33d89e45, 0x6f5e7c36, 0x1e8005e, 0xe5d1b405), gl_SubgroupInvocationID)) {
        if (inputA.a[1] == 1) {
        }
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10020;
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


void main()
[[maximally_reconverges]]
{

    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
    if (subgroupElect()) {
        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10004;
        } else {
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        }
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000a;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        } else {
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000e;
        }
    }
    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10011;
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
    for (int loopIdx0 = 0;
             loopIdx0 < inputA.a[5];
             loopIdx0++) {
        if (testBit(uvec4(0xf36c0148, 0x4cdb4c57, 0x8807fd23, 0xd247210b), gl_SubgroupInvocationID)) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10015;
        } else {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10015;
        }
        if (inputA.a[2] == 2) {
        }
    }
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
    {
        int loopIdx0 = 0;
        do {
            loopIdx0++;
            if (inputA.a[1] == 1) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001f;
            } else {
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10022;
            for (int loopIdx1 = 0;
                     loopIdx1 < gl_SubgroupInvocationID + 1;
                     loopIdx1++) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10024;
            }
        } while (loopIdx0 < inputA.a[5]);
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

    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        } else {
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            if (inputA.a[3] == 3) {
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            } else {
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            }
        }
    }
    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000c;
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
    switch (inputA.a[0]) {
        case 1:
        {
            if (inputA.a[0] == 0) {
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                {
                    int loopIdx0 = 0;
                    do {
                        loopIdx0++;
                    } while (loopIdx0 < inputA.a[4]);
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
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001d;
                        break;
                    }
                }
            } else {
                if (testBit(uvec4(0xc2817245, 0xbe5ff15e, 0x8692675c, 0x94c5e4ac), gl_SubgroupInvocationID)) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10022;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                } else {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10022;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                if (gl_LocalInvocationIndex >= inputA.a[cmpIndex2]) {
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                } else {
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
            }
            break;
        }
        case 0:
        {
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            {
                int loopIdx0 = 0;
                do {
                    for (int loopIdx1 = 0;
                             loopIdx1 < gl_SubgroupInvocationID + 1;
                             loopIdx1++) {
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    }
                    if (testBit(uvec4(0xd7651b04, 0xf4522c5e, 0x34f51043, 0x708fbae2), gl_SubgroupInvocationID)) {
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    }
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1003a;
                    if (subgroupElect()) {
                        break;
                    }
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    break;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    for (int loopIdx1 = 0;
                             loopIdx1 < inputA.a[3];
                             loopIdx1++) {
                    }
                    loopIdx0++;
                } while (true);
            }
            break;
        }
        case 2:
        {
            switch (inputA.a[4]) {
                case 5:
                {
                    for (int loopIdx0 = 0;
                             loopIdx0 < gl_SubgroupInvocationID + 1;
                             loopIdx0++) {
                    }
                    break;
                }
                case 4:
                {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1004c;
                    break;
                }
                case 6:
                {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1004f;
                    break;
                }
            }
            break;
        }
    }
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10055;



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

    if (inputA.a[1] == 1) {
        {
            int loopIdx0 = 0;
            do {
                loopIdx0++;
                if (inputA.a[3] == 3) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10003;
                }
                if (testBit(uvec4(0xbc435729, 0x515db618, 0xfbddefa, 0xc044afed), gl_SubgroupInvocationID)) {
                } else {
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10008;
            } while (loopIdx0 < inputA.a[3]);
        }
        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            if (inputA.a[1] == 1) {
            } else {
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000f;
            }
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        }
    } else {
        if (inputA.a[0] == 0) {
            switch (gl_SubgroupInvocationID & 3) {
                case 0:
                {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10017;
                    break;
                }
                case 1:
                {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001a;
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
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10022;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        } else {
            if (subgroupElect()) {
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
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    break;
                }
            }
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        }
    }
    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10036;



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
    for (int loopIdx0 = 0;
             loopIdx0 < inputA.a[1];
             loopIdx0++) {
        if (testBit(uvec4(0xaa771a7e, 0xdcb3e81d, 0x692e392c, 0x24367332), gl_SubgroupInvocationID)) {
            continue;
        } else {
            continue;
        }
        if (subgroupElect()) {
            if (subgroupElect()) {
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000a;
            continue;
        }
    }
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
    if (testBit(uvec4(0x9020d042, 0x8d315ce1, 0xe0d3cfa8, 0xa130abac), gl_SubgroupInvocationID)) {
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        for (int loopIdx0 = 0;;loopIdx0++,        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true)) {
            if (subgroupElect()) {
            }
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10015;
            if (subgroupElect()) {
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                break;
            }
            switch (inputA.a[3]) {
                case 4:
                {
                    break;
                }
                case 3:
                {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001e;
                    break;
                }
                case 5:
                {
                    break;
                }
            }
        }
        for (int loopIdx0 = 0;
                 loopIdx0 < gl_SubgroupInvocationID + 1;
                 loopIdx0++) {
            if (inputA.a[1] == 1) {
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            } else {
            }
            for (int loopIdx1 = 0;
                     loopIdx1 < inputA.a[4];
                     loopIdx1++) {
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            }
        }
    } else {
        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
            {
                int loopIdx0 = 0;
                do {
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    if (subgroupElect()) {
                        break;
                    }
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10034;
                    loopIdx0++;
                } while (true);
            }
        } else {
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            } else {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1003a;
            }
            {
                int loopIdx0 = 0;
                do {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1003d;
                    if (subgroupElect()) {
                        break;
                    }
                    loopIdx0++;
                } while (true);
            }
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
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


void main()
[[maximally_reconverges]]
{

    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10001;
    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10003;
        for (int loopIdx0 = 0;
                 loopIdx0 < inputA.a[4];
                 loopIdx0++) {
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
            if (gl_SubgroupInvocationID == loopIdx0) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000d;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            } else {
            }
        }
    } else {
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10003;
        for (int loopIdx0 = 0;
                 loopIdx0 < inputA.a[4];
                 loopIdx0++) {
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
            if (gl_SubgroupInvocationID == loopIdx0) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000d;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            } else {
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


void main()
[[maximally_reconverges]]
{

    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
    if (subgroupElect()) {
        switch (inputA.a[4]) {
            case 5:
            {
                break;
            }
            case 4:
            {
                for (int loopIdx0 = 0;;loopIdx0++,                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true)) {
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    if (subgroupElect()) {
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        break;
                    }
                }
                break;
            }
            case 6:
            {
                for (int loopIdx0 = 0;
                         loopIdx0 < gl_SubgroupInvocationID + 1;
                         loopIdx0++) {
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                break;
            }
        }
        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
            {
                int loopIdx0 = 0;
                do {
                    if (subgroupElect()) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10019;
                        break;
                    }
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001d;
                    loopIdx0++;
                } while (true);
            }
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            } else {
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            }
        } else {
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex2]) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10026;
            } else {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10028;
            }
            if (subgroupElect()) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002b;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            }
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
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


void main()
[[maximally_reconverges]]
{

    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10002;
    for (int loopIdx0 = 0;
             loopIdx0 < inputA.a[5];
             loopIdx0++) {
        {
            int loopIdx1 = 0;
            do {
                loopIdx1++;
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
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        break;
                    }
                }
                if (inputA.a[0] == 0) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10012;
                }
            } while (loopIdx1 < inputA.a[2]);
        }
    }
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
    if (inputA.a[1] == 1) {
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        {
            int loopIdx0 = 0;
            do {
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                if (inputA.a[0] == 12345) {
                    while (true) {
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    }
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001c;
                if (subgroupElect()) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001e;
                    break;
                }
                {
                    int loopIdx1 = 0;
                    do {
                        loopIdx1++;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10023;
                    } while (loopIdx1 < inputA.a[3]);
                }
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
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
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10031;
                loopIdx0++;
            } while (true);
        }
    } else {
        return;
        for (int loopIdx0 = 0;
                 loopIdx0 < gl_SubgroupInvocationID + 1;
                 loopIdx0++) {
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            if (inputA.a[0] == 0) {
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            } else {
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
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
layout(constant_id = 11) const uint cmpIndex1 = 0u;


void main()
[[maximally_reconverges]]
{

    switch (gl_SubgroupInvocationID & 3) {
        case 0:
        {
            {
                int loopIdx0 = 0;
                do {
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    if (gl_SubgroupInvocationID == loopIdx0) {
                    }
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    if (inputA.a[2] == 2) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10008;
                    } else {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10008;
                    }
                    if (subgroupElect()) {
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000e;
                        break;
                    }
                    switch (loopIdx0) {
                        case 1: {
                            break;
                        }
                        case 2: {
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10016;
                            break;
                        }
                        default: {
                            break;
                        }
                    }
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    if (inputA.a[2] == 2) {
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    } else {
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    }
                    loopIdx0++;
                } while (true);
            }
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
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
                {
                    int loopIdx0 = 0;
                    do {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002a;
                        if (subgroupElect()) {
                            break;
                        }
                        loopIdx0++;
                    } while (true);
                }
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            }
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            break;
        }
        case 3:
        {
            if (inputA.a[1] == 1) {
                if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            } else {
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1003b;
                for (int loopIdx0 = 0;;loopIdx0++,                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true)) {
                    if (subgroupElect()) {
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        break;
                    }
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10041;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            }
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            break;
        }
    }
    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10049;



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
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
    if (subgroupElect()) {
        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
            for (int loopIdx0 = 0;;loopIdx0++,            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true)) {
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                if (subgroupElect()) {
                    break;
                }
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000a;
            }
            {
                int loopIdx0 = 0;
                do {
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000e;
                    if (subgroupElect()) {
                        break;
                    }
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    loopIdx0++;
                } while (true);
            }
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        } else {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10016;
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            } else {
            }
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex2]) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001d;
            }
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10020;
        for (int loopIdx0 = 0;
                 loopIdx0 < inputA.a[2];
                 loopIdx0++) {
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
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002e;
            if (gl_SubgroupInvocationID == loopIdx0) {
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            } else {
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            }
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10036;
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
        void func0() {
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex3]) {
                if (subgroupElect()) {
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                for (int loopIdx0 = 0;
                         loopIdx0 < inputA.a[4];
                         loopIdx0++) {
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002f;
                }
            } else {
                if (gl_LocalInvocationIndex >= inputA.a[cmpIndex4]) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10033;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10036;
                if (inputA.a[1] == 1) {
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
            }
            if (testBit(uvec4(0xaee27654, 0x51a0fa5f, 0x3f5cfafd, 0xa3b791c0), gl_SubgroupInvocationID)) {
                for (int loopIdx0 = 0;
                         loopIdx0 < inputA.a[5];
                         loopIdx0++) {
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
                if (subgroupElect()) {
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10041;
                }
            } else {
                {
                    int loopIdx0 = 0;
                    do {
                        if (subgroupElect()) {
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10047;
                            break;
                        }
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1004b;
                        loopIdx0++;
                    } while (true);
                }
                if (testBit(uvec4(0xd49506e6, 0x69788d4b, 0x13e034bc, 0xcbb3b425), gl_SubgroupInvocationID)) {
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                } else {
                }
            }
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        }


void main()
[[maximally_reconverges]]
{

    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        } else {
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            if (inputA.a[1] == 1) {
                for (int loopIdx0 = 0;;loopIdx0++,                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true)) {
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10008;
                    if (subgroupElect()) {
                        break;
                    }
                }
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000e;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            switch (inputA.a[0]) {
                case 1:
                {
                    if (inputA.a[3] == 3) {
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10014;
                    } else {
                    }
                    break;
                }
                case 0:
                {
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    break;
                }
                case 2:
                {
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex2]) {
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    }
                    break;
                }
            }
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10023;
        }
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10026;
        func0();
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

    if (inputA.a[3] == 3) {
        {
            int loopIdx0 = 0;
            do {
                loopIdx0++;
                if (inputA.a[3] == 3) {
                    if (gl_SubgroupInvocationID == loopIdx0) {
                    } else {
                    }
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
                continue;
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10009;
            } while (loopIdx0 < inputA.a[3]);
        }
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000c;
        if (subgroupElect()) {
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
                if (inputA.a[0] == 0) {
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10012;
                if (testBit(uvec4(0x9181cd83, 0xdcab9b30, 0x521a842f, 0x1fc09387), gl_SubgroupInvocationID)) {
                } else {
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10016;
                }
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001a;
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001c;
    } else {
        if (testBit(uvec4(0xbc435729, 0x515db618, 0xfbddefa, 0xc044afed), gl_SubgroupInvocationID)) {
            {
                int loopIdx0 = 0;
                do {
                    if (subgroupElect()) {
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    }
                    for (int loopIdx1 = 0;
                             loopIdx1 < inputA.a[4];
                             loopIdx1++) {
                    }
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10025;
                    if (subgroupElect()) {
                        break;
                    }
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002a;
                    if (inputA.a[1] == 1) {
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    } else {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002e;
                    }
                    loopIdx0++;
                } while (true);
            }
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            {
                int loopIdx0 = 0;
                do {
                    loopIdx0++;
                    if (inputA.a[0] == 0) {
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    }
                    if (testBit(uvec4(0x4d9ac54c, 0xd2e8e747, 0xd060f6db, 0x56dd3bd3), gl_SubgroupInvocationID)) {
                    } else {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10038;
                    }
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1003a;
                } while (loopIdx0 < inputA.a[5]);
            }
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1003d;
        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
            switch (gl_SubgroupInvocationID & 3) {
                case 0:
                {
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex2]) {
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    } else {
                    }
                    break;
                }
                case 1:
                {
                    if (inputA.a[0] == 0) {
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    } else {
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1004c;
                    }
                    break;
                }
                case 2:
                {
                    if (subgroupElect()) {
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    }
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10054;
                    break;
                }
                case 3:
                {
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    break;
                }
            }
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            if (inputA.a[1] == 1) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1005c;
                if (testBit(uvec4(0xde0cfc02, 0x4527e14f, 0xb6b1b370, 0x61b047b3), gl_SubgroupInvocationID)) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1005e;
                } else {
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            } else {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1005c;
                if (testBit(uvec4(0xde0cfc02, 0x4527e14f, 0xb6b1b370, 0x61b047b3), gl_SubgroupInvocationID)) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1005e;
                } else {
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
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


void main()
[[maximally_reconverges]]
{

    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
    for (int loopIdx0 = 0;
             loopIdx0 < inputA.a[1];
             loopIdx0++) {
        if (testBit(uvec4(0xaa771a7e, 0xdcb3e81d, 0x692e392c, 0x24367332), gl_SubgroupInvocationID)) {
            continue;
        } else {
            continue;
        }
        if (subgroupElect()) {
            if (subgroupElect()) {
                for (int loopIdx1 = 0;
                         loopIdx1 < inputA.a[1];
                         loopIdx1++) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000a;
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000c;
                {
                    int loopIdx1 = 0;
                    do {
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        if (subgroupElect()) {
                            break;
                        }
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10013;
                        loopIdx1++;
                    } while (true);
                }
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            }
            if (testBit(uvec4(0xaa771a7e, 0xdcb3e81d, 0x692e392c, 0x24367332), gl_SubgroupInvocationID)) {
                break;
                if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                } else {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001c;
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

    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10001;
    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10003;
        for (int loopIdx0 = 0;
                 loopIdx0 < inputA.a[4];
                 loopIdx0++) {
            {
                int loopIdx1 = 0;
                do {
                    if (inputA.a[3] == 3) {
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    } else {
                    }
                    if (testBit(uvec4(0xcc6662ac, 0xdcbb39e6, 0xf7e9854, 0x42271730), gl_SubgroupInvocationID)) {
                        break;
                    } else {
                        break;
                    }
                    if (subgroupElect()) {
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        break;
                    }
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    {
                        int loopIdx2 = 0;
                        do {
                            loopIdx2++;
                        } while (loopIdx2 < inputA.a[2]);
                    }
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    if (inputA.a[0] == 0) {
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    } else {
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001b;
                    }
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001e;
                    loopIdx1++;
                } while (true);
            }
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            break;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        }
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        if (testBit(uvec4(0xcc6662ac, 0xdcbb39e6, 0xf7e9854, 0x42271730), gl_SubgroupInvocationID)) {
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            {
                int loopIdx0 = 0;
                do {
                    loopIdx0++;
                    {
                        int loopIdx1 = 0;
                        do {
                            loopIdx1++;
                        } while (loopIdx1 < inputA.a[3]);
                    }
                    break;
                } while (loopIdx0 < inputA.a[5]);
            }
            {
                int loopIdx0 = 0;
                do {
                    loopIdx0++;
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002d;
                    if (subgroupElect()) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002f;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    }
                    if (testBit(uvec4(0xf58394bb, 0xa0fe454, 0x7420162c, 0x8f6783ac), gl_SubgroupInvocationID)) {
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    } else {
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    }
                } while (loopIdx0 < inputA.a[3]);
            }
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        } else {
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            {
                int loopIdx0 = 0;
                do {
                    loopIdx0++;
                    {
                        int loopIdx1 = 0;
                        do {
                            loopIdx1++;
                        } while (loopIdx1 < inputA.a[3]);
                    }
                    break;
                } while (loopIdx0 < inputA.a[5]);
            }
            {
                int loopIdx0 = 0;
                do {
                    loopIdx0++;
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002d;
                    if (subgroupElect()) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002f;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    }
                    if (testBit(uvec4(0xf58394bb, 0xa0fe454, 0x7420162c, 0x8f6783ac), gl_SubgroupInvocationID)) {
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    } else {
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    }
                } while (loopIdx0 < inputA.a[3]);
            }
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1004e;
    } else {
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10003;
        for (int loopIdx0 = 0;
                 loopIdx0 < inputA.a[4];
                 loopIdx0++) {
            {
                int loopIdx1 = 0;
                do {
                    if (inputA.a[0] == 0) {
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    } else {
                    }
                    if (testBit(uvec4(0xcc6662ac, 0xdcbb39e6, 0xf7e9854, 0x42271730), gl_SubgroupInvocationID)) {
                        break;
                    } else {
                        break;
                    }
                    if (subgroupElect()) {
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        break;
                    }
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    {
                        int loopIdx2 = 0;
                        do {
                            loopIdx2++;
                        } while (loopIdx2 < inputA.a[2]);
                    }
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    if (inputA.a[1] == 1) {
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    } else {
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001b;
                    }
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001e;
                    loopIdx1++;
                } while (true);
            }
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            break;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        }
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        if (testBit(uvec4(0xcc6662ac, 0xdcbb39e6, 0xf7e9854, 0x42271730), gl_SubgroupInvocationID)) {
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            {
                int loopIdx0 = 0;
                do {
                    loopIdx0++;
                    {
                        int loopIdx1 = 0;
                        do {
                            loopIdx1++;
                        } while (loopIdx1 < inputA.a[3]);
                    }
                    break;
                } while (loopIdx0 < inputA.a[5]);
            }
            {
                int loopIdx0 = 0;
                do {
                    loopIdx0++;
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002d;
                    if (subgroupElect()) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002f;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    }
                    if (testBit(uvec4(0xf58394bb, 0xa0fe454, 0x7420162c, 0x8f6783ac), gl_SubgroupInvocationID)) {
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    } else {
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    }
                } while (loopIdx0 < inputA.a[3]);
            }
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        } else {
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            {
                int loopIdx0 = 0;
                do {
                    loopIdx0++;
                    {
                        int loopIdx1 = 0;
                        do {
                            loopIdx1++;
                        } while (loopIdx1 < inputA.a[3]);
                    }
                    break;
                } while (loopIdx0 < inputA.a[5]);
            }
            {
                int loopIdx0 = 0;
                do {
                    loopIdx0++;
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002d;
                    if (subgroupElect()) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002f;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    }
                    if (testBit(uvec4(0xf58394bb, 0xa0fe454, 0x7420162c, 0x8f6783ac), gl_SubgroupInvocationID)) {
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    } else {
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    }
                } while (loopIdx0 < inputA.a[3]);
            }
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1004e;
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
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
    if (subgroupElect()) {
        switch (inputA.a[4]) {
            case 5:
            {
                break;
            }
            case 4:
            {
                for (int loopIdx0 = 0;;loopIdx0++,                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true)) {
                    if (subgroupElect()) {
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    }
                    if (inputA.a[2] == 2) {
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    }
                    if (subgroupElect()) {
                        break;
                    }
                    if (subgroupElect()) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10012;
                    }
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    if (inputA.a[1] == 1) {
                    } else {
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    }
                }
                break;
            }
            case 6:
            {
                if (subgroupElect()) {
                    {
                        int loopIdx0 = 0;
                        do {
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001e;
                            if (subgroupElect()) {
                                outputC.loc[gl_LocalInvocationIndex]++;
                                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10020;
                                break;
                            }
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                            loopIdx0++;
                        } while (true);
                    }
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10025;
                }
                break;
            }
        }
        if (subgroupElect()) {
            if (subgroupElect()) {
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002c;
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
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
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


void main()
[[maximally_reconverges]]
{

    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10002;
    for (int loopIdx0 = 0;
             loopIdx0 < inputA.a[5];
             loopIdx0++) {
        {
            int loopIdx1 = 0;
            do {
                loopIdx1++;
                switch (gl_SubgroupInvocationID & 3) {
                    case 0:
                    {
                        continue;
                        break;
                    }
                    case 1:
                    {
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
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
                    case 2:
                    {
                        for (int loopIdx2 = 0;;loopIdx2++,                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true)) {
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001c;
                            if (subgroupElect()) {
                                outputC.loc[gl_LocalInvocationIndex]++;
                                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001e;
                                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                                break;
                            }
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        }
                        break;
                    }
                    case 3:
                    {
                        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10028;
                        }
                        break;
                    }
                }
                for (int loopIdx2 = 0;
                         loopIdx2 < gl_SubgroupInvocationID + 1;
                         loopIdx2++) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002d;
                    if (subgroupElect()) {
                    }
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            } while (loopIdx1 < inputA.a[2]);
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

    switch (gl_SubgroupInvocationID & 3) {
        case 0:
        {
            {
                int loopIdx0 = 0;
                do {
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    if (gl_SubgroupInvocationID == loopIdx0) {
                        if (subgroupElect()) {
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10007;
                        }
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        {
                            int loopIdx1 = 0;
                            do {
                                loopIdx1++;
                                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                            } while (loopIdx1 < inputA.a[3]);
                        }
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    }
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10010;
                    if (subgroupElect()) {
                        break;
                    }
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10015;
                    if (subgroupElect()) {
                        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10018;
                        }
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001a;
                        if (inputA.a[2] == 2) {
                        }
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001e;
                    }
                    {
                        int loopIdx1 = 0;
                        do {
                            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
                            }
                            break;
                            if (subgroupElect()) {
                                break;
                            }
                            if (testBit(uvec4(0x6a16fcd3, 0x9dcb7399, 0x43a406e7, 0x20f1c08), gl_SubgroupInvocationID)) {
                                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                            } else {
                                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                            }
                            switch (inputA.a[4]) {
                                case 5:
                                {
                                    break;
                                }
                                case 4:
                                {
                                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                                    outputC.loc[gl_LocalInvocationIndex]++;
                                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10031;
                                    break;
                                }
                                case 6:
                                {
                                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                                    break;
                                }
                            }
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10037;
                            loopIdx1++;
                        } while (true);
                    }
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    loopIdx0++;
                } while (true);
            }
            break;
        }
        case 1:
        {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1003d;
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
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
    if (subgroupElect()) {
        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
            for (int loopIdx0 = 0;;loopIdx0++,            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true)) {
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                if (testBit(uvec4(0x24f2eba6, 0xda5b1bd3, 0x7ef57eb5, 0x5d5c9433), gl_SubgroupInvocationID)) {
                }
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10009;
                break;
                if (subgroupElect()) {
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    break;
                }
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                if (gl_SubgroupInvocationID == loopIdx0) {
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                } else {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10013;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                for (int loopIdx1 = 0;
                         loopIdx1 < inputA.a[4];
                         loopIdx1++) {
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001b;
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001d;
        } else {
            for (int loopIdx0 = 0;;loopIdx0++,            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true)) {
                if (gl_SubgroupInvocationID == loopIdx0) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10021;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                } else {
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
                if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                } else {
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                if (subgroupElect()) {
                    break;
                }
                if (gl_SubgroupInvocationID == loopIdx0) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10030;
                } else {
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10033;
                }
                if (gl_LocalInvocationIndex >= inputA.a[cmpIndex2]) {
                }
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10038;
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex3]) {
                if (gl_LocalInvocationIndex >= inputA.a[cmpIndex4]) {
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                } else {
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            } else {
                if (gl_LocalInvocationIndex >= inputA.a[cmpIndex5]) {
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                } else {
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
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
layout(local_size_x_id = 0, local_size_y_id = 1, local_size_z = 1) in;
layout(set=0, binding=2) coherent buffer OutputC { uint loc[]; } outputC;
layout(set=0, binding=1) coherent buffer OutputB { uvec4 b[]; } outputB;
layout(set=0, binding=0) coherent buffer InputA  { uint  a[]; } inputA;
layout(push_constant) uniform PC {
   // set to the real stride when writing out ballots, or zero when just counting
   int  invocationStride;
   // wildcard fields, for an example the dimensions of rendered area in the case of graphics shaders
   int  width;
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

    switch (gl_SubgroupInvocationID & 3) {
        case 0:
        case 1:
        {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10002;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            for (int loopIdx0 = 0;;loopIdx0++,            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect()) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10005;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                if (subgroupElect()) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10008;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    break;
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000c;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            }
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10010;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            } else {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10010;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            }
            break;
        }
        case 2:
        case 3:
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
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001c;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    break;
                }
            }
            if (inputA.a[0] == 0) {
            } else {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10022;
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
        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10002;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        } else {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10005;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        }
        if (inputA.a[3] == 3) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10009;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        }
    }
    for (int loopIdx0 = 0;;loopIdx0++,    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect()) {
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000e;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        {
            int loopIdx1 = 0;
            do {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10011;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                if (subgroupElect()) {
                    break;
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10016;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                loopIdx1++;
            } while (true);
        }
        if (gl_SubgroupInvocationID == loopIdx0) {
        }
        if (subgroupElect()) {
            break;
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001e;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex2]) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10021;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10024;
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

    if (inputA.a[2] == 2) {
        {
            int loopIdx0 = 0;
            do {
                loopIdx0++;
            } while (loopIdx0 < inputA.a[3]);
        }
        if (inputA.a[3] == 3) {
        } else {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10005;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        }
    }
    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10009;
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
    if (inputA.a[3] == 3) {
        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000d;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        }
        if (subgroupElect()) {
        }
    }
    {
        int loopIdx0 = 0;
        do {
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10015;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            } else {
            }
            if (gl_SubgroupInvocationID == loopIdx0) {
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001b;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            if (subgroupElect()) {
                break;
            }
            if (gl_SubgroupInvocationID == loopIdx0) {
            }
            {
                int loopIdx1 = 0;
                do {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10023;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    if (subgroupElect()) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10026;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                        break;
                    }
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002a;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    loopIdx1++;
                } while (true);
            }
            loopIdx0++;
        } while (true);
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

    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10000;
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
    for (int loopIdx0 = 0;
             loopIdx0 < inputA.a[1];
             loopIdx0++) {
        if (testBit(uvec4(0xaa771a7e, 0xdcb3e81d, 0x692e392c, 0x24367332), gl_SubgroupInvocationID)) {
            continue;
        } else {
            continue;
        }
        if (subgroupElect()) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10009;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        }
    }
    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000d;
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
    {
        int loopIdx0 = 0;
        do {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10010;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            for (int loopIdx1 = 0;;loopIdx1++,            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect()) {
                if (subgroupElect()) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10014;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    break;
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10018;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            }
            if (subgroupElect()) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001c;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                break;
            }
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
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10026;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            } else {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10026;
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
layout(constant_id = 11) const uint cmpIndex1 = 0u;


void main()
[[subgroup_uniform_control_flow]]
{

    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10000;
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
    if (testBit(uvec4(0xf58394bb, 0xa0fe454, 0x7420162c, 0x8f6783ac), gl_SubgroupInvocationID)) {
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10003;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10006;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        } else {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10006;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000c;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        if (testBit(uvec4(0xe8b71b60, 0x17871b8, 0x2f9b730c, 0x5b7e9f39), gl_SubgroupInvocationID)) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000f;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        } else {
        }
    }
    switch (gl_SubgroupInvocationID & 3) {
        case 0:
        case 1:
        {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10016;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            switch (gl_SubgroupInvocationID & 3) {
                case 0:
                case 1:
                {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001a;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    break;
                }
                case 2:
                case 3:
                {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001e;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    break;
                }
            }
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10023;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            } else {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10023;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            }
            break;
        }
        case 2:
        case 3:
        {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002b;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            for (int loopIdx0 = 0;;loopIdx0++,            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect()) {
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
            }
            switch (gl_SubgroupInvocationID & 3) {
                case 0:
                case 1:
                {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1003a;
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
    }



}
#version 450 core
#extension GL_KHR_shader_subgroup_ballot : enable
#extension GL_KHR_shader_subgroup_vote : enable
#extension GL_NV_shader_subgroup_partitioned : enable
#extension GL_EXT_subgroup_uniform_control_flow : enable
layout(local_size_x_id = 0, local_size_y_id = 1, local_size_z = 1) in;
layout(set=0, binding=2) coherent buffer OutputC { uint loc[]; } outputC;
layout(set=0, binding=1) coherent buffer OutputB { uvec4 b[]; } outputB;
layout(set=0, binding=0) coherent buffer InputA  { uint  a[]; } inputA;
layout(push_constant) uniform PC {
   // set to the real stride when writing out ballots, or zero when just counting
   int  invocationStride;
   // wildcard fields, for an example the dimensions of rendered area in the case of graphics shaders
   int  width;
   int  height;
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
                 loopIdx0 < inputA.a[4];
                 loopIdx0++) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10004;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        }
    } else {
        for (int loopIdx0 = 0;
                 loopIdx0 < inputA.a[4];
                 loopIdx0++) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10009;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000c;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        if (inputA.a[2] == 2) {
        }
    }
    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10012;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex2]) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10015;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        }
    }
    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10019;
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
    if (testBit(uvec4(0xe8b71b60, 0x17871b8, 0x2f9b730c, 0x5b7e9f39), gl_SubgroupInvocationID)) {
        if (subgroupElect()) {
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001e;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex3]) {
        }
    } else {
    }



}
#version 450 core
#extension GL_KHR_shader_subgroup_ballot : enable
#extension GL_KHR_shader_subgroup_vote : enable
#extension GL_NV_shader_subgroup_partitioned : enable
#extension GL_EXT_subgroup_uniform_control_flow : enable
layout(local_size_x_id = 0, local_size_y_id = 1, local_size_z = 1) in;
layout(set=0, binding=2) coherent buffer OutputC { uint loc[]; } outputC;
layout(set=0, binding=1) coherent buffer OutputB { uvec4 b[]; } outputB;
layout(set=0, binding=0) coherent buffer InputA  { uint  a[]; } inputA;
layout(push_constant) uniform PC {
   // set to the real stride when writing out ballots, or zero when just counting
   int  invocationStride;
   // wildcard fields, for an example the dimensions of rendered area in the case of graphics shaders
   int  width;
   int  height;
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
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10009;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                break;
            }
        }
        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
        }
    }
    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
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
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10017;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                break;
            }
            case 3:
            {
                break;
            }
        }
        switch (inputA.a[4]) {
            case 5:
            {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001f;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                break;
            }
            case 4:
            {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10023;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                break;
            }
            case 6:
            {
                break;
            }
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10029;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
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
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10017;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                break;
            }
            case 3:
            {
                break;
            }
        }
        switch (inputA.a[4]) {
            case 5:
            {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001f;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                break;
            }
            case 4:
            {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10023;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                break;
            }
            case 6:
            {
                break;
            }
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10029;
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
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10005;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                loopIdx1++;
            } while (true);
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10008;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        {
            int loopIdx1 = 0;
            do {
                loopIdx1++;
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000b;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            } while (loopIdx1 < inputA.a[4]);
        }
    }
    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000f;
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
    switch (inputA.a[0]) {
        case 1:
        {
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10014;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            }
            break;
        }
        case 0:
        {
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
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001f;
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
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10025;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    break;
                }
            }
            break;
        }
        case 2:
        {
            if (subgroupElect()) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002c;
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

    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10000;
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
    for (int loopIdx0 = 0;
             loopIdx0 < inputA.a[5];
             loopIdx0++) {
        {
            int loopIdx1 = 0;
            do {
                loopIdx1++;
            } while (loopIdx1 < inputA.a[2]);
        }
    }
    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10006;
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
    {
        int loopIdx0 = 0;
        do {
            loopIdx0++;
            if (subgroupElect()) {
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000b;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            for (int loopIdx1 = 0;
                     loopIdx1 < gl_SubgroupInvocationID + 1;
                     loopIdx1++) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000e;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10011;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        } while (loopIdx0 < inputA.a[3]);
    }
    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10014;
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
    {
        int loopIdx0 = 0;
        do {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10017;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            if (inputA.a[0] == 12345) {
                while (true) {
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                }
            }
            if (subgroupElect()) {
                break;
            }
            {
                int loopIdx1 = 0;
                do {
                    loopIdx1++;
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001e;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                } while (loopIdx1 < inputA.a[3]);
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10021;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            switch (gl_SubgroupInvocationID & 3) {
                case 0:
                {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10025;
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

    if (testBit(uvec4(0x33d89e45, 0x6f5e7c36, 0x1e8005e, 0xe5d1b405), gl_SubgroupInvocationID)) {
        if (inputA.a[1] == 1) {
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10003;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        for (int loopIdx0 = 0;
                 loopIdx0 < gl_SubgroupInvocationID + 1;
                 loopIdx0++) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10006;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        }
    }
    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000a;
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
    if (inputA.a[3] == 3) {
        if (subgroupElect()) {
        }
    }
    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10010;
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
        {
            int loopIdx0 = 0;
            do {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10014;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                if (subgroupElect()) {
                    if (testBit(uvec4(0xdbd4e957, 0xdc8caff2, 0x1976770d, 0x5595f658), gl_SubgroupInvocationID)) {
                        break;
                    } else {
                        break;
                    }
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001d;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                loopIdx0++;
            } while (true);
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10020;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        if (inputA.a[1] == 1) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10023;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        } else {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10026;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        }
    } else {
        {
            int loopIdx0 = 0;
            do {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10014;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                if (subgroupElect()) {
                    if (testBit(uvec4(0xdbd4e957, 0xdc8caff2, 0x1976770d, 0x5595f658), gl_SubgroupInvocationID)) {
                        break;
                    } else {
                        break;
                    }
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001d;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                loopIdx0++;
            } while (true);
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10020;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        if (inputA.a[0] == 0) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10023;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        } else {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10026;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        }
    }
    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10041;
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

    switch (gl_SubgroupInvocationID & 3) {
        case 0:
        {
            {
                int loopIdx0 = 0;
                do {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10003;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    if (subgroupElect()) {
                        break;
                    }
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10008;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    loopIdx0++;
                } while (true);
            }
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
            for (int loopIdx0 = 0;
                     loopIdx0 < gl_SubgroupInvocationID + 1;
                     loopIdx0++) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10012;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            }
            break;
        }
        case 3:
        {
            if (testBit(uvec4(0xe6375dad, 0xc9d99e62, 0x6a71d594, 0xdb41b3c8), gl_SubgroupInvocationID)) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10018;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            }
            break;
        }
    }
    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001d;
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
            {
                int loopIdx1 = 0;
                do {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10002;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    if (subgroupElect()) {
                        break;
                    }
                    loopIdx1++;
                } while (true);
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10008;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            if (subgroupElect()) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000b;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            }
            if (subgroupElect()) {
                break;
            }
            if (testBit(uvec4(0x6333ac82, 0xdc94fc9b, 0xa1505b46, 0xed7294a7), gl_SubgroupInvocationID)) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10012;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            }
            if (inputA.a[3] == 3) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10016;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            }
            loopIdx0++;
        } while (true);
    }
    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001a;
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
    {
        int loopIdx0 = 0;
        do {
            {
                int loopIdx1 = 0;
                do {
                    loopIdx1++;
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001e;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                } while (loopIdx1 < inputA.a[3]);
            }
            if (gl_SubgroupInvocationID == loopIdx0) {
            }
            if (subgroupElect()) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10024;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                break;
            }
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
            } else {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002a;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002d;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            if (inputA.a[3] == 3) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10030;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            } else {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10033;
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
layout(constant_id = 11) const uint cmpIndex1 = 0u;


void main()
[[subgroup_uniform_control_flow]]
{

    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10000;
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
    if (subgroupElect()) {
        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
        } else {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10005;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10008;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
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
    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10012;
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
    for (int loopIdx0 = 0;
             loopIdx0 < inputA.a[5];
             loopIdx0++) {
        if (testBit(uvec4(0xf36c0148, 0x4cdb4c57, 0x8807fd23, 0xd247210b), gl_SubgroupInvocationID)) {
        } else {
        }
        if (inputA.a[2] == 2) {
        }
    }
    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001b;
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
    {
        int loopIdx0 = 0;
        do {
            loopIdx0++;
            if (inputA.a[1] == 1) {
            } else {
            }
            for (int loopIdx1 = 0;
                     loopIdx1 < gl_SubgroupInvocationID + 1;
                     loopIdx1++) {
            }
        } while (loopIdx0 < inputA.a[5]);
    }
    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10024;
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

    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10002;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        } else {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10005;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            if (inputA.a[3] == 3) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10008;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            } else {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000b;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            }
        }
    }
    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10010;
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
    switch (inputA.a[0]) {
        case 1:
        {
            if (inputA.a[0] == 0) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10015;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                {
                    int loopIdx0 = 0;
                    do {
                        loopIdx0++;
                    } while (loopIdx0 < inputA.a[4]);
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
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10021;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                        break;
                    }
                }
            } else {
                if (testBit(uvec4(0xc2817245, 0xbe5ff15e, 0x8692675c, 0x94c5e4ac), gl_SubgroupInvocationID)) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10027;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                } else {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10027;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002d;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                if (gl_LocalInvocationIndex >= inputA.a[cmpIndex2]) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10030;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                } else {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10030;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                }
            }
            break;
        }
        case 0:
        {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10039;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            {
                int loopIdx0 = 0;
                do {
                    for (int loopIdx1 = 0;
                             loopIdx1 < gl_SubgroupInvocationID + 1;
                             loopIdx1++) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1003d;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    }
                    if (testBit(uvec4(0xd7651b04, 0xf4522c5e, 0x34f51043, 0x708fbae2), gl_SubgroupInvocationID)) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10041;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    }
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10044;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    if (subgroupElect()) {
                        break;
                    }
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10049;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    break;
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1004c;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    for (int loopIdx1 = 0;
                             loopIdx1 < inputA.a[3];
                             loopIdx1++) {
                    }
                    loopIdx0++;
                } while (true);
            }
            break;
        }
        case 2:
        {
            switch (inputA.a[4]) {
                case 5:
                {
                    for (int loopIdx0 = 0;
                             loopIdx0 < gl_SubgroupInvocationID + 1;
                             loopIdx0++) {
                    }
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
            break;
        }
    }
    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1005f;
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

    if (inputA.a[1] == 1) {
        {
            int loopIdx0 = 0;
            do {
                loopIdx0++;
                if (inputA.a[3] == 3) {
                }
                if (testBit(uvec4(0xbc435729, 0x515db618, 0xfbddefa, 0xc044afed), gl_SubgroupInvocationID)) {
                } else {
                }
            } while (loopIdx0 < inputA.a[3]);
        }
        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10009;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            if (inputA.a[1] == 1) {
            } else {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000d;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10010;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        }
    } else {
        if (inputA.a[0] == 0) {
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
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001b;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    break;
                }
                case 3:
                {
                    break;
                }
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10021;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        } else {
            if (subgroupElect()) {
            }
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

    if (inputA.a[3] == 3) {
        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
            if (testBit(uvec4(0xaa771a7e, 0xdcb3e81d, 0x692e392c, 0x24367332), gl_SubgroupInvocationID)) {
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10004;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            {
                int loopIdx0 = 0;
                do {
                    loopIdx0++;
                } while (loopIdx0 < inputA.a[4]);
            }
        }
    }
    if (inputA.a[1] == 1) {
        return;
        {
            int loopIdx0 = 0;
            do {
                for (int loopIdx1 = 0;
                         loopIdx1 < gl_SubgroupInvocationID + 1;
                         loopIdx1++) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000e;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10011;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                if (gl_SubgroupInvocationID == loopIdx0) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10014;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                } else {
                }
                if (subgroupElect()) {
                    break;
                }
                {
                    int loopIdx1 = 0;
                    do {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001c;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                        if (subgroupElect()) {
                            if (testBit(uvec4(0xaa771a7e, 0xdcb3e81d, 0x692e392c, 0x24367332), gl_SubgroupInvocationID)) {
                                break;
                            } else {
                                break;
                            }
                        }
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10025;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                        loopIdx1++;
                    } while (true);
                }
                switch (gl_SubgroupInvocationID & 3) {
                    case 0:
                    {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002a;
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
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10030;
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
    } else {
        switch (gl_SubgroupInvocationID & 3) {
            case 0:
            case 1:
            {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1003a;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1003d;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10040;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                for (int loopIdx0 = 0;
                         loopIdx0 < inputA.a[4];
                         loopIdx0++) {
                }
                break;
            }
            case 2:
            case 3:
            {
                if (inputA.a[3] == 3) {
                } else {
                }
                if (subgroupElect()) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1004a;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                }
                break;
            }
        }
        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex2]) {
            {
                int loopIdx0 = 0;
                do {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10051;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    if (subgroupElect()) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10054;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                        if (testBit(uvec4(0xaa771a7e, 0xdcb3e81d, 0x692e392c, 0x24367332), gl_SubgroupInvocationID)) {
                            break;
                        } else {
                            break;
                        }
                    }
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1005c;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    loopIdx0++;
                } while (true);
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1005f;
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
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10065;
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


void main()
[[subgroup_uniform_control_flow]]
{

    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10000;
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
    for (int loopIdx0 = 0;
             loopIdx0 < inputA.a[1];
             loopIdx0++) {
        if (testBit(uvec4(0xaa771a7e, 0xdcb3e81d, 0x692e392c, 0x24367332), gl_SubgroupInvocationID)) {
            continue;
        } else {
            continue;
        }
        if (subgroupElect()) {
            if (subgroupElect()) {
            }
            continue;
        }
    }
    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000e;
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
    if (testBit(uvec4(0x9020d042, 0x8d315ce1, 0xe0d3cfa8, 0xa130abac), gl_SubgroupInvocationID)) {
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10011;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        for (int loopIdx0 = 0;;loopIdx0++,        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect()) {
            if (subgroupElect()) {
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10016;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            if (subgroupElect()) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10019;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                break;
            }
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
        for (int loopIdx0 = 0;
                 loopIdx0 < gl_SubgroupInvocationID + 1;
                 loopIdx0++) {
            if (inputA.a[1] == 1) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10028;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            } else {
            }
            for (int loopIdx1 = 0;
                     loopIdx1 < inputA.a[4];
                     loopIdx1++) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002d;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            }
        }
    } else {
        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
            {
                int loopIdx0 = 0;
                do {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10034;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    if (subgroupElect()) {
                        break;
                    }
                    loopIdx0++;
                } while (true);
            }
        } else {
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1003c;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            } else {
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
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10045;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10048;
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

    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10000;
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
    switch (gl_SubgroupInvocationID & 3) {
        case 0:
        case 1:
        {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10004;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            if (subgroupElect()) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10007;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                {
                    int loopIdx0 = 0;
                    do {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000a;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                        if (subgroupElect()) {
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000d;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                            break;
                        }
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10011;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                        loopIdx0++;
                    } while (true);
                }
            }
            break;
        }
        case 2:
        case 3:
        {
            for (int loopIdx0 = 0;
                     loopIdx0 < gl_SubgroupInvocationID + 1;
                     loopIdx0++) {
                continue;
                break;
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001b;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
                if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001f;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                } else {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001f;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10025;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            } else {
                {
                    int loopIdx0 = 0;
                    do {
                        loopIdx0++;
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10029;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    } while (loopIdx0 < inputA.a[1]);
                }
                for (int loopIdx0 = 0;
                         loopIdx0 < inputA.a[4];
                         loopIdx0++) {
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


void main()
[[subgroup_uniform_control_flow]]
{

    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10000;
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
        for (int loopIdx0 = 0;
                 loopIdx0 < inputA.a[4];
                 loopIdx0++) {
            {
                int loopIdx1 = 0;
                do {
                    if (subgroupElect()) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10006;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                        break;
                    }
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000a;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    loopIdx1++;
                } while (true);
            }
            if (gl_SubgroupInvocationID == loopIdx0) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000e;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            } else {
            }
        }
    } else {
        for (int loopIdx0 = 0;
                 loopIdx0 < inputA.a[4];
                 loopIdx0++) {
            {
                int loopIdx1 = 0;
                do {
                    if (subgroupElect()) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10006;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                        break;
                    }
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000a;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    loopIdx1++;
                } while (true);
            }
            if (gl_SubgroupInvocationID == loopIdx0) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000e;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            } else {
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

    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10000;
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
    if (subgroupElect()) {
        switch (inputA.a[4]) {
            case 5:
            {
                break;
            }
            case 4:
            {
                for (int loopIdx0 = 0;;loopIdx0++,                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect()) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10008;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    if (subgroupElect()) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000b;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                        break;
                    }
                }
                break;
            }
            case 6:
            {
                for (int loopIdx0 = 0;
                         loopIdx0 < gl_SubgroupInvocationID + 1;
                         loopIdx0++) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10013;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10016;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                break;
            }
        }
        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
            {
                int loopIdx0 = 0;
                do {
                    if (subgroupElect()) {
                        break;
                    }
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001f;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    loopIdx0++;
                } while (true);
            }
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10023;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            } else {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10023;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            }
        } else {
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex2]) {
            } else {
            }
            if (subgroupElect()) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002e;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10031;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
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


void main()
[[subgroup_uniform_control_flow]]
{

    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10000;
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
    for (int loopIdx0 = 0;
             loopIdx0 < inputA.a[5];
             loopIdx0++) {
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
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10008;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                        break;
                    }
                }
                if (inputA.a[0] == 0) {
                }
            } while (loopIdx1 < inputA.a[2]);
        }
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
                if (inputA.a[0] == 12345) {
                    while (true) {
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    }
                }
                if (subgroupElect()) {
                    break;
                }
                {
                    int loopIdx1 = 0;
                    do {
                        loopIdx1++;
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001d;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    } while (loopIdx1 < inputA.a[3]);
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10020;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                switch (gl_SubgroupInvocationID & 3) {
                    case 0:
                    {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10024;
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
                loopIdx0++;
            } while (true);
        }
    } else {
        return;
        for (int loopIdx0 = 0;
                 loopIdx0 < gl_SubgroupInvocationID + 1;
                 loopIdx0++) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10032;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            if (inputA.a[0] == 0) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10035;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            } else {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10035;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1003b;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        }
    }
    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1003f;
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

    switch (gl_SubgroupInvocationID & 3) {
        case 0:
        {
            {
                int loopIdx0 = 0;
                do {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10003;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    if (gl_SubgroupInvocationID == loopIdx0) {
                    }
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10007;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    if (inputA.a[2] == 2) {
                    } else {
                    }
                    if (subgroupElect()) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000d;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                        break;
                    }
                    switch (loopIdx0) {
                        case 1: {
                            break;
                        }
                        case 2: {
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10015;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                            break;
                        }
                        default: {
                            break;
                        }
                    }
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001b;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    if (inputA.a[2] == 2) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001e;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    } else {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10021;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    }
                    loopIdx0++;
                } while (true);
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10025;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            break;
        }
        case 1:
        {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10029;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            break;
        }
        case 2:
        {
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
                {
                    int loopIdx0 = 0;
                    do {
                        if (subgroupElect()) {
                            break;
                        }
                        loopIdx0++;
                    } while (true);
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10033;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10036;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            break;
        }
        case 3:
        {
            if (inputA.a[1] == 1) {
                if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1003c;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1003f;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            } else {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10042;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                for (int loopIdx0 = 0;;loopIdx0++,                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect()) {
                    if (subgroupElect()) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10046;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                        break;
                    }
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1004a;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1004d;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10050;
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


void main()
[[subgroup_uniform_control_flow]]
{

    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10000;
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
    if (subgroupElect()) {
        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
            for (int loopIdx0 = 0;;loopIdx0++,            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect()) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10005;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                if (subgroupElect()) {
                    break;
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000a;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            }
            {
                int loopIdx0 = 0;
                do {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000e;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    if (subgroupElect()) {
                        break;
                    }
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10013;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    loopIdx0++;
                } while (true);
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10016;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        } else {
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001a;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            } else {
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001e;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex2]) {
            }
        }
        for (int loopIdx0 = 0;
                 loopIdx0 < inputA.a[2];
                 loopIdx0++) {
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
            if (gl_SubgroupInvocationID == loopIdx0) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002f;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            } else {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002f;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10035;
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
        void func0() {
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex3]) {
                if (subgroupElect()) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002f;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10032;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                for (int loopIdx0 = 0;
                         loopIdx0 < inputA.a[4];
                         loopIdx0++) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10035;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                }
            } else {
                if (gl_LocalInvocationIndex >= inputA.a[cmpIndex4]) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1003a;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                }
                if (inputA.a[1] == 1) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1003e;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                }
            }
            if (testBit(uvec4(0xaee27654, 0x51a0fa5f, 0x3f5cfafd, 0xa3b791c0), gl_SubgroupInvocationID)) {
                for (int loopIdx0 = 0;
                         loopIdx0 < inputA.a[5];
                         loopIdx0++) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10044;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                }
                if (subgroupElect()) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10048;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                }
            } else {
                {
                    int loopIdx0 = 0;
                    do {
                        if (subgroupElect()) {
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1004e;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                            break;
                        }
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10052;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                        loopIdx0++;
                    } while (true);
                }
                if (testBit(uvec4(0xd49506e6, 0x69788d4b, 0x13e034bc, 0xcbb3b425), gl_SubgroupInvocationID)) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10056;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                } else {
                }
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1005b;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        }


void main()
[[subgroup_uniform_control_flow]]
{

    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10002;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        } else {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10005;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            if (inputA.a[1] == 1) {
                for (int loopIdx0 = 0;;loopIdx0++,                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect()) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10009;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    if (subgroupElect()) {
                        break;
                    }
                }
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10010;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            switch (inputA.a[0]) {
                case 1:
                {
                    if (inputA.a[3] == 3) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10015;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    } else {
                    }
                    break;
                }
                case 0:
                {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001b;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    break;
                }
                case 2:
                {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001f;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex2]) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10022;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    }
                    break;
                }
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10027;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002a;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        func0();
    }



}
#version 450 core
#extension GL_KHR_shader_subgroup_ballot : enable
#extension GL_KHR_shader_subgroup_vote : enable
#extension GL_NV_shader_subgroup_partitioned : enable
#extension GL_EXT_subgroup_uniform_control_flow : enable
layout(local_size_x_id = 0, local_size_y_id = 1, local_size_z = 1) in;
layout(set=0, binding=2) coherent buffer OutputC { uint loc[]; } outputC;
layout(set=0, binding=1) coherent buffer OutputB { uvec4 b[]; } outputB;
layout(set=0, binding=0) coherent buffer InputA  { uint  a[]; } inputA;
layout(push_constant) uniform PC {
   // set to the real stride when writing out ballots, or zero when just counting
   int  invocationStride;
   // wildcard fields, for an example the dimensions of rendered area in the case of graphics shaders
   int  width;
   int  height;
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

    if (inputA.a[3] == 3) {
        {
            int loopIdx0 = 0;
            do {
                loopIdx0++;
                if (inputA.a[3] == 3) {
                    if (gl_SubgroupInvocationID == loopIdx0) {
                    } else {
                    }
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10006;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                }
                continue;
            } while (loopIdx0 < inputA.a[3]);
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000b;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        if (subgroupElect()) {
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
                if (inputA.a[0] == 0) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10010;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                }
                if (testBit(uvec4(0x9181cd83, 0xdcab9b30, 0x521a842f, 0x1fc09387), gl_SubgroupInvocationID)) {
                } else {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10015;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10018;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            }
        }
    } else {
        if (testBit(uvec4(0xbc435729, 0x515db618, 0xfbddefa, 0xc044afed), gl_SubgroupInvocationID)) {
            {
                int loopIdx0 = 0;
                do {
                    if (subgroupElect()) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10020;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    }
                    for (int loopIdx1 = 0;
                             loopIdx1 < inputA.a[4];
                             loopIdx1++) {
                    }
                    if (subgroupElect()) {
                        break;
                    }
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10028;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    if (inputA.a[1] == 1) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002b;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    } else {
                    }
                    loopIdx0++;
                } while (true);
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10030;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            {
                int loopIdx0 = 0;
                do {
                    loopIdx0++;
                    if (inputA.a[0] == 0) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10034;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    }
                    if (testBit(uvec4(0x4d9ac54c, 0xd2e8e747, 0xd060f6db, 0x56dd3bd3), gl_SubgroupInvocationID)) {
                    } else {
                    }
                } while (loopIdx0 < inputA.a[5]);
            }
        }
        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
            switch (gl_SubgroupInvocationID & 3) {
                case 0:
                {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1003f;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex2]) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10042;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    } else {
                    }
                    break;
                }
                case 1:
                {
                    if (inputA.a[0] == 0) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10049;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    } else {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1004c;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    }
                    break;
                }
                case 2:
                {
                    if (subgroupElect()) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10052;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    }
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10055;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    break;
                }
                case 3:
                {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10059;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    break;
                }
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1005d;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            if (inputA.a[1] == 1) {
                if (testBit(uvec4(0xde0cfc02, 0x4527e14f, 0xb6b1b370, 0x61b047b3), gl_SubgroupInvocationID)) {
                } else {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10062;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10065;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            } else {
                if (testBit(uvec4(0xde0cfc02, 0x4527e14f, 0xb6b1b370, 0x61b047b3), gl_SubgroupInvocationID)) {
                } else {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10062;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10065;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10070;
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
    for (int loopIdx0 = 0;
             loopIdx0 < inputA.a[1];
             loopIdx0++) {
        if (testBit(uvec4(0xaa771a7e, 0xdcb3e81d, 0x692e392c, 0x24367332), gl_SubgroupInvocationID)) {
            continue;
        } else {
            continue;
        }
        if (subgroupElect()) {
            if (subgroupElect()) {
                for (int loopIdx1 = 0;
                         loopIdx1 < inputA.a[1];
                         loopIdx1++) {
                }
                {
                    int loopIdx1 = 0;
                    do {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000d;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                        if (subgroupElect()) {
                            break;
                        }
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10012;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                        loopIdx1++;
                    } while (true);
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10015;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            }
            if (testBit(uvec4(0xaa771a7e, 0xdcb3e81d, 0x692e392c, 0x24367332), gl_SubgroupInvocationID)) {
                break;
                if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001b;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                } else {
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

    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10000;
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
        for (int loopIdx0 = 0;
                 loopIdx0 < inputA.a[4];
                 loopIdx0++) {
            {
                int loopIdx1 = 0;
                do {
                    if (inputA.a[3] == 3) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10006;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    } else {
                    }
                    if (testBit(uvec4(0xcc6662ac, 0xdcbb39e6, 0xf7e9854, 0x42271730), gl_SubgroupInvocationID)) {
                        break;
                    } else {
                        break;
                    }
                    if (subgroupElect()) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10010;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                        break;
                    }
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10014;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    {
                        int loopIdx2 = 0;
                        do {
                            loopIdx2++;
                        } while (loopIdx2 < inputA.a[2]);
                    }
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10018;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    if (inputA.a[0] == 0) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001b;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    } else {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001e;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    }
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10021;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    loopIdx1++;
                } while (true);
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10024;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            break;
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10027;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002a;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        if (testBit(uvec4(0xcc6662ac, 0xdcbb39e6, 0xf7e9854, 0x42271730), gl_SubgroupInvocationID)) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002d;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            {
                int loopIdx0 = 0;
                do {
                    loopIdx0++;
                    {
                        int loopIdx1 = 0;
                        do {
                            loopIdx1++;
                        } while (loopIdx1 < inputA.a[3]);
                    }
                    break;
                } while (loopIdx0 < inputA.a[5]);
            }
            {
                int loopIdx0 = 0;
                do {
                    loopIdx0++;
                    if (subgroupElect()) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10036;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    }
                    if (testBit(uvec4(0xf58394bb, 0xa0fe454, 0x7420162c, 0x8f6783ac), gl_SubgroupInvocationID)) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1003a;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    } else {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1003a;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    }
                } while (loopIdx0 < inputA.a[3]);
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10041;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        } else {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002d;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            {
                int loopIdx0 = 0;
                do {
                    loopIdx0++;
                    {
                        int loopIdx1 = 0;
                        do {
                            loopIdx1++;
                        } while (loopIdx1 < inputA.a[3]);
                    }
                    break;
                } while (loopIdx0 < inputA.a[5]);
            }
            {
                int loopIdx0 = 0;
                do {
                    loopIdx0++;
                    if (subgroupElect()) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10036;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    }
                    if (testBit(uvec4(0xf58394bb, 0xa0fe454, 0x7420162c, 0x8f6783ac), gl_SubgroupInvocationID)) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1003a;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    } else {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1003a;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    }
                } while (loopIdx0 < inputA.a[3]);
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10041;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        }
    } else {
        for (int loopIdx0 = 0;
                 loopIdx0 < inputA.a[4];
                 loopIdx0++) {
            {
                int loopIdx1 = 0;
                do {
                    if (inputA.a[0] == 0) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10006;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    } else {
                    }
                    if (testBit(uvec4(0xcc6662ac, 0xdcbb39e6, 0xf7e9854, 0x42271730), gl_SubgroupInvocationID)) {
                        break;
                    } else {
                        break;
                    }
                    if (subgroupElect()) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10010;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                        break;
                    }
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10014;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    {
                        int loopIdx2 = 0;
                        do {
                            loopIdx2++;
                        } while (loopIdx2 < inputA.a[2]);
                    }
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10018;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    if (inputA.a[1] == 1) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001b;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    } else {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001e;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    }
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10021;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    loopIdx1++;
                } while (true);
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10024;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            break;
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10027;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002a;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        if (testBit(uvec4(0xcc6662ac, 0xdcbb39e6, 0xf7e9854, 0x42271730), gl_SubgroupInvocationID)) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002d;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            {
                int loopIdx0 = 0;
                do {
                    loopIdx0++;
                    {
                        int loopIdx1 = 0;
                        do {
                            loopIdx1++;
                        } while (loopIdx1 < inputA.a[3]);
                    }
                    break;
                } while (loopIdx0 < inputA.a[5]);
            }
            {
                int loopIdx0 = 0;
                do {
                    loopIdx0++;
                    if (subgroupElect()) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10036;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    }
                    if (testBit(uvec4(0xf58394bb, 0xa0fe454, 0x7420162c, 0x8f6783ac), gl_SubgroupInvocationID)) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1003a;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    } else {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1003a;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    }
                } while (loopIdx0 < inputA.a[3]);
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10041;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        } else {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002d;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            {
                int loopIdx0 = 0;
                do {
                    loopIdx0++;
                    {
                        int loopIdx1 = 0;
                        do {
                            loopIdx1++;
                        } while (loopIdx1 < inputA.a[3]);
                    }
                    break;
                } while (loopIdx0 < inputA.a[5]);
            }
            {
                int loopIdx0 = 0;
                do {
                    loopIdx0++;
                    if (subgroupElect()) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10036;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    }
                    if (testBit(uvec4(0xf58394bb, 0xa0fe454, 0x7420162c, 0x8f6783ac), gl_SubgroupInvocationID)) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1003a;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    } else {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1003a;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    }
                } while (loopIdx0 < inputA.a[3]);
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10041;
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


void main()
[[subgroup_uniform_control_flow]]
{

    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10000;
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
    if (subgroupElect()) {
        switch (inputA.a[4]) {
            case 5:
            {
                break;
            }
            case 4:
            {
                for (int loopIdx0 = 0;;loopIdx0++,                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect()) {
                    if (subgroupElect()) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10009;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    }
                    if (inputA.a[2] == 2) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000d;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    }
                    if (subgroupElect()) {
                        break;
                    }
                    if (subgroupElect()) {
                    }
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10015;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    if (inputA.a[1] == 1) {
                    } else {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10019;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    }
                }
                break;
            }
            case 6:
            {
                if (subgroupElect()) {
                    {
                        int loopIdx0 = 0;
                        do {
                            if (subgroupElect()) {
                                break;
                            }
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10024;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                            loopIdx0++;
                        } while (true);
                    }
                }
                break;
            }
        }
        if (subgroupElect()) {
            if (subgroupElect()) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002c;
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
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10036;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            }
        }
    }
    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1003b;
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

    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10000;
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
    for (int loopIdx0 = 0;
             loopIdx0 < inputA.a[5];
             loopIdx0++) {
        {
            int loopIdx1 = 0;
            do {
                loopIdx1++;
                switch (gl_SubgroupInvocationID & 3) {
                    case 0:
                    case 1:
                    {
                        continue;
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10007;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
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
                        break;
                    }
                    case 2:
                    case 3:
                    {
                        for (int loopIdx2 = 0;;loopIdx2++,                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect()) {
                            if (subgroupElect()) {
                                outputC.loc[gl_LocalInvocationIndex]++;
                                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10017;
                                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                                break;
                            }
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001b;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                        }
                        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001f;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                        }
                        break;
                    }
                }
                for (int loopIdx2 = 0;
                         loopIdx2 < gl_SubgroupInvocationID + 1;
                         loopIdx2++) {
                    if (subgroupElect()) {
                    }
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10027;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002a;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            } while (loopIdx1 < inputA.a[2]);
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

    switch (gl_SubgroupInvocationID & 3) {
        case 0:
        {
            {
                int loopIdx0 = 0;
                do {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10003;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    if (gl_SubgroupInvocationID == loopIdx0) {
                        if (subgroupElect()) {
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10007;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                        }
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000a;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                        {
                            int loopIdx1 = 0;
                            do {
                                loopIdx1++;
                                outputC.loc[gl_LocalInvocationIndex]++;
                                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000d;
                                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                            } while (loopIdx1 < inputA.a[3]);
                        }
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10010;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    }
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10013;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    if (subgroupElect()) {
                        break;
                    }
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10018;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    if (subgroupElect()) {
                        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
                        }
                        if (inputA.a[2] == 2) {
                        }
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001f;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    }
                    {
                        int loopIdx1 = 0;
                        do {
                            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
                            }
                            break;
                            if (subgroupElect()) {
                                break;
                            }
                            if (testBit(uvec4(0x6a16fcd3, 0x9dcb7399, 0x43a406e7, 0x20f1c08), gl_SubgroupInvocationID)) {
                                outputC.loc[gl_LocalInvocationIndex]++;
                                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002a;
                                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                            } else {
                                outputC.loc[gl_LocalInvocationIndex]++;
                                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002a;
                                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                            }
                            switch (inputA.a[4]) {
                                case 5:
                                {
                                    break;
                                }
                                case 4:
                                {
                                    outputC.loc[gl_LocalInvocationIndex]++;
                                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10034;
                                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                                    break;
                                }
                                case 6:
                                {
                                    outputC.loc[gl_LocalInvocationIndex]++;
                                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10038;
                                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                                    break;
                                }
                            }
                            loopIdx1++;
                        } while (true);
                    }
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1003d;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    loopIdx0++;
                } while (true);
            }
            break;
        }
        case 1:
        {
            break;
        }
        case 2:
        {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10044;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            break;
        }
        case 3:
        {
            break;
        }
    }
    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1004a;
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
    if (subgroupElect()) {
        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
            for (int loopIdx0 = 0;;loopIdx0++,            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect()) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10005;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                if (testBit(uvec4(0x24f2eba6, 0xda5b1bd3, 0x7ef57eb5, 0x5d5c9433), gl_SubgroupInvocationID)) {
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10009;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                break;
                if (subgroupElect()) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000d;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    break;
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10011;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                if (gl_SubgroupInvocationID == loopIdx0) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10014;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                } else {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10017;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001a;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                for (int loopIdx1 = 0;
                         loopIdx1 < inputA.a[4];
                         loopIdx1++) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001d;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10020;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            }
        } else {
            for (int loopIdx0 = 0;;loopIdx0++,            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect()) {
                if (gl_SubgroupInvocationID == loopIdx0) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10026;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                } else {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10029;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                }
                if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002d;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                } else {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002d;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10033;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                if (subgroupElect()) {
                    break;
                }
                if (gl_SubgroupInvocationID == loopIdx0) {
                } else {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1003a;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                }
                if (gl_LocalInvocationIndex >= inputA.a[cmpIndex2]) {
                }
            }
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex3]) {
                if (gl_LocalInvocationIndex >= inputA.a[cmpIndex4]) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10042;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                } else {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10042;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10048;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            } else {
                if (gl_LocalInvocationIndex >= inputA.a[cmpIndex5]) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10042;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                } else {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10042;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10048;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10055;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        }
    }
    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10059;
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

    switch (gl_SubgroupInvocationID & 3) {
        case 0:
        case 1:
        {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10002;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            for (int loopIdx0 = 0;;loopIdx0++,            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true)) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10005;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                if (subgroupElect()) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10008;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    break;
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000c;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            }
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10010;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            } else {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10010;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            }
            break;
        }
        case 2:
        case 3:
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
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001c;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    break;
                }
            }
            if (inputA.a[0] == 0) {
            } else {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10022;
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
        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10002;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        } else {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10005;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        }
        if (inputA.a[3] == 3) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10009;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        }
    }
    for (int loopIdx0 = 0;;loopIdx0++,    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true)) {
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000e;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        {
            int loopIdx1 = 0;
            do {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10011;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                if (subgroupElect()) {
                    break;
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10016;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                loopIdx1++;
            } while (true);
        }
        if (gl_SubgroupInvocationID == loopIdx0) {
        }
        if (subgroupElect()) {
            break;
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001e;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex2]) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10021;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10024;
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

    if (inputA.a[2] == 2) {
        {
            int loopIdx0 = 0;
            do {
                loopIdx0++;
            } while (loopIdx0 < inputA.a[3]);
        }
        if (inputA.a[3] == 3) {
        } else {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10005;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        }
    }
    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10009;
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
    if (inputA.a[3] == 3) {
        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000d;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        }
        if (subgroupElect()) {
        }
    }
    {
        int loopIdx0 = 0;
        do {
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10015;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            } else {
            }
            if (gl_SubgroupInvocationID == loopIdx0) {
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001b;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            if (subgroupElect()) {
                break;
            }
            if (gl_SubgroupInvocationID == loopIdx0) {
            }
            {
                int loopIdx1 = 0;
                do {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10023;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    if (subgroupElect()) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10026;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        break;
                    }
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002a;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    loopIdx1++;
                } while (true);
            }
            loopIdx0++;
        } while (true);
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

    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10000;
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
    for (int loopIdx0 = 0;
             loopIdx0 < inputA.a[1];
             loopIdx0++) {
        if (testBit(uvec4(0xaa771a7e, 0xdcb3e81d, 0x692e392c, 0x24367332), gl_SubgroupInvocationID)) {
            continue;
        } else {
            continue;
        }
        if (subgroupElect()) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10009;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        }
    }
    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000d;
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
    {
        int loopIdx0 = 0;
        do {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10010;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            for (int loopIdx1 = 0;;loopIdx1++,            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true)) {
                if (subgroupElect()) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10014;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    break;
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10018;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            }
            if (subgroupElect()) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001c;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                break;
            }
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
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10026;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            } else {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10026;
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
layout(constant_id = 11) const uint cmpIndex1 = 0u;


void main()
[[subgroup_uniform_control_flow]]
{

    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10000;
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
    if (testBit(uvec4(0xf58394bb, 0xa0fe454, 0x7420162c, 0x8f6783ac), gl_SubgroupInvocationID)) {
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10003;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10006;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        } else {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10006;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000c;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        if (testBit(uvec4(0xe8b71b60, 0x17871b8, 0x2f9b730c, 0x5b7e9f39), gl_SubgroupInvocationID)) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000f;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        } else {
        }
    }
    switch (gl_SubgroupInvocationID & 3) {
        case 0:
        case 1:
        {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10016;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            switch (gl_SubgroupInvocationID & 3) {
                case 0:
                case 1:
                {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001a;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    break;
                }
                case 2:
                case 3:
                {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001e;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    break;
                }
            }
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10023;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            } else {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10023;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            }
            break;
        }
        case 2:
        case 3:
        {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002b;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            for (int loopIdx0 = 0;;loopIdx0++,            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true)) {
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
            }
            switch (gl_SubgroupInvocationID & 3) {
                case 0:
                case 1:
                {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1003a;
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
    }



}
#version 450 core
#extension GL_KHR_shader_subgroup_ballot : enable
#extension GL_KHR_shader_subgroup_vote : enable
#extension GL_NV_shader_subgroup_partitioned : enable
#extension GL_EXT_subgroup_uniform_control_flow : enable
layout(local_size_x_id = 0, local_size_y_id = 1, local_size_z = 1) in;
layout(set=0, binding=2) coherent buffer OutputC { uint loc[]; } outputC;
layout(set=0, binding=1) coherent buffer OutputB { uvec4 b[]; } outputB;
layout(set=0, binding=0) coherent buffer InputA  { uint  a[]; } inputA;
layout(push_constant) uniform PC {
   // set to the real stride when writing out ballots, or zero when just counting
   int  invocationStride;
   // wildcard fields, for an example the dimensions of rendered area in the case of graphics shaders
   int  width;
   int  height;
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
                 loopIdx0 < inputA.a[4];
                 loopIdx0++) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10004;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        }
    } else {
        for (int loopIdx0 = 0;
                 loopIdx0 < inputA.a[4];
                 loopIdx0++) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10009;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000c;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        if (inputA.a[2] == 2) {
        }
    }
    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10012;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex2]) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10015;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        }
    }
    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10019;
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
    if (testBit(uvec4(0xe8b71b60, 0x17871b8, 0x2f9b730c, 0x5b7e9f39), gl_SubgroupInvocationID)) {
        if (subgroupElect()) {
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001e;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex3]) {
        }
    } else {
    }



}
#version 450 core
#extension GL_KHR_shader_subgroup_ballot : enable
#extension GL_KHR_shader_subgroup_vote : enable
#extension GL_NV_shader_subgroup_partitioned : enable
#extension GL_EXT_subgroup_uniform_control_flow : enable
layout(local_size_x_id = 0, local_size_y_id = 1, local_size_z = 1) in;
layout(set=0, binding=2) coherent buffer OutputC { uint loc[]; } outputC;
layout(set=0, binding=1) coherent buffer OutputB { uvec4 b[]; } outputB;
layout(set=0, binding=0) coherent buffer InputA  { uint  a[]; } inputA;
layout(push_constant) uniform PC {
   // set to the real stride when writing out ballots, or zero when just counting
   int  invocationStride;
   // wildcard fields, for an example the dimensions of rendered area in the case of graphics shaders
   int  width;
   int  height;
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
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10009;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                break;
            }
        }
        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
        }
    }
    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
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
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10017;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                break;
            }
            case 3:
            {
                break;
            }
        }
        switch (inputA.a[4]) {
            case 5:
            {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001f;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                break;
            }
            case 4:
            {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10023;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                break;
            }
            case 6:
            {
                break;
            }
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10029;
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
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10017;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                break;
            }
            case 3:
            {
                break;
            }
        }
        switch (inputA.a[4]) {
            case 5:
            {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001f;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                break;
            }
            case 4:
            {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10023;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                break;
            }
            case 6:
            {
                break;
            }
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10029;
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
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10005;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                loopIdx1++;
            } while (true);
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10008;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        {
            int loopIdx1 = 0;
            do {
                loopIdx1++;
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000b;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            } while (loopIdx1 < inputA.a[4]);
        }
    }
    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000f;
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
    switch (inputA.a[0]) {
        case 1:
        {
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10014;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            }
            break;
        }
        case 0:
        {
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
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001f;
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
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10025;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    break;
                }
            }
            break;
        }
        case 2:
        {
            if (subgroupElect()) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002c;
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

    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10000;
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
    for (int loopIdx0 = 0;
             loopIdx0 < inputA.a[5];
             loopIdx0++) {
        {
            int loopIdx1 = 0;
            do {
                loopIdx1++;
            } while (loopIdx1 < inputA.a[2]);
        }
    }
    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10006;
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
    {
        int loopIdx0 = 0;
        do {
            loopIdx0++;
            if (subgroupElect()) {
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000b;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            for (int loopIdx1 = 0;
                     loopIdx1 < gl_SubgroupInvocationID + 1;
                     loopIdx1++) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000e;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10011;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        } while (loopIdx0 < inputA.a[3]);
    }
    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10014;
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
    {
        int loopIdx0 = 0;
        do {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10017;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            if (inputA.a[0] == 12345) {
                while (true) {
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
            }
            if (subgroupElect()) {
                break;
            }
            {
                int loopIdx1 = 0;
                do {
                    loopIdx1++;
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001e;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                } while (loopIdx1 < inputA.a[3]);
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10021;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            switch (gl_SubgroupInvocationID & 3) {
                case 0:
                {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10025;
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

    if (testBit(uvec4(0x33d89e45, 0x6f5e7c36, 0x1e8005e, 0xe5d1b405), gl_SubgroupInvocationID)) {
        if (inputA.a[1] == 1) {
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10003;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        for (int loopIdx0 = 0;
                 loopIdx0 < gl_SubgroupInvocationID + 1;
                 loopIdx0++) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10006;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        }
    }
    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000a;
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
    if (inputA.a[3] == 3) {
        if (subgroupElect()) {
        }
    }
    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10010;
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
        {
            int loopIdx0 = 0;
            do {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10014;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                if (subgroupElect()) {
                    if (testBit(uvec4(0xdbd4e957, 0xdc8caff2, 0x1976770d, 0x5595f658), gl_SubgroupInvocationID)) {
                        break;
                    } else {
                        break;
                    }
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001d;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                loopIdx0++;
            } while (true);
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10020;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        if (inputA.a[1] == 1) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10023;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        } else {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10026;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        }
    } else {
        {
            int loopIdx0 = 0;
            do {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10014;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                if (subgroupElect()) {
                    if (testBit(uvec4(0xdbd4e957, 0xdc8caff2, 0x1976770d, 0x5595f658), gl_SubgroupInvocationID)) {
                        break;
                    } else {
                        break;
                    }
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001d;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                loopIdx0++;
            } while (true);
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10020;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        if (inputA.a[0] == 0) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10023;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        } else {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10026;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        }
    }
    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10041;
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

    switch (gl_SubgroupInvocationID & 3) {
        case 0:
        {
            {
                int loopIdx0 = 0;
                do {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10003;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    if (subgroupElect()) {
                        break;
                    }
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10008;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    loopIdx0++;
                } while (true);
            }
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
            for (int loopIdx0 = 0;
                     loopIdx0 < gl_SubgroupInvocationID + 1;
                     loopIdx0++) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10012;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            }
            break;
        }
        case 3:
        {
            if (testBit(uvec4(0xe6375dad, 0xc9d99e62, 0x6a71d594, 0xdb41b3c8), gl_SubgroupInvocationID)) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10018;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            }
            break;
        }
    }
    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001d;
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
            {
                int loopIdx1 = 0;
                do {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10002;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    if (subgroupElect()) {
                        break;
                    }
                    loopIdx1++;
                } while (true);
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10008;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            if (subgroupElect()) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000b;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            }
            if (subgroupElect()) {
                break;
            }
            if (testBit(uvec4(0x6333ac82, 0xdc94fc9b, 0xa1505b46, 0xed7294a7), gl_SubgroupInvocationID)) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10012;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            }
            if (inputA.a[3] == 3) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10016;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            }
            loopIdx0++;
        } while (true);
    }
    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001a;
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
    {
        int loopIdx0 = 0;
        do {
            {
                int loopIdx1 = 0;
                do {
                    loopIdx1++;
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001e;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                } while (loopIdx1 < inputA.a[3]);
            }
            if (gl_SubgroupInvocationID == loopIdx0) {
            }
            if (subgroupElect()) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10024;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                break;
            }
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
            } else {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002a;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002d;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            if (inputA.a[3] == 3) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10030;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            } else {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10033;
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
layout(constant_id = 11) const uint cmpIndex1 = 0u;


void main()
[[subgroup_uniform_control_flow]]
{

    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10000;
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
    if (subgroupElect()) {
        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
        } else {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10005;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10008;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
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
    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10012;
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
    for (int loopIdx0 = 0;
             loopIdx0 < inputA.a[5];
             loopIdx0++) {
        if (testBit(uvec4(0xf36c0148, 0x4cdb4c57, 0x8807fd23, 0xd247210b), gl_SubgroupInvocationID)) {
        } else {
        }
        if (inputA.a[2] == 2) {
        }
    }
    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001b;
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
    {
        int loopIdx0 = 0;
        do {
            loopIdx0++;
            if (inputA.a[1] == 1) {
            } else {
            }
            for (int loopIdx1 = 0;
                     loopIdx1 < gl_SubgroupInvocationID + 1;
                     loopIdx1++) {
            }
        } while (loopIdx0 < inputA.a[5]);
    }
    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10024;
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

    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10002;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        } else {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10005;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            if (inputA.a[3] == 3) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10008;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            } else {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000b;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            }
        }
    }
    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10010;
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
    switch (inputA.a[0]) {
        case 1:
        {
            if (inputA.a[0] == 0) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10015;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                {
                    int loopIdx0 = 0;
                    do {
                        loopIdx0++;
                    } while (loopIdx0 < inputA.a[4]);
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
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10021;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        break;
                    }
                }
            } else {
                if (testBit(uvec4(0xc2817245, 0xbe5ff15e, 0x8692675c, 0x94c5e4ac), gl_SubgroupInvocationID)) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10027;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                } else {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10027;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002d;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                if (gl_LocalInvocationIndex >= inputA.a[cmpIndex2]) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10030;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                } else {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10030;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
            }
            break;
        }
        case 0:
        {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10039;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            {
                int loopIdx0 = 0;
                do {
                    for (int loopIdx1 = 0;
                             loopIdx1 < gl_SubgroupInvocationID + 1;
                             loopIdx1++) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1003d;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    }
                    if (testBit(uvec4(0xd7651b04, 0xf4522c5e, 0x34f51043, 0x708fbae2), gl_SubgroupInvocationID)) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10041;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    }
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10044;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    if (subgroupElect()) {
                        break;
                    }
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10049;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    break;
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1004c;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    for (int loopIdx1 = 0;
                             loopIdx1 < inputA.a[3];
                             loopIdx1++) {
                    }
                    loopIdx0++;
                } while (true);
            }
            break;
        }
        case 2:
        {
            switch (inputA.a[4]) {
                case 5:
                {
                    for (int loopIdx0 = 0;
                             loopIdx0 < gl_SubgroupInvocationID + 1;
                             loopIdx0++) {
                    }
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
            break;
        }
    }
    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1005f;
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

    if (inputA.a[1] == 1) {
        {
            int loopIdx0 = 0;
            do {
                loopIdx0++;
                if (inputA.a[3] == 3) {
                }
                if (testBit(uvec4(0xbc435729, 0x515db618, 0xfbddefa, 0xc044afed), gl_SubgroupInvocationID)) {
                } else {
                }
            } while (loopIdx0 < inputA.a[3]);
        }
        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10009;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            if (inputA.a[1] == 1) {
            } else {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000d;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10010;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        }
    } else {
        if (inputA.a[0] == 0) {
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
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001b;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    break;
                }
                case 3:
                {
                    break;
                }
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10021;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        } else {
            if (subgroupElect()) {
            }
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

    if (inputA.a[3] == 3) {
        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
            if (testBit(uvec4(0xaa771a7e, 0xdcb3e81d, 0x692e392c, 0x24367332), gl_SubgroupInvocationID)) {
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10004;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            {
                int loopIdx0 = 0;
                do {
                    loopIdx0++;
                } while (loopIdx0 < inputA.a[4]);
            }
        }
    }
    if (inputA.a[1] == 1) {
        return;
        {
            int loopIdx0 = 0;
            do {
                for (int loopIdx1 = 0;
                         loopIdx1 < gl_SubgroupInvocationID + 1;
                         loopIdx1++) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000e;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10011;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                if (gl_SubgroupInvocationID == loopIdx0) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10014;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                } else {
                }
                if (subgroupElect()) {
                    break;
                }
                {
                    int loopIdx1 = 0;
                    do {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001c;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        if (subgroupElect()) {
                            if (testBit(uvec4(0xaa771a7e, 0xdcb3e81d, 0x692e392c, 0x24367332), gl_SubgroupInvocationID)) {
                                break;
                            } else {
                                break;
                            }
                        }
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10025;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        loopIdx1++;
                    } while (true);
                }
                switch (gl_SubgroupInvocationID & 3) {
                    case 0:
                    {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002a;
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
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10030;
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
    } else {
        switch (gl_SubgroupInvocationID & 3) {
            case 0:
            case 1:
            {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1003a;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1003d;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10040;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                for (int loopIdx0 = 0;
                         loopIdx0 < inputA.a[4];
                         loopIdx0++) {
                }
                break;
            }
            case 2:
            case 3:
            {
                if (inputA.a[3] == 3) {
                } else {
                }
                if (subgroupElect()) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1004a;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
                break;
            }
        }
        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex2]) {
            {
                int loopIdx0 = 0;
                do {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10051;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    if (subgroupElect()) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10054;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        if (testBit(uvec4(0xaa771a7e, 0xdcb3e81d, 0x692e392c, 0x24367332), gl_SubgroupInvocationID)) {
                            break;
                        } else {
                            break;
                        }
                    }
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1005c;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    loopIdx0++;
                } while (true);
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1005f;
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
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10065;
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


void main()
[[subgroup_uniform_control_flow]]
{

    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10000;
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
    for (int loopIdx0 = 0;
             loopIdx0 < inputA.a[1];
             loopIdx0++) {
        if (testBit(uvec4(0xaa771a7e, 0xdcb3e81d, 0x692e392c, 0x24367332), gl_SubgroupInvocationID)) {
            continue;
        } else {
            continue;
        }
        if (subgroupElect()) {
            if (subgroupElect()) {
            }
            continue;
        }
    }
    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000e;
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
    if (testBit(uvec4(0x9020d042, 0x8d315ce1, 0xe0d3cfa8, 0xa130abac), gl_SubgroupInvocationID)) {
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10011;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        for (int loopIdx0 = 0;;loopIdx0++,        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true)) {
            if (subgroupElect()) {
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10016;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            if (subgroupElect()) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10019;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                break;
            }
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
        for (int loopIdx0 = 0;
                 loopIdx0 < gl_SubgroupInvocationID + 1;
                 loopIdx0++) {
            if (inputA.a[1] == 1) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10028;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            } else {
            }
            for (int loopIdx1 = 0;
                     loopIdx1 < inputA.a[4];
                     loopIdx1++) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002d;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            }
        }
    } else {
        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
            {
                int loopIdx0 = 0;
                do {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10034;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    if (subgroupElect()) {
                        break;
                    }
                    loopIdx0++;
                } while (true);
            }
        } else {
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1003c;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            } else {
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
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10045;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10048;
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

    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10000;
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
    switch (gl_SubgroupInvocationID & 3) {
        case 0:
        case 1:
        {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10004;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            if (subgroupElect()) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10007;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                {
                    int loopIdx0 = 0;
                    do {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000a;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        if (subgroupElect()) {
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000d;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                            break;
                        }
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10011;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        loopIdx0++;
                    } while (true);
                }
            }
            break;
        }
        case 2:
        case 3:
        {
            for (int loopIdx0 = 0;
                     loopIdx0 < gl_SubgroupInvocationID + 1;
                     loopIdx0++) {
                continue;
                break;
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001b;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
                if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001f;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                } else {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001f;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10025;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            } else {
                {
                    int loopIdx0 = 0;
                    do {
                        loopIdx0++;
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10029;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    } while (loopIdx0 < inputA.a[1]);
                }
                for (int loopIdx0 = 0;
                         loopIdx0 < inputA.a[4];
                         loopIdx0++) {
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


void main()
[[subgroup_uniform_control_flow]]
{

    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10000;
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
        for (int loopIdx0 = 0;
                 loopIdx0 < inputA.a[4];
                 loopIdx0++) {
            {
                int loopIdx1 = 0;
                do {
                    if (subgroupElect()) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10006;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        break;
                    }
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000a;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    loopIdx1++;
                } while (true);
            }
            if (gl_SubgroupInvocationID == loopIdx0) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000e;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            } else {
            }
        }
    } else {
        for (int loopIdx0 = 0;
                 loopIdx0 < inputA.a[4];
                 loopIdx0++) {
            {
                int loopIdx1 = 0;
                do {
                    if (subgroupElect()) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10006;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        break;
                    }
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000a;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    loopIdx1++;
                } while (true);
            }
            if (gl_SubgroupInvocationID == loopIdx0) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000e;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            } else {
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

    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10000;
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
    if (subgroupElect()) {
        switch (inputA.a[4]) {
            case 5:
            {
                break;
            }
            case 4:
            {
                for (int loopIdx0 = 0;;loopIdx0++,                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true)) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10008;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    if (subgroupElect()) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000b;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        break;
                    }
                }
                break;
            }
            case 6:
            {
                for (int loopIdx0 = 0;
                         loopIdx0 < gl_SubgroupInvocationID + 1;
                         loopIdx0++) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10013;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10016;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                break;
            }
        }
        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
            {
                int loopIdx0 = 0;
                do {
                    if (subgroupElect()) {
                        break;
                    }
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001f;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    loopIdx0++;
                } while (true);
            }
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10023;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            } else {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10023;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            }
        } else {
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex2]) {
            } else {
            }
            if (subgroupElect()) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002e;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10031;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
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


void main()
[[subgroup_uniform_control_flow]]
{

    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10000;
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
    for (int loopIdx0 = 0;
             loopIdx0 < inputA.a[5];
             loopIdx0++) {
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
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10008;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        break;
                    }
                }
                if (inputA.a[0] == 0) {
                }
            } while (loopIdx1 < inputA.a[2]);
        }
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
                if (inputA.a[0] == 12345) {
                    while (true) {
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    }
                }
                if (subgroupElect()) {
                    break;
                }
                {
                    int loopIdx1 = 0;
                    do {
                        loopIdx1++;
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001d;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    } while (loopIdx1 < inputA.a[3]);
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10020;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                switch (gl_SubgroupInvocationID & 3) {
                    case 0:
                    {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10024;
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
                loopIdx0++;
            } while (true);
        }
    } else {
        return;
        for (int loopIdx0 = 0;
                 loopIdx0 < gl_SubgroupInvocationID + 1;
                 loopIdx0++) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10032;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            if (inputA.a[0] == 0) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10035;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            } else {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10035;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1003b;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        }
    }
    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1003f;
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

    switch (gl_SubgroupInvocationID & 3) {
        case 0:
        {
            {
                int loopIdx0 = 0;
                do {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10003;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    if (gl_SubgroupInvocationID == loopIdx0) {
                    }
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10007;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    if (inputA.a[2] == 2) {
                    } else {
                    }
                    if (subgroupElect()) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000d;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        break;
                    }
                    switch (loopIdx0) {
                        case 1: {
                            break;
                        }
                        case 2: {
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10015;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                            break;
                        }
                        default: {
                            break;
                        }
                    }
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001b;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    if (inputA.a[2] == 2) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001e;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    } else {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10021;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    }
                    loopIdx0++;
                } while (true);
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10025;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            break;
        }
        case 1:
        {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10029;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            break;
        }
        case 2:
        {
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
                {
                    int loopIdx0 = 0;
                    do {
                        if (subgroupElect()) {
                            break;
                        }
                        loopIdx0++;
                    } while (true);
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10033;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10036;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            break;
        }
        case 3:
        {
            if (inputA.a[1] == 1) {
                if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1003c;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1003f;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            } else {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10042;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                for (int loopIdx0 = 0;;loopIdx0++,                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true)) {
                    if (subgroupElect()) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10046;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        break;
                    }
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1004a;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1004d;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10050;
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


void main()
[[subgroup_uniform_control_flow]]
{

    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10000;
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
    if (subgroupElect()) {
        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
            for (int loopIdx0 = 0;;loopIdx0++,            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true)) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10005;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                if (subgroupElect()) {
                    break;
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000a;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            }
            {
                int loopIdx0 = 0;
                do {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000e;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    if (subgroupElect()) {
                        break;
                    }
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10013;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    loopIdx0++;
                } while (true);
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10016;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        } else {
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001a;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            } else {
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001e;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex2]) {
            }
        }
        for (int loopIdx0 = 0;
                 loopIdx0 < inputA.a[2];
                 loopIdx0++) {
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
            if (gl_SubgroupInvocationID == loopIdx0) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002f;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            } else {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002f;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10035;
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
        void func0() {
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex3]) {
                if (subgroupElect()) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002f;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10032;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                for (int loopIdx0 = 0;
                         loopIdx0 < inputA.a[4];
                         loopIdx0++) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10035;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
            } else {
                if (gl_LocalInvocationIndex >= inputA.a[cmpIndex4]) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1003a;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
                if (inputA.a[1] == 1) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1003e;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
            }
            if (testBit(uvec4(0xaee27654, 0x51a0fa5f, 0x3f5cfafd, 0xa3b791c0), gl_SubgroupInvocationID)) {
                for (int loopIdx0 = 0;
                         loopIdx0 < inputA.a[5];
                         loopIdx0++) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10044;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
                if (subgroupElect()) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10048;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
            } else {
                {
                    int loopIdx0 = 0;
                    do {
                        if (subgroupElect()) {
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1004e;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                            break;
                        }
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10052;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        loopIdx0++;
                    } while (true);
                }
                if (testBit(uvec4(0xd49506e6, 0x69788d4b, 0x13e034bc, 0xcbb3b425), gl_SubgroupInvocationID)) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10056;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                } else {
                }
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1005b;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        }


void main()
[[subgroup_uniform_control_flow]]
{

    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10002;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        } else {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10005;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            if (inputA.a[1] == 1) {
                for (int loopIdx0 = 0;;loopIdx0++,                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true)) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10009;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    if (subgroupElect()) {
                        break;
                    }
                }
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10010;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            switch (inputA.a[0]) {
                case 1:
                {
                    if (inputA.a[3] == 3) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10015;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    } else {
                    }
                    break;
                }
                case 0:
                {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001b;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    break;
                }
                case 2:
                {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001f;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex2]) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10022;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    }
                    break;
                }
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10027;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002a;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        func0();
    }



}
#version 450 core
#extension GL_KHR_shader_subgroup_ballot : enable
#extension GL_KHR_shader_subgroup_vote : enable
#extension GL_NV_shader_subgroup_partitioned : enable
#extension GL_EXT_subgroup_uniform_control_flow : enable
layout(local_size_x_id = 0, local_size_y_id = 1, local_size_z = 1) in;
layout(set=0, binding=2) coherent buffer OutputC { uint loc[]; } outputC;
layout(set=0, binding=1) coherent buffer OutputB { uvec4 b[]; } outputB;
layout(set=0, binding=0) coherent buffer InputA  { uint  a[]; } inputA;
layout(push_constant) uniform PC {
   // set to the real stride when writing out ballots, or zero when just counting
   int  invocationStride;
   // wildcard fields, for an example the dimensions of rendered area in the case of graphics shaders
   int  width;
   int  height;
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

    if (inputA.a[3] == 3) {
        {
            int loopIdx0 = 0;
            do {
                loopIdx0++;
                if (inputA.a[3] == 3) {
                    if (gl_SubgroupInvocationID == loopIdx0) {
                    } else {
                    }
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10006;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
                continue;
            } while (loopIdx0 < inputA.a[3]);
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000b;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        if (subgroupElect()) {
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
                if (inputA.a[0] == 0) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10010;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
                if (testBit(uvec4(0x9181cd83, 0xdcab9b30, 0x521a842f, 0x1fc09387), gl_SubgroupInvocationID)) {
                } else {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10015;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10018;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            }
        }
    } else {
        if (testBit(uvec4(0xbc435729, 0x515db618, 0xfbddefa, 0xc044afed), gl_SubgroupInvocationID)) {
            {
                int loopIdx0 = 0;
                do {
                    if (subgroupElect()) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10020;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    }
                    for (int loopIdx1 = 0;
                             loopIdx1 < inputA.a[4];
                             loopIdx1++) {
                    }
                    if (subgroupElect()) {
                        break;
                    }
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10028;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    if (inputA.a[1] == 1) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002b;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    } else {
                    }
                    loopIdx0++;
                } while (true);
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10030;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            {
                int loopIdx0 = 0;
                do {
                    loopIdx0++;
                    if (inputA.a[0] == 0) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10034;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    }
                    if (testBit(uvec4(0x4d9ac54c, 0xd2e8e747, 0xd060f6db, 0x56dd3bd3), gl_SubgroupInvocationID)) {
                    } else {
                    }
                } while (loopIdx0 < inputA.a[5]);
            }
        }
        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
            switch (gl_SubgroupInvocationID & 3) {
                case 0:
                {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1003f;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex2]) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10042;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    } else {
                    }
                    break;
                }
                case 1:
                {
                    if (inputA.a[0] == 0) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10049;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    } else {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1004c;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    }
                    break;
                }
                case 2:
                {
                    if (subgroupElect()) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10052;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    }
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10055;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    break;
                }
                case 3:
                {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10059;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    break;
                }
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1005d;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            if (inputA.a[1] == 1) {
                if (testBit(uvec4(0xde0cfc02, 0x4527e14f, 0xb6b1b370, 0x61b047b3), gl_SubgroupInvocationID)) {
                } else {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10062;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10065;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            } else {
                if (testBit(uvec4(0xde0cfc02, 0x4527e14f, 0xb6b1b370, 0x61b047b3), gl_SubgroupInvocationID)) {
                } else {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10062;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10065;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10070;
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
    for (int loopIdx0 = 0;
             loopIdx0 < inputA.a[1];
             loopIdx0++) {
        if (testBit(uvec4(0xaa771a7e, 0xdcb3e81d, 0x692e392c, 0x24367332), gl_SubgroupInvocationID)) {
            continue;
        } else {
            continue;
        }
        if (subgroupElect()) {
            if (subgroupElect()) {
                for (int loopIdx1 = 0;
                         loopIdx1 < inputA.a[1];
                         loopIdx1++) {
                }
                {
                    int loopIdx1 = 0;
                    do {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000d;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        if (subgroupElect()) {
                            break;
                        }
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10012;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        loopIdx1++;
                    } while (true);
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10015;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            }
            if (testBit(uvec4(0xaa771a7e, 0xdcb3e81d, 0x692e392c, 0x24367332), gl_SubgroupInvocationID)) {
                break;
                if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001b;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                } else {
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

    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10000;
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
        for (int loopIdx0 = 0;
                 loopIdx0 < inputA.a[4];
                 loopIdx0++) {
            {
                int loopIdx1 = 0;
                do {
                    if (inputA.a[3] == 3) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10006;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    } else {
                    }
                    if (testBit(uvec4(0xcc6662ac, 0xdcbb39e6, 0xf7e9854, 0x42271730), gl_SubgroupInvocationID)) {
                        break;
                    } else {
                        break;
                    }
                    if (subgroupElect()) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10010;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        break;
                    }
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10014;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    {
                        int loopIdx2 = 0;
                        do {
                            loopIdx2++;
                        } while (loopIdx2 < inputA.a[2]);
                    }
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10018;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    if (inputA.a[0] == 0) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001b;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    } else {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001e;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    }
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10021;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    loopIdx1++;
                } while (true);
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10024;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            break;
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10027;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002a;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        if (testBit(uvec4(0xcc6662ac, 0xdcbb39e6, 0xf7e9854, 0x42271730), gl_SubgroupInvocationID)) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002d;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            {
                int loopIdx0 = 0;
                do {
                    loopIdx0++;
                    {
                        int loopIdx1 = 0;
                        do {
                            loopIdx1++;
                        } while (loopIdx1 < inputA.a[3]);
                    }
                    break;
                } while (loopIdx0 < inputA.a[5]);
            }
            {
                int loopIdx0 = 0;
                do {
                    loopIdx0++;
                    if (subgroupElect()) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10036;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    }
                    if (testBit(uvec4(0xf58394bb, 0xa0fe454, 0x7420162c, 0x8f6783ac), gl_SubgroupInvocationID)) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1003a;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    } else {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1003a;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    }
                } while (loopIdx0 < inputA.a[3]);
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10041;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        } else {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002d;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            {
                int loopIdx0 = 0;
                do {
                    loopIdx0++;
                    {
                        int loopIdx1 = 0;
                        do {
                            loopIdx1++;
                        } while (loopIdx1 < inputA.a[3]);
                    }
                    break;
                } while (loopIdx0 < inputA.a[5]);
            }
            {
                int loopIdx0 = 0;
                do {
                    loopIdx0++;
                    if (subgroupElect()) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10036;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    }
                    if (testBit(uvec4(0xf58394bb, 0xa0fe454, 0x7420162c, 0x8f6783ac), gl_SubgroupInvocationID)) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1003a;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    } else {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1003a;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    }
                } while (loopIdx0 < inputA.a[3]);
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10041;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        }
    } else {
        for (int loopIdx0 = 0;
                 loopIdx0 < inputA.a[4];
                 loopIdx0++) {
            {
                int loopIdx1 = 0;
                do {
                    if (inputA.a[0] == 0) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10006;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    } else {
                    }
                    if (testBit(uvec4(0xcc6662ac, 0xdcbb39e6, 0xf7e9854, 0x42271730), gl_SubgroupInvocationID)) {
                        break;
                    } else {
                        break;
                    }
                    if (subgroupElect()) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10010;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        break;
                    }
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10014;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    {
                        int loopIdx2 = 0;
                        do {
                            loopIdx2++;
                        } while (loopIdx2 < inputA.a[2]);
                    }
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10018;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    if (inputA.a[1] == 1) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001b;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    } else {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001e;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    }
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10021;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    loopIdx1++;
                } while (true);
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10024;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            break;
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10027;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002a;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        if (testBit(uvec4(0xcc6662ac, 0xdcbb39e6, 0xf7e9854, 0x42271730), gl_SubgroupInvocationID)) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002d;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            {
                int loopIdx0 = 0;
                do {
                    loopIdx0++;
                    {
                        int loopIdx1 = 0;
                        do {
                            loopIdx1++;
                        } while (loopIdx1 < inputA.a[3]);
                    }
                    break;
                } while (loopIdx0 < inputA.a[5]);
            }
            {
                int loopIdx0 = 0;
                do {
                    loopIdx0++;
                    if (subgroupElect()) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10036;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    }
                    if (testBit(uvec4(0xf58394bb, 0xa0fe454, 0x7420162c, 0x8f6783ac), gl_SubgroupInvocationID)) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1003a;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    } else {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1003a;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    }
                } while (loopIdx0 < inputA.a[3]);
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10041;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        } else {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002d;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            {
                int loopIdx0 = 0;
                do {
                    loopIdx0++;
                    {
                        int loopIdx1 = 0;
                        do {
                            loopIdx1++;
                        } while (loopIdx1 < inputA.a[3]);
                    }
                    break;
                } while (loopIdx0 < inputA.a[5]);
            }
            {
                int loopIdx0 = 0;
                do {
                    loopIdx0++;
                    if (subgroupElect()) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10036;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    }
                    if (testBit(uvec4(0xf58394bb, 0xa0fe454, 0x7420162c, 0x8f6783ac), gl_SubgroupInvocationID)) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1003a;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    } else {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1003a;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    }
                } while (loopIdx0 < inputA.a[3]);
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10041;
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


void main()
[[subgroup_uniform_control_flow]]
{

    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10000;
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
    if (subgroupElect()) {
        switch (inputA.a[4]) {
            case 5:
            {
                break;
            }
            case 4:
            {
                for (int loopIdx0 = 0;;loopIdx0++,                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true)) {
                    if (subgroupElect()) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10009;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    }
                    if (inputA.a[2] == 2) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000d;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    }
                    if (subgroupElect()) {
                        break;
                    }
                    if (subgroupElect()) {
                    }
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10015;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    if (inputA.a[1] == 1) {
                    } else {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10019;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    }
                }
                break;
            }
            case 6:
            {
                if (subgroupElect()) {
                    {
                        int loopIdx0 = 0;
                        do {
                            if (subgroupElect()) {
                                break;
                            }
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10024;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                            loopIdx0++;
                        } while (true);
                    }
                }
                break;
            }
        }
        if (subgroupElect()) {
            if (subgroupElect()) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002c;
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
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10036;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            }
        }
    }
    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1003b;
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

    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10000;
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
    for (int loopIdx0 = 0;
             loopIdx0 < inputA.a[5];
             loopIdx0++) {
        {
            int loopIdx1 = 0;
            do {
                loopIdx1++;
                switch (gl_SubgroupInvocationID & 3) {
                    case 0:
                    case 1:
                    {
                        continue;
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10007;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
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
                        break;
                    }
                    case 2:
                    case 3:
                    {
                        for (int loopIdx2 = 0;;loopIdx2++,                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true)) {
                            if (subgroupElect()) {
                                outputC.loc[gl_LocalInvocationIndex]++;
                                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10017;
                                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                                break;
                            }
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001b;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        }
                        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001f;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        }
                        break;
                    }
                }
                for (int loopIdx2 = 0;
                         loopIdx2 < gl_SubgroupInvocationID + 1;
                         loopIdx2++) {
                    if (subgroupElect()) {
                    }
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10027;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002a;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            } while (loopIdx1 < inputA.a[2]);
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

    switch (gl_SubgroupInvocationID & 3) {
        case 0:
        {
            {
                int loopIdx0 = 0;
                do {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10003;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    if (gl_SubgroupInvocationID == loopIdx0) {
                        if (subgroupElect()) {
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10007;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        }
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000a;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        {
                            int loopIdx1 = 0;
                            do {
                                loopIdx1++;
                                outputC.loc[gl_LocalInvocationIndex]++;
                                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000d;
                                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                            } while (loopIdx1 < inputA.a[3]);
                        }
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10010;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    }
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10013;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    if (subgroupElect()) {
                        break;
                    }
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10018;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    if (subgroupElect()) {
                        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
                        }
                        if (inputA.a[2] == 2) {
                        }
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001f;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    }
                    {
                        int loopIdx1 = 0;
                        do {
                            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
                            }
                            break;
                            if (subgroupElect()) {
                                break;
                            }
                            if (testBit(uvec4(0x6a16fcd3, 0x9dcb7399, 0x43a406e7, 0x20f1c08), gl_SubgroupInvocationID)) {
                                outputC.loc[gl_LocalInvocationIndex]++;
                                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002a;
                                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                            } else {
                                outputC.loc[gl_LocalInvocationIndex]++;
                                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002a;
                                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                            }
                            switch (inputA.a[4]) {
                                case 5:
                                {
                                    break;
                                }
                                case 4:
                                {
                                    outputC.loc[gl_LocalInvocationIndex]++;
                                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10034;
                                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                                    break;
                                }
                                case 6:
                                {
                                    outputC.loc[gl_LocalInvocationIndex]++;
                                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10038;
                                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                                    break;
                                }
                            }
                            loopIdx1++;
                        } while (true);
                    }
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1003d;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    loopIdx0++;
                } while (true);
            }
            break;
        }
        case 1:
        {
            break;
        }
        case 2:
        {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10044;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            break;
        }
        case 3:
        {
            break;
        }
    }
    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1004a;
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
    if (subgroupElect()) {
        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
            for (int loopIdx0 = 0;;loopIdx0++,            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true)) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10005;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                if (testBit(uvec4(0x24f2eba6, 0xda5b1bd3, 0x7ef57eb5, 0x5d5c9433), gl_SubgroupInvocationID)) {
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10009;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                break;
                if (subgroupElect()) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000d;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    break;
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10011;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                if (gl_SubgroupInvocationID == loopIdx0) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10014;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                } else {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10017;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001a;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                for (int loopIdx1 = 0;
                         loopIdx1 < inputA.a[4];
                         loopIdx1++) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001d;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10020;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            }
        } else {
            for (int loopIdx0 = 0;;loopIdx0++,            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true)) {
                if (gl_SubgroupInvocationID == loopIdx0) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10026;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                } else {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10029;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
                if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002d;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                } else {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002d;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10033;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                if (subgroupElect()) {
                    break;
                }
                if (gl_SubgroupInvocationID == loopIdx0) {
                } else {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1003a;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
                if (gl_LocalInvocationIndex >= inputA.a[cmpIndex2]) {
                }
            }
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex3]) {
                if (gl_LocalInvocationIndex >= inputA.a[cmpIndex4]) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10042;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                } else {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10042;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10048;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            } else {
                if (gl_LocalInvocationIndex >= inputA.a[cmpIndex5]) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10042;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                } else {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10042;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10048;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10055;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        }
    }
    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10059;
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

    switch (gl_SubgroupInvocationID & 3) {
        case 0:
        case 1:
        {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10002;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            for (int loopIdx0 = 0;;loopIdx0++,            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect()) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10005;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                if (subgroupElect()) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10008;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    break;
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000c;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            }
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10010;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            } else {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10010;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            }
            break;
        }
        case 2:
        case 3:
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
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001c;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    break;
                }
            }
            if (inputA.a[0] == 0) {
            } else {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10022;
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
        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10002;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        } else {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10005;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        }
        if (inputA.a[3] == 3) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10009;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        }
    }
    for (int loopIdx0 = 0;;loopIdx0++,    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect()) {
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000e;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        {
            int loopIdx1 = 0;
            do {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10011;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                if (subgroupElect()) {
                    break;
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10016;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                loopIdx1++;
            } while (true);
        }
        if (gl_SubgroupInvocationID == loopIdx0) {
        }
        if (subgroupElect()) {
            break;
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001e;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex2]) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10021;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10024;
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

    if (inputA.a[2] == 2) {
        {
            int loopIdx0 = 0;
            do {
                loopIdx0++;
            } while (loopIdx0 < inputA.a[3]);
        }
        if (inputA.a[3] == 3) {
        } else {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10005;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        }
    }
    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10009;
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
    if (inputA.a[3] == 3) {
        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000d;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        }
        if (subgroupElect()) {
        }
    }
    {
        int loopIdx0 = 0;
        do {
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10015;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            } else {
            }
            if (gl_SubgroupInvocationID == loopIdx0) {
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001b;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            if (subgroupElect()) {
                break;
            }
            if (gl_SubgroupInvocationID == loopIdx0) {
            }
            {
                int loopIdx1 = 0;
                do {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10023;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    if (subgroupElect()) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10026;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                        break;
                    }
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002a;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    loopIdx1++;
                } while (true);
            }
            loopIdx0++;
        } while (true);
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

    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10000;
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
    for (int loopIdx0 = 0;
             loopIdx0 < inputA.a[1];
             loopIdx0++) {
        if (testBit(uvec4(0xaa771a7e, 0xdcb3e81d, 0x692e392c, 0x24367332), gl_SubgroupInvocationID)) {
            continue;
        } else {
            continue;
        }
        if (subgroupElect()) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10009;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        }
    }
    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000d;
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
    {
        int loopIdx0 = 0;
        do {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10010;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            for (int loopIdx1 = 0;;loopIdx1++,            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect()) {
                if (subgroupElect()) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10014;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    break;
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10018;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            }
            if (subgroupElect()) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001c;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                break;
            }
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
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10026;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            } else {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10026;
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
layout(constant_id = 11) const uint cmpIndex1 = 0u;


void main()
{

    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10000;
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
    if (testBit(uvec4(0xf58394bb, 0xa0fe454, 0x7420162c, 0x8f6783ac), gl_SubgroupInvocationID)) {
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10003;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10006;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        } else {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10006;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000c;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        if (testBit(uvec4(0xe8b71b60, 0x17871b8, 0x2f9b730c, 0x5b7e9f39), gl_SubgroupInvocationID)) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000f;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        } else {
        }
    }
    switch (gl_SubgroupInvocationID & 3) {
        case 0:
        case 1:
        {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10016;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            switch (gl_SubgroupInvocationID & 3) {
                case 0:
                case 1:
                {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001a;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    break;
                }
                case 2:
                case 3:
                {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001e;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    break;
                }
            }
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10023;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            } else {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10023;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            }
            break;
        }
        case 2:
        case 3:
        {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002b;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            for (int loopIdx0 = 0;;loopIdx0++,            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect()) {
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
            }
            switch (gl_SubgroupInvocationID & 3) {
                case 0:
                case 1:
                {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1003a;
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
    }



}
#version 450 core
#extension GL_KHR_shader_subgroup_ballot : enable
#extension GL_KHR_shader_subgroup_vote : enable
#extension GL_NV_shader_subgroup_partitioned : enable
#extension GL_EXT_subgroup_uniform_control_flow : enable
layout(local_size_x_id = 0, local_size_y_id = 1, local_size_z = 1) in;
layout(set=0, binding=2) coherent buffer OutputC { uint loc[]; } outputC;
layout(set=0, binding=1) coherent buffer OutputB { uvec4 b[]; } outputB;
layout(set=0, binding=0) coherent buffer InputA  { uint  a[]; } inputA;
layout(push_constant) uniform PC {
   // set to the real stride when writing out ballots, or zero when just counting
   int  invocationStride;
   // wildcard fields, for an example the dimensions of rendered area in the case of graphics shaders
   int  width;
   int  height;
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
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10009;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                break;
            }
        }
        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
        }
    }
    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
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
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10017;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                break;
            }
            case 3:
            {
                break;
            }
        }
        switch (inputA.a[4]) {
            case 5:
            {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001f;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                break;
            }
            case 4:
            {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10023;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                break;
            }
            case 6:
            {
                break;
            }
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10029;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
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
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10017;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                break;
            }
            case 3:
            {
                break;
            }
        }
        switch (inputA.a[4]) {
            case 5:
            {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001f;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                break;
            }
            case 4:
            {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10023;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                break;
            }
            case 6:
            {
                break;
            }
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10029;
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
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10005;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                loopIdx1++;
            } while (true);
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10008;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        {
            int loopIdx1 = 0;
            do {
                loopIdx1++;
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000b;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            } while (loopIdx1 < inputA.a[4]);
        }
    }
    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000f;
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
    switch (inputA.a[0]) {
        case 1:
        {
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10014;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            }
            break;
        }
        case 0:
        {
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
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001f;
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
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10025;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    break;
                }
            }
            break;
        }
        case 2:
        {
            if (subgroupElect()) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002c;
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
{

    if (testBit(uvec4(0x33d89e45, 0x6f5e7c36, 0x1e8005e, 0xe5d1b405), gl_SubgroupInvocationID)) {
        if (inputA.a[1] == 1) {
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10003;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        for (int loopIdx0 = 0;
                 loopIdx0 < gl_SubgroupInvocationID + 1;
                 loopIdx0++) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10006;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        }
    }
    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000a;
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
    if (inputA.a[3] == 3) {
        if (subgroupElect()) {
        }
    }
    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10010;
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
        {
            int loopIdx0 = 0;
            do {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10014;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                if (subgroupElect()) {
                    if (testBit(uvec4(0xdbd4e957, 0xdc8caff2, 0x1976770d, 0x5595f658), gl_SubgroupInvocationID)) {
                        break;
                    } else {
                        break;
                    }
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001d;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                loopIdx0++;
            } while (true);
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10020;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        if (inputA.a[1] == 1) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10023;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        } else {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10026;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        }
    } else {
        {
            int loopIdx0 = 0;
            do {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10014;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                if (subgroupElect()) {
                    if (testBit(uvec4(0xdbd4e957, 0xdc8caff2, 0x1976770d, 0x5595f658), gl_SubgroupInvocationID)) {
                        break;
                    } else {
                        break;
                    }
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001d;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                loopIdx0++;
            } while (true);
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10020;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        if (inputA.a[0] == 0) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10023;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        } else {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10026;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        }
    }
    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10041;
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
            {
                int loopIdx1 = 0;
                do {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10002;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    if (subgroupElect()) {
                        break;
                    }
                    loopIdx1++;
                } while (true);
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10008;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            if (subgroupElect()) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000b;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            }
            if (subgroupElect()) {
                break;
            }
            if (testBit(uvec4(0x6333ac82, 0xdc94fc9b, 0xa1505b46, 0xed7294a7), gl_SubgroupInvocationID)) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10012;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            }
            if (inputA.a[3] == 3) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10016;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            }
            loopIdx0++;
        } while (true);
    }
    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001a;
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
    {
        int loopIdx0 = 0;
        do {
            {
                int loopIdx1 = 0;
                do {
                    loopIdx1++;
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001e;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                } while (loopIdx1 < inputA.a[3]);
            }
            if (gl_SubgroupInvocationID == loopIdx0) {
            }
            if (subgroupElect()) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10024;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                break;
            }
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
            } else {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002a;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002d;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            if (inputA.a[3] == 3) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10030;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            } else {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10033;
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
layout(constant_id = 11) const uint cmpIndex1 = 0u;
layout(constant_id = 12) const uint cmpIndex2 = 0u;


void main()
{

    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10002;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        } else {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10005;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            if (inputA.a[3] == 3) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10008;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            } else {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000b;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            }
        }
    }
    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10010;
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
    switch (inputA.a[0]) {
        case 1:
        {
            if (inputA.a[0] == 0) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10015;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                {
                    int loopIdx0 = 0;
                    do {
                        loopIdx0++;
                    } while (loopIdx0 < inputA.a[4]);
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
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10021;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                        break;
                    }
                }
            } else {
                if (testBit(uvec4(0xc2817245, 0xbe5ff15e, 0x8692675c, 0x94c5e4ac), gl_SubgroupInvocationID)) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10027;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                } else {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10027;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002d;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                if (gl_LocalInvocationIndex >= inputA.a[cmpIndex2]) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10030;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                } else {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10030;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                }
            }
            break;
        }
        case 0:
        {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10039;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            {
                int loopIdx0 = 0;
                do {
                    for (int loopIdx1 = 0;
                             loopIdx1 < gl_SubgroupInvocationID + 1;
                             loopIdx1++) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1003d;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    }
                    if (testBit(uvec4(0xd7651b04, 0xf4522c5e, 0x34f51043, 0x708fbae2), gl_SubgroupInvocationID)) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10041;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    }
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10044;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    if (subgroupElect()) {
                        break;
                    }
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10049;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    break;
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1004c;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    for (int loopIdx1 = 0;
                             loopIdx1 < inputA.a[3];
                             loopIdx1++) {
                    }
                    loopIdx0++;
                } while (true);
            }
            break;
        }
        case 2:
        {
            switch (inputA.a[4]) {
                case 5:
                {
                    for (int loopIdx0 = 0;
                             loopIdx0 < gl_SubgroupInvocationID + 1;
                             loopIdx0++) {
                    }
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
            break;
        }
    }
    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1005f;
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

    if (inputA.a[1] == 1) {
        {
            int loopIdx0 = 0;
            do {
                loopIdx0++;
                if (inputA.a[3] == 3) {
                }
                if (testBit(uvec4(0xbc435729, 0x515db618, 0xfbddefa, 0xc044afed), gl_SubgroupInvocationID)) {
                } else {
                }
            } while (loopIdx0 < inputA.a[3]);
        }
        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10009;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            if (inputA.a[1] == 1) {
            } else {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000d;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10010;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        }
    } else {
        if (inputA.a[0] == 0) {
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
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001b;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    break;
                }
                case 3:
                {
                    break;
                }
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10021;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        } else {
            if (subgroupElect()) {
            }
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

    if (inputA.a[3] == 3) {
        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
            if (testBit(uvec4(0xaa771a7e, 0xdcb3e81d, 0x692e392c, 0x24367332), gl_SubgroupInvocationID)) {
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10004;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            {
                int loopIdx0 = 0;
                do {
                    loopIdx0++;
                } while (loopIdx0 < inputA.a[4]);
            }
        }
    }
    if (inputA.a[1] == 1) {
        return;
        {
            int loopIdx0 = 0;
            do {
                for (int loopIdx1 = 0;
                         loopIdx1 < gl_SubgroupInvocationID + 1;
                         loopIdx1++) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000e;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10011;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                if (gl_SubgroupInvocationID == loopIdx0) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10014;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                } else {
                }
                if (subgroupElect()) {
                    break;
                }
                {
                    int loopIdx1 = 0;
                    do {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001c;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                        if (subgroupElect()) {
                            if (testBit(uvec4(0xaa771a7e, 0xdcb3e81d, 0x692e392c, 0x24367332), gl_SubgroupInvocationID)) {
                                break;
                            } else {
                                break;
                            }
                        }
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10025;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                        loopIdx1++;
                    } while (true);
                }
                switch (gl_SubgroupInvocationID & 3) {
                    case 0:
                    {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002a;
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
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10030;
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
    } else {
        switch (gl_SubgroupInvocationID & 3) {
            case 0:
            case 1:
            {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1003a;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1003d;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10040;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                for (int loopIdx0 = 0;
                         loopIdx0 < inputA.a[4];
                         loopIdx0++) {
                }
                break;
            }
            case 2:
            case 3:
            {
                if (inputA.a[3] == 3) {
                } else {
                }
                if (subgroupElect()) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1004a;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                }
                break;
            }
        }
        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex2]) {
            {
                int loopIdx0 = 0;
                do {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10051;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    if (subgroupElect()) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10054;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                        if (testBit(uvec4(0xaa771a7e, 0xdcb3e81d, 0x692e392c, 0x24367332), gl_SubgroupInvocationID)) {
                            break;
                        } else {
                            break;
                        }
                    }
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1005c;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    loopIdx0++;
                } while (true);
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1005f;
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
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10065;
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


void main()
{

    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10000;
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
    for (int loopIdx0 = 0;
             loopIdx0 < inputA.a[1];
             loopIdx0++) {
        if (testBit(uvec4(0xaa771a7e, 0xdcb3e81d, 0x692e392c, 0x24367332), gl_SubgroupInvocationID)) {
            continue;
        } else {
            continue;
        }
        if (subgroupElect()) {
            if (subgroupElect()) {
            }
            continue;
        }
    }
    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000e;
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
    if (testBit(uvec4(0x9020d042, 0x8d315ce1, 0xe0d3cfa8, 0xa130abac), gl_SubgroupInvocationID)) {
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10011;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        for (int loopIdx0 = 0;;loopIdx0++,        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect()) {
            if (subgroupElect()) {
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10016;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            if (subgroupElect()) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10019;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                break;
            }
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
        for (int loopIdx0 = 0;
                 loopIdx0 < gl_SubgroupInvocationID + 1;
                 loopIdx0++) {
            if (inputA.a[1] == 1) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10028;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            } else {
            }
            for (int loopIdx1 = 0;
                     loopIdx1 < inputA.a[4];
                     loopIdx1++) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002d;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            }
        }
    } else {
        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
            {
                int loopIdx0 = 0;
                do {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10034;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    if (subgroupElect()) {
                        break;
                    }
                    loopIdx0++;
                } while (true);
            }
        } else {
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1003c;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            } else {
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
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10045;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10048;
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
    switch (gl_SubgroupInvocationID & 3) {
        case 0:
        case 1:
        {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10004;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            if (subgroupElect()) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10007;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                {
                    int loopIdx0 = 0;
                    do {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000a;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                        if (subgroupElect()) {
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000d;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                            break;
                        }
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10011;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                        loopIdx0++;
                    } while (true);
                }
            }
            break;
        }
        case 2:
        case 3:
        {
            for (int loopIdx0 = 0;
                     loopIdx0 < gl_SubgroupInvocationID + 1;
                     loopIdx0++) {
                continue;
                break;
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001b;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
                if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001f;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                } else {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001f;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10025;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            } else {
                {
                    int loopIdx0 = 0;
                    do {
                        loopIdx0++;
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10029;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    } while (loopIdx0 < inputA.a[1]);
                }
                for (int loopIdx0 = 0;
                         loopIdx0 < inputA.a[4];
                         loopIdx0++) {
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
layout(constant_id = 12) const uint cmpIndex2 = 0u;


void main()
{

    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10000;
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
    if (subgroupElect()) {
        switch (inputA.a[4]) {
            case 5:
            {
                break;
            }
            case 4:
            {
                for (int loopIdx0 = 0;;loopIdx0++,                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect()) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10008;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    if (subgroupElect()) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000b;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                        break;
                    }
                }
                break;
            }
            case 6:
            {
                for (int loopIdx0 = 0;
                         loopIdx0 < gl_SubgroupInvocationID + 1;
                         loopIdx0++) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10013;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10016;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                break;
            }
        }
        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
            {
                int loopIdx0 = 0;
                do {
                    if (subgroupElect()) {
                        break;
                    }
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001f;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    loopIdx0++;
                } while (true);
            }
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10023;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            } else {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10023;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            }
        } else {
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex2]) {
            } else {
            }
            if (subgroupElect()) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002e;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10031;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
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


void main()
{

    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10000;
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
    for (int loopIdx0 = 0;
             loopIdx0 < inputA.a[5];
             loopIdx0++) {
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
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10008;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                        break;
                    }
                }
                if (inputA.a[0] == 0) {
                }
            } while (loopIdx1 < inputA.a[2]);
        }
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
                if (inputA.a[0] == 12345) {
                    while (true) {
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    }
                }
                if (subgroupElect()) {
                    break;
                }
                {
                    int loopIdx1 = 0;
                    do {
                        loopIdx1++;
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001d;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    } while (loopIdx1 < inputA.a[3]);
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10020;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                switch (gl_SubgroupInvocationID & 3) {
                    case 0:
                    {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10024;
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
                loopIdx0++;
            } while (true);
        }
    } else {
        return;
        for (int loopIdx0 = 0;
                 loopIdx0 < gl_SubgroupInvocationID + 1;
                 loopIdx0++) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10032;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            if (inputA.a[0] == 0) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10035;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            } else {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10035;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1003b;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        }
    }
    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1003f;
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

    switch (gl_SubgroupInvocationID & 3) {
        case 0:
        {
            {
                int loopIdx0 = 0;
                do {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10003;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    if (gl_SubgroupInvocationID == loopIdx0) {
                    }
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10007;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    if (inputA.a[2] == 2) {
                    } else {
                    }
                    if (subgroupElect()) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000d;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                        break;
                    }
                    switch (loopIdx0) {
                        case 1: {
                            break;
                        }
                        case 2: {
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10015;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                            break;
                        }
                        default: {
                            break;
                        }
                    }
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001b;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    if (inputA.a[2] == 2) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001e;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    } else {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10021;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    }
                    loopIdx0++;
                } while (true);
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10025;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            break;
        }
        case 1:
        {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10029;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            break;
        }
        case 2:
        {
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
                {
                    int loopIdx0 = 0;
                    do {
                        if (subgroupElect()) {
                            break;
                        }
                        loopIdx0++;
                    } while (true);
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10033;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10036;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            break;
        }
        case 3:
        {
            if (inputA.a[1] == 1) {
                if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1003c;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1003f;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            } else {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10042;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                for (int loopIdx0 = 0;;loopIdx0++,                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect()) {
                    if (subgroupElect()) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10046;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                        break;
                    }
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1004a;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1004d;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10050;
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


void main()
{

    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10000;
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
    if (subgroupElect()) {
        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
            for (int loopIdx0 = 0;;loopIdx0++,            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect()) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10005;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                if (subgroupElect()) {
                    break;
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000a;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            }
            {
                int loopIdx0 = 0;
                do {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000e;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    if (subgroupElect()) {
                        break;
                    }
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10013;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    loopIdx0++;
                } while (true);
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10016;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        } else {
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001a;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            } else {
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001e;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex2]) {
            }
        }
        for (int loopIdx0 = 0;
                 loopIdx0 < inputA.a[2];
                 loopIdx0++) {
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
            if (gl_SubgroupInvocationID == loopIdx0) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002f;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            } else {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002f;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10035;
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
        void func0() {
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex3]) {
                if (subgroupElect()) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002f;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10032;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                for (int loopIdx0 = 0;
                         loopIdx0 < inputA.a[4];
                         loopIdx0++) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10035;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                }
            } else {
                if (gl_LocalInvocationIndex >= inputA.a[cmpIndex4]) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1003a;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                }
                if (inputA.a[1] == 1) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1003e;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                }
            }
            if (testBit(uvec4(0xaee27654, 0x51a0fa5f, 0x3f5cfafd, 0xa3b791c0), gl_SubgroupInvocationID)) {
                for (int loopIdx0 = 0;
                         loopIdx0 < inputA.a[5];
                         loopIdx0++) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10044;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                }
                if (subgroupElect()) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10048;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                }
            } else {
                {
                    int loopIdx0 = 0;
                    do {
                        if (subgroupElect()) {
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1004e;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                            break;
                        }
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10052;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                        loopIdx0++;
                    } while (true);
                }
                if (testBit(uvec4(0xd49506e6, 0x69788d4b, 0x13e034bc, 0xcbb3b425), gl_SubgroupInvocationID)) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10056;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                } else {
                }
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1005b;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        }


void main()
{

    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10002;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        } else {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10005;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            if (inputA.a[1] == 1) {
                for (int loopIdx0 = 0;;loopIdx0++,                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect()) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10009;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    if (subgroupElect()) {
                        break;
                    }
                }
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10010;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            switch (inputA.a[0]) {
                case 1:
                {
                    if (inputA.a[3] == 3) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10015;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    } else {
                    }
                    break;
                }
                case 0:
                {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001b;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    break;
                }
                case 2:
                {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001f;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex2]) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10022;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    }
                    break;
                }
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10027;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002a;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        func0();
    }



}
#version 450 core
#extension GL_KHR_shader_subgroup_ballot : enable
#extension GL_KHR_shader_subgroup_vote : enable
#extension GL_NV_shader_subgroup_partitioned : enable
#extension GL_EXT_subgroup_uniform_control_flow : enable
layout(local_size_x_id = 0, local_size_y_id = 1, local_size_z = 1) in;
layout(set=0, binding=2) coherent buffer OutputC { uint loc[]; } outputC;
layout(set=0, binding=1) coherent buffer OutputB { uvec4 b[]; } outputB;
layout(set=0, binding=0) coherent buffer InputA  { uint  a[]; } inputA;
layout(push_constant) uniform PC {
   // set to the real stride when writing out ballots, or zero when just counting
   int  invocationStride;
   // wildcard fields, for an example the dimensions of rendered area in the case of graphics shaders
   int  width;
   int  height;
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

    if (inputA.a[3] == 3) {
        {
            int loopIdx0 = 0;
            do {
                loopIdx0++;
                if (inputA.a[3] == 3) {
                    if (gl_SubgroupInvocationID == loopIdx0) {
                    } else {
                    }
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10006;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                }
                continue;
            } while (loopIdx0 < inputA.a[3]);
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000b;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        if (subgroupElect()) {
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
                if (inputA.a[0] == 0) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10010;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                }
                if (testBit(uvec4(0x9181cd83, 0xdcab9b30, 0x521a842f, 0x1fc09387), gl_SubgroupInvocationID)) {
                } else {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10015;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10018;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            }
        }
    } else {
        if (testBit(uvec4(0xbc435729, 0x515db618, 0xfbddefa, 0xc044afed), gl_SubgroupInvocationID)) {
            {
                int loopIdx0 = 0;
                do {
                    if (subgroupElect()) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10020;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    }
                    for (int loopIdx1 = 0;
                             loopIdx1 < inputA.a[4];
                             loopIdx1++) {
                    }
                    if (subgroupElect()) {
                        break;
                    }
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10028;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    if (inputA.a[1] == 1) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002b;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    } else {
                    }
                    loopIdx0++;
                } while (true);
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10030;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            {
                int loopIdx0 = 0;
                do {
                    loopIdx0++;
                    if (inputA.a[0] == 0) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10034;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    }
                    if (testBit(uvec4(0x4d9ac54c, 0xd2e8e747, 0xd060f6db, 0x56dd3bd3), gl_SubgroupInvocationID)) {
                    } else {
                    }
                } while (loopIdx0 < inputA.a[5]);
            }
        }
        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
            switch (gl_SubgroupInvocationID & 3) {
                case 0:
                {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1003f;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex2]) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10042;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    } else {
                    }
                    break;
                }
                case 1:
                {
                    if (inputA.a[0] == 0) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10049;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    } else {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1004c;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    }
                    break;
                }
                case 2:
                {
                    if (subgroupElect()) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10052;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    }
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10055;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    break;
                }
                case 3:
                {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10059;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    break;
                }
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1005d;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            if (inputA.a[1] == 1) {
                if (testBit(uvec4(0xde0cfc02, 0x4527e14f, 0xb6b1b370, 0x61b047b3), gl_SubgroupInvocationID)) {
                } else {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10062;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10065;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            } else {
                if (testBit(uvec4(0xde0cfc02, 0x4527e14f, 0xb6b1b370, 0x61b047b3), gl_SubgroupInvocationID)) {
                } else {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10062;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10065;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10070;
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
    for (int loopIdx0 = 0;
             loopIdx0 < inputA.a[1];
             loopIdx0++) {
        if (testBit(uvec4(0xaa771a7e, 0xdcb3e81d, 0x692e392c, 0x24367332), gl_SubgroupInvocationID)) {
            continue;
        } else {
            continue;
        }
        if (subgroupElect()) {
            if (subgroupElect()) {
                for (int loopIdx1 = 0;
                         loopIdx1 < inputA.a[1];
                         loopIdx1++) {
                }
                {
                    int loopIdx1 = 0;
                    do {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000d;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                        if (subgroupElect()) {
                            break;
                        }
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10012;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                        loopIdx1++;
                    } while (true);
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10015;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            }
            if (testBit(uvec4(0xaa771a7e, 0xdcb3e81d, 0x692e392c, 0x24367332), gl_SubgroupInvocationID)) {
                break;
                if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001b;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                } else {
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

    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10000;
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
        for (int loopIdx0 = 0;
                 loopIdx0 < inputA.a[4];
                 loopIdx0++) {
            {
                int loopIdx1 = 0;
                do {
                    if (inputA.a[3] == 3) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10006;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    } else {
                    }
                    if (testBit(uvec4(0xcc6662ac, 0xdcbb39e6, 0xf7e9854, 0x42271730), gl_SubgroupInvocationID)) {
                        break;
                    } else {
                        break;
                    }
                    if (subgroupElect()) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10010;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                        break;
                    }
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10014;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    {
                        int loopIdx2 = 0;
                        do {
                            loopIdx2++;
                        } while (loopIdx2 < inputA.a[2]);
                    }
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10018;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    if (inputA.a[0] == 0) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001b;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    } else {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001e;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    }
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10021;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    loopIdx1++;
                } while (true);
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10024;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            break;
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10027;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002a;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        if (testBit(uvec4(0xcc6662ac, 0xdcbb39e6, 0xf7e9854, 0x42271730), gl_SubgroupInvocationID)) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002d;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            {
                int loopIdx0 = 0;
                do {
                    loopIdx0++;
                    {
                        int loopIdx1 = 0;
                        do {
                            loopIdx1++;
                        } while (loopIdx1 < inputA.a[3]);
                    }
                    break;
                } while (loopIdx0 < inputA.a[5]);
            }
            {
                int loopIdx0 = 0;
                do {
                    loopIdx0++;
                    if (subgroupElect()) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10036;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    }
                    if (testBit(uvec4(0xf58394bb, 0xa0fe454, 0x7420162c, 0x8f6783ac), gl_SubgroupInvocationID)) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1003a;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    } else {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1003a;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    }
                } while (loopIdx0 < inputA.a[3]);
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10041;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        } else {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002d;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            {
                int loopIdx0 = 0;
                do {
                    loopIdx0++;
                    {
                        int loopIdx1 = 0;
                        do {
                            loopIdx1++;
                        } while (loopIdx1 < inputA.a[3]);
                    }
                    break;
                } while (loopIdx0 < inputA.a[5]);
            }
            {
                int loopIdx0 = 0;
                do {
                    loopIdx0++;
                    if (subgroupElect()) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10036;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    }
                    if (testBit(uvec4(0xf58394bb, 0xa0fe454, 0x7420162c, 0x8f6783ac), gl_SubgroupInvocationID)) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1003a;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    } else {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1003a;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    }
                } while (loopIdx0 < inputA.a[3]);
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10041;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        }
    } else {
        for (int loopIdx0 = 0;
                 loopIdx0 < inputA.a[4];
                 loopIdx0++) {
            {
                int loopIdx1 = 0;
                do {
                    if (inputA.a[0] == 0) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10006;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    } else {
                    }
                    if (testBit(uvec4(0xcc6662ac, 0xdcbb39e6, 0xf7e9854, 0x42271730), gl_SubgroupInvocationID)) {
                        break;
                    } else {
                        break;
                    }
                    if (subgroupElect()) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10010;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                        break;
                    }
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10014;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    {
                        int loopIdx2 = 0;
                        do {
                            loopIdx2++;
                        } while (loopIdx2 < inputA.a[2]);
                    }
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10018;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    if (inputA.a[1] == 1) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001b;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    } else {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001e;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    }
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10021;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    loopIdx1++;
                } while (true);
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10024;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            break;
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10027;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002a;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        if (testBit(uvec4(0xcc6662ac, 0xdcbb39e6, 0xf7e9854, 0x42271730), gl_SubgroupInvocationID)) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002d;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            {
                int loopIdx0 = 0;
                do {
                    loopIdx0++;
                    {
                        int loopIdx1 = 0;
                        do {
                            loopIdx1++;
                        } while (loopIdx1 < inputA.a[3]);
                    }
                    break;
                } while (loopIdx0 < inputA.a[5]);
            }
            {
                int loopIdx0 = 0;
                do {
                    loopIdx0++;
                    if (subgroupElect()) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10036;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    }
                    if (testBit(uvec4(0xf58394bb, 0xa0fe454, 0x7420162c, 0x8f6783ac), gl_SubgroupInvocationID)) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1003a;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    } else {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1003a;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    }
                } while (loopIdx0 < inputA.a[3]);
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10041;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        } else {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002d;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            {
                int loopIdx0 = 0;
                do {
                    loopIdx0++;
                    {
                        int loopIdx1 = 0;
                        do {
                            loopIdx1++;
                        } while (loopIdx1 < inputA.a[3]);
                    }
                    break;
                } while (loopIdx0 < inputA.a[5]);
            }
            {
                int loopIdx0 = 0;
                do {
                    loopIdx0++;
                    if (subgroupElect()) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10036;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    }
                    if (testBit(uvec4(0xf58394bb, 0xa0fe454, 0x7420162c, 0x8f6783ac), gl_SubgroupInvocationID)) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1003a;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    } else {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1003a;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    }
                } while (loopIdx0 < inputA.a[3]);
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10041;
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


void main()
{

    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10000;
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
    if (subgroupElect()) {
        switch (inputA.a[4]) {
            case 5:
            {
                break;
            }
            case 4:
            {
                for (int loopIdx0 = 0;;loopIdx0++,                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect()) {
                    if (subgroupElect()) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10009;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    }
                    if (inputA.a[2] == 2) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000d;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    }
                    if (subgroupElect()) {
                        break;
                    }
                    if (subgroupElect()) {
                    }
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10015;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    if (inputA.a[1] == 1) {
                    } else {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10019;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    }
                }
                break;
            }
            case 6:
            {
                if (subgroupElect()) {
                    {
                        int loopIdx0 = 0;
                        do {
                            if (subgroupElect()) {
                                break;
                            }
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10024;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                            loopIdx0++;
                        } while (true);
                    }
                }
                break;
            }
        }
        if (subgroupElect()) {
            if (subgroupElect()) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002c;
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
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10036;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            }
        }
    }
    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1003b;
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

    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10000;
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
    for (int loopIdx0 = 0;
             loopIdx0 < inputA.a[5];
             loopIdx0++) {
        {
            int loopIdx1 = 0;
            do {
                loopIdx1++;
                switch (gl_SubgroupInvocationID & 3) {
                    case 0:
                    case 1:
                    {
                        continue;
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10007;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
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
                        break;
                    }
                    case 2:
                    case 3:
                    {
                        for (int loopIdx2 = 0;;loopIdx2++,                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect()) {
                            if (subgroupElect()) {
                                outputC.loc[gl_LocalInvocationIndex]++;
                                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10017;
                                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                                break;
                            }
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001b;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                        }
                        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001f;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                        }
                        break;
                    }
                }
                for (int loopIdx2 = 0;
                         loopIdx2 < gl_SubgroupInvocationID + 1;
                         loopIdx2++) {
                    if (subgroupElect()) {
                    }
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10027;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002a;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            } while (loopIdx1 < inputA.a[2]);
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

    switch (gl_SubgroupInvocationID & 3) {
        case 0:
        {
            {
                int loopIdx0 = 0;
                do {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10003;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    if (gl_SubgroupInvocationID == loopIdx0) {
                        if (subgroupElect()) {
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10007;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                        }
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000a;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                        {
                            int loopIdx1 = 0;
                            do {
                                loopIdx1++;
                                outputC.loc[gl_LocalInvocationIndex]++;
                                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000d;
                                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                            } while (loopIdx1 < inputA.a[3]);
                        }
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10010;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    }
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10013;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    if (subgroupElect()) {
                        break;
                    }
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10018;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    if (subgroupElect()) {
                        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
                        }
                        if (inputA.a[2] == 2) {
                        }
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001f;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    }
                    {
                        int loopIdx1 = 0;
                        do {
                            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
                            }
                            break;
                            if (subgroupElect()) {
                                break;
                            }
                            if (testBit(uvec4(0x6a16fcd3, 0x9dcb7399, 0x43a406e7, 0x20f1c08), gl_SubgroupInvocationID)) {
                                outputC.loc[gl_LocalInvocationIndex]++;
                                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002a;
                                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                            } else {
                                outputC.loc[gl_LocalInvocationIndex]++;
                                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002a;
                                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                            }
                            switch (inputA.a[4]) {
                                case 5:
                                {
                                    break;
                                }
                                case 4:
                                {
                                    outputC.loc[gl_LocalInvocationIndex]++;
                                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10034;
                                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                                    break;
                                }
                                case 6:
                                {
                                    outputC.loc[gl_LocalInvocationIndex]++;
                                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10038;
                                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                                    break;
                                }
                            }
                            loopIdx1++;
                        } while (true);
                    }
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1003d;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    loopIdx0++;
                } while (true);
            }
            break;
        }
        case 1:
        {
            break;
        }
        case 2:
        {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10044;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            break;
        }
        case 3:
        {
            break;
        }
    }
    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1004a;
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
{

    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10000;
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
    if (subgroupElect()) {
        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
            for (int loopIdx0 = 0;;loopIdx0++,            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect()) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10005;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                if (testBit(uvec4(0x24f2eba6, 0xda5b1bd3, 0x7ef57eb5, 0x5d5c9433), gl_SubgroupInvocationID)) {
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10009;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                break;
                if (subgroupElect()) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000d;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    break;
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10011;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                if (gl_SubgroupInvocationID == loopIdx0) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10014;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                } else {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10017;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001a;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                for (int loopIdx1 = 0;
                         loopIdx1 < inputA.a[4];
                         loopIdx1++) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001d;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10020;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            }
        } else {
            for (int loopIdx0 = 0;;loopIdx0++,            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect()) {
                if (gl_SubgroupInvocationID == loopIdx0) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10026;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                } else {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10029;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                }
                if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002d;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                } else {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002d;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10033;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                if (subgroupElect()) {
                    break;
                }
                if (gl_SubgroupInvocationID == loopIdx0) {
                } else {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1003a;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                }
                if (gl_LocalInvocationIndex >= inputA.a[cmpIndex2]) {
                }
            }
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex3]) {
                if (gl_LocalInvocationIndex >= inputA.a[cmpIndex4]) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10042;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                } else {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10042;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10048;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            } else {
                if (gl_LocalInvocationIndex >= inputA.a[cmpIndex5]) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10042;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                } else {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10042;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10048;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10055;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        }
    }
    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10059;
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

    switch (gl_SubgroupInvocationID & 3) {
        case 0:
        case 1:
        {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10002;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            for (int loopIdx0 = 0;;loopIdx0++,            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true)) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10005;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                if (subgroupElect()) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10008;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    break;
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000c;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            }
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10010;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            } else {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10010;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            }
            break;
        }
        case 2:
        case 3:
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
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001c;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    break;
                }
            }
            if (inputA.a[0] == 0) {
            } else {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10022;
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
        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10002;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        } else {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10005;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        }
        if (inputA.a[3] == 3) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10009;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        }
    }
    for (int loopIdx0 = 0;;loopIdx0++,    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true)) {
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000e;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        {
            int loopIdx1 = 0;
            do {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10011;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                if (subgroupElect()) {
                    break;
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10016;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                loopIdx1++;
            } while (true);
        }
        if (gl_SubgroupInvocationID == loopIdx0) {
        }
        if (subgroupElect()) {
            break;
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001e;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex2]) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10021;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10024;
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

    if (inputA.a[2] == 2) {
        {
            int loopIdx0 = 0;
            do {
                loopIdx0++;
            } while (loopIdx0 < inputA.a[3]);
        }
        if (inputA.a[3] == 3) {
        } else {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10005;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        }
    }
    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10009;
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
    if (inputA.a[3] == 3) {
        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000d;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        }
        if (subgroupElect()) {
        }
    }
    {
        int loopIdx0 = 0;
        do {
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10015;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            } else {
            }
            if (gl_SubgroupInvocationID == loopIdx0) {
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001b;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            if (subgroupElect()) {
                break;
            }
            if (gl_SubgroupInvocationID == loopIdx0) {
            }
            {
                int loopIdx1 = 0;
                do {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10023;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    if (subgroupElect()) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10026;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        break;
                    }
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002a;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    loopIdx1++;
                } while (true);
            }
            loopIdx0++;
        } while (true);
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

    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10000;
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
    for (int loopIdx0 = 0;
             loopIdx0 < inputA.a[1];
             loopIdx0++) {
        if (testBit(uvec4(0xaa771a7e, 0xdcb3e81d, 0x692e392c, 0x24367332), gl_SubgroupInvocationID)) {
            continue;
        } else {
            continue;
        }
        if (subgroupElect()) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10009;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        }
    }
    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000d;
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
    {
        int loopIdx0 = 0;
        do {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10010;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            for (int loopIdx1 = 0;;loopIdx1++,            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true)) {
                if (subgroupElect()) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10014;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    break;
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10018;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            }
            if (subgroupElect()) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001c;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                break;
            }
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
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10026;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            } else {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10026;
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
layout(constant_id = 11) const uint cmpIndex1 = 0u;


void main()
{

    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10000;
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
    if (testBit(uvec4(0xf58394bb, 0xa0fe454, 0x7420162c, 0x8f6783ac), gl_SubgroupInvocationID)) {
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10003;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10006;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        } else {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10006;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000c;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        if (testBit(uvec4(0xe8b71b60, 0x17871b8, 0x2f9b730c, 0x5b7e9f39), gl_SubgroupInvocationID)) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000f;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        } else {
        }
    }
    switch (gl_SubgroupInvocationID & 3) {
        case 0:
        case 1:
        {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10016;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            switch (gl_SubgroupInvocationID & 3) {
                case 0:
                case 1:
                {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001a;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    break;
                }
                case 2:
                case 3:
                {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001e;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    break;
                }
            }
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10023;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            } else {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10023;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            }
            break;
        }
        case 2:
        case 3:
        {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002b;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            for (int loopIdx0 = 0;;loopIdx0++,            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true)) {
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
            }
            switch (gl_SubgroupInvocationID & 3) {
                case 0:
                case 1:
                {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1003a;
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
    }



}
#version 450 core
#extension GL_KHR_shader_subgroup_ballot : enable
#extension GL_KHR_shader_subgroup_vote : enable
#extension GL_NV_shader_subgroup_partitioned : enable
#extension GL_EXT_subgroup_uniform_control_flow : enable
layout(local_size_x_id = 0, local_size_y_id = 1, local_size_z = 1) in;
layout(set=0, binding=2) coherent buffer OutputC { uint loc[]; } outputC;
layout(set=0, binding=1) coherent buffer OutputB { uvec4 b[]; } outputB;
layout(set=0, binding=0) coherent buffer InputA  { uint  a[]; } inputA;
layout(push_constant) uniform PC {
   // set to the real stride when writing out ballots, or zero when just counting
   int  invocationStride;
   // wildcard fields, for an example the dimensions of rendered area in the case of graphics shaders
   int  width;
   int  height;
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
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10009;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                break;
            }
        }
        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
        }
    }
    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
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
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10017;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                break;
            }
            case 3:
            {
                break;
            }
        }
        switch (inputA.a[4]) {
            case 5:
            {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001f;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                break;
            }
            case 4:
            {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10023;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                break;
            }
            case 6:
            {
                break;
            }
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10029;
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
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10017;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                break;
            }
            case 3:
            {
                break;
            }
        }
        switch (inputA.a[4]) {
            case 5:
            {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001f;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                break;
            }
            case 4:
            {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10023;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                break;
            }
            case 6:
            {
                break;
            }
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10029;
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
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10005;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                loopIdx1++;
            } while (true);
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10008;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        {
            int loopIdx1 = 0;
            do {
                loopIdx1++;
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000b;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            } while (loopIdx1 < inputA.a[4]);
        }
    }
    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000f;
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
    switch (inputA.a[0]) {
        case 1:
        {
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10014;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            }
            break;
        }
        case 0:
        {
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
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001f;
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
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10025;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    break;
                }
            }
            break;
        }
        case 2:
        {
            if (subgroupElect()) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002c;
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
{

    if (testBit(uvec4(0x33d89e45, 0x6f5e7c36, 0x1e8005e, 0xe5d1b405), gl_SubgroupInvocationID)) {
        if (inputA.a[1] == 1) {
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10003;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        for (int loopIdx0 = 0;
                 loopIdx0 < gl_SubgroupInvocationID + 1;
                 loopIdx0++) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10006;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        }
    }
    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000a;
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
    if (inputA.a[3] == 3) {
        if (subgroupElect()) {
        }
    }
    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10010;
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
        {
            int loopIdx0 = 0;
            do {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10014;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                if (subgroupElect()) {
                    if (testBit(uvec4(0xdbd4e957, 0xdc8caff2, 0x1976770d, 0x5595f658), gl_SubgroupInvocationID)) {
                        break;
                    } else {
                        break;
                    }
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001d;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                loopIdx0++;
            } while (true);
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10020;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        if (inputA.a[1] == 1) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10023;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        } else {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10026;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        }
    } else {
        {
            int loopIdx0 = 0;
            do {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10014;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                if (subgroupElect()) {
                    if (testBit(uvec4(0xdbd4e957, 0xdc8caff2, 0x1976770d, 0x5595f658), gl_SubgroupInvocationID)) {
                        break;
                    } else {
                        break;
                    }
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001d;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                loopIdx0++;
            } while (true);
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10020;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        if (inputA.a[0] == 0) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10023;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        } else {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10026;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        }
    }
    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10041;
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
            {
                int loopIdx1 = 0;
                do {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10002;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    if (subgroupElect()) {
                        break;
                    }
                    loopIdx1++;
                } while (true);
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10008;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            if (subgroupElect()) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000b;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            }
            if (subgroupElect()) {
                break;
            }
            if (testBit(uvec4(0x6333ac82, 0xdc94fc9b, 0xa1505b46, 0xed7294a7), gl_SubgroupInvocationID)) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10012;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            }
            if (inputA.a[3] == 3) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10016;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            }
            loopIdx0++;
        } while (true);
    }
    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001a;
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
    {
        int loopIdx0 = 0;
        do {
            {
                int loopIdx1 = 0;
                do {
                    loopIdx1++;
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001e;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                } while (loopIdx1 < inputA.a[3]);
            }
            if (gl_SubgroupInvocationID == loopIdx0) {
            }
            if (subgroupElect()) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10024;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                break;
            }
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
            } else {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002a;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002d;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            if (inputA.a[3] == 3) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10030;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            } else {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10033;
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
layout(constant_id = 11) const uint cmpIndex1 = 0u;
layout(constant_id = 12) const uint cmpIndex2 = 0u;


void main()
{

    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10002;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        } else {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10005;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            if (inputA.a[3] == 3) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10008;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            } else {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000b;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            }
        }
    }
    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10010;
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
    switch (inputA.a[0]) {
        case 1:
        {
            if (inputA.a[0] == 0) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10015;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                {
                    int loopIdx0 = 0;
                    do {
                        loopIdx0++;
                    } while (loopIdx0 < inputA.a[4]);
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
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10021;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        break;
                    }
                }
            } else {
                if (testBit(uvec4(0xc2817245, 0xbe5ff15e, 0x8692675c, 0x94c5e4ac), gl_SubgroupInvocationID)) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10027;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                } else {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10027;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002d;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                if (gl_LocalInvocationIndex >= inputA.a[cmpIndex2]) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10030;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                } else {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10030;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
            }
            break;
        }
        case 0:
        {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10039;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            {
                int loopIdx0 = 0;
                do {
                    for (int loopIdx1 = 0;
                             loopIdx1 < gl_SubgroupInvocationID + 1;
                             loopIdx1++) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1003d;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    }
                    if (testBit(uvec4(0xd7651b04, 0xf4522c5e, 0x34f51043, 0x708fbae2), gl_SubgroupInvocationID)) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10041;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    }
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10044;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    if (subgroupElect()) {
                        break;
                    }
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10049;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    break;
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1004c;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    for (int loopIdx1 = 0;
                             loopIdx1 < inputA.a[3];
                             loopIdx1++) {
                    }
                    loopIdx0++;
                } while (true);
            }
            break;
        }
        case 2:
        {
            switch (inputA.a[4]) {
                case 5:
                {
                    for (int loopIdx0 = 0;
                             loopIdx0 < gl_SubgroupInvocationID + 1;
                             loopIdx0++) {
                    }
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
            break;
        }
    }
    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1005f;
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

    if (inputA.a[1] == 1) {
        {
            int loopIdx0 = 0;
            do {
                loopIdx0++;
                if (inputA.a[3] == 3) {
                }
                if (testBit(uvec4(0xbc435729, 0x515db618, 0xfbddefa, 0xc044afed), gl_SubgroupInvocationID)) {
                } else {
                }
            } while (loopIdx0 < inputA.a[3]);
        }
        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10009;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            if (inputA.a[1] == 1) {
            } else {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000d;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10010;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        }
    } else {
        if (inputA.a[0] == 0) {
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
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001b;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    break;
                }
                case 3:
                {
                    break;
                }
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10021;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        } else {
            if (subgroupElect()) {
            }
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

    if (inputA.a[3] == 3) {
        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
            if (testBit(uvec4(0xaa771a7e, 0xdcb3e81d, 0x692e392c, 0x24367332), gl_SubgroupInvocationID)) {
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10004;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            {
                int loopIdx0 = 0;
                do {
                    loopIdx0++;
                } while (loopIdx0 < inputA.a[4]);
            }
        }
    }
    if (inputA.a[1] == 1) {
        return;
        {
            int loopIdx0 = 0;
            do {
                for (int loopIdx1 = 0;
                         loopIdx1 < gl_SubgroupInvocationID + 1;
                         loopIdx1++) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000e;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10011;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                if (gl_SubgroupInvocationID == loopIdx0) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10014;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                } else {
                }
                if (subgroupElect()) {
                    break;
                }
                {
                    int loopIdx1 = 0;
                    do {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001c;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        if (subgroupElect()) {
                            if (testBit(uvec4(0xaa771a7e, 0xdcb3e81d, 0x692e392c, 0x24367332), gl_SubgroupInvocationID)) {
                                break;
                            } else {
                                break;
                            }
                        }
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10025;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        loopIdx1++;
                    } while (true);
                }
                switch (gl_SubgroupInvocationID & 3) {
                    case 0:
                    {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002a;
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
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10030;
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
    } else {
        switch (gl_SubgroupInvocationID & 3) {
            case 0:
            case 1:
            {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1003a;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1003d;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10040;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                for (int loopIdx0 = 0;
                         loopIdx0 < inputA.a[4];
                         loopIdx0++) {
                }
                break;
            }
            case 2:
            case 3:
            {
                if (inputA.a[3] == 3) {
                } else {
                }
                if (subgroupElect()) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1004a;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
                break;
            }
        }
        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex2]) {
            {
                int loopIdx0 = 0;
                do {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10051;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    if (subgroupElect()) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10054;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        if (testBit(uvec4(0xaa771a7e, 0xdcb3e81d, 0x692e392c, 0x24367332), gl_SubgroupInvocationID)) {
                            break;
                        } else {
                            break;
                        }
                    }
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1005c;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    loopIdx0++;
                } while (true);
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1005f;
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
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10065;
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


void main()
{

    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10000;
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
    for (int loopIdx0 = 0;
             loopIdx0 < inputA.a[1];
             loopIdx0++) {
        if (testBit(uvec4(0xaa771a7e, 0xdcb3e81d, 0x692e392c, 0x24367332), gl_SubgroupInvocationID)) {
            continue;
        } else {
            continue;
        }
        if (subgroupElect()) {
            if (subgroupElect()) {
            }
            continue;
        }
    }
    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000e;
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
    if (testBit(uvec4(0x9020d042, 0x8d315ce1, 0xe0d3cfa8, 0xa130abac), gl_SubgroupInvocationID)) {
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10011;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        for (int loopIdx0 = 0;;loopIdx0++,        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true)) {
            if (subgroupElect()) {
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10016;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            if (subgroupElect()) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10019;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                break;
            }
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
        for (int loopIdx0 = 0;
                 loopIdx0 < gl_SubgroupInvocationID + 1;
                 loopIdx0++) {
            if (inputA.a[1] == 1) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10028;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            } else {
            }
            for (int loopIdx1 = 0;
                     loopIdx1 < inputA.a[4];
                     loopIdx1++) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002d;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            }
        }
    } else {
        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
            {
                int loopIdx0 = 0;
                do {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10034;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    if (subgroupElect()) {
                        break;
                    }
                    loopIdx0++;
                } while (true);
            }
        } else {
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1003c;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            } else {
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
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10045;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10048;
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
    switch (gl_SubgroupInvocationID & 3) {
        case 0:
        case 1:
        {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10004;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            if (subgroupElect()) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10007;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                {
                    int loopIdx0 = 0;
                    do {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000a;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        if (subgroupElect()) {
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000d;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                            break;
                        }
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10011;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        loopIdx0++;
                    } while (true);
                }
            }
            break;
        }
        case 2:
        case 3:
        {
            for (int loopIdx0 = 0;
                     loopIdx0 < gl_SubgroupInvocationID + 1;
                     loopIdx0++) {
                continue;
                break;
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001b;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
                if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001f;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                } else {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001f;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10025;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            } else {
                {
                    int loopIdx0 = 0;
                    do {
                        loopIdx0++;
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10029;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    } while (loopIdx0 < inputA.a[1]);
                }
                for (int loopIdx0 = 0;
                         loopIdx0 < inputA.a[4];
                         loopIdx0++) {
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
layout(constant_id = 12) const uint cmpIndex2 = 0u;


void main()
{

    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10000;
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
    if (subgroupElect()) {
        switch (inputA.a[4]) {
            case 5:
            {
                break;
            }
            case 4:
            {
                for (int loopIdx0 = 0;;loopIdx0++,                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true)) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10008;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    if (subgroupElect()) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000b;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        break;
                    }
                }
                break;
            }
            case 6:
            {
                for (int loopIdx0 = 0;
                         loopIdx0 < gl_SubgroupInvocationID + 1;
                         loopIdx0++) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10013;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10016;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                break;
            }
        }
        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
            {
                int loopIdx0 = 0;
                do {
                    if (subgroupElect()) {
                        break;
                    }
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001f;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    loopIdx0++;
                } while (true);
            }
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10023;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            } else {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10023;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            }
        } else {
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex2]) {
            } else {
            }
            if (subgroupElect()) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002e;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10031;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
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


void main()
{

    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10000;
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
    for (int loopIdx0 = 0;
             loopIdx0 < inputA.a[5];
             loopIdx0++) {
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
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10008;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        break;
                    }
                }
                if (inputA.a[0] == 0) {
                }
            } while (loopIdx1 < inputA.a[2]);
        }
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
                if (inputA.a[0] == 12345) {
                    while (true) {
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    }
                }
                if (subgroupElect()) {
                    break;
                }
                {
                    int loopIdx1 = 0;
                    do {
                        loopIdx1++;
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001d;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    } while (loopIdx1 < inputA.a[3]);
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10020;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                switch (gl_SubgroupInvocationID & 3) {
                    case 0:
                    {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10024;
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
                loopIdx0++;
            } while (true);
        }
    } else {
        return;
        for (int loopIdx0 = 0;
                 loopIdx0 < gl_SubgroupInvocationID + 1;
                 loopIdx0++) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10032;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            if (inputA.a[0] == 0) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10035;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            } else {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10035;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1003b;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        }
    }
    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1003f;
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

    switch (gl_SubgroupInvocationID & 3) {
        case 0:
        {
            {
                int loopIdx0 = 0;
                do {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10003;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    if (gl_SubgroupInvocationID == loopIdx0) {
                    }
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10007;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    if (inputA.a[2] == 2) {
                    } else {
                    }
                    if (subgroupElect()) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000d;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        break;
                    }
                    switch (loopIdx0) {
                        case 1: {
                            break;
                        }
                        case 2: {
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10015;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                            break;
                        }
                        default: {
                            break;
                        }
                    }
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001b;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    if (inputA.a[2] == 2) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001e;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    } else {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10021;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    }
                    loopIdx0++;
                } while (true);
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10025;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            break;
        }
        case 1:
        {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10029;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            break;
        }
        case 2:
        {
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
                {
                    int loopIdx0 = 0;
                    do {
                        if (subgroupElect()) {
                            break;
                        }
                        loopIdx0++;
                    } while (true);
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10033;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10036;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            break;
        }
        case 3:
        {
            if (inputA.a[1] == 1) {
                if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1003c;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1003f;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            } else {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10042;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                for (int loopIdx0 = 0;;loopIdx0++,                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true)) {
                    if (subgroupElect()) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10046;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        break;
                    }
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1004a;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1004d;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10050;
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


void main()
{

    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10000;
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
    if (subgroupElect()) {
        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
            for (int loopIdx0 = 0;;loopIdx0++,            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true)) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10005;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                if (subgroupElect()) {
                    break;
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000a;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            }
            {
                int loopIdx0 = 0;
                do {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000e;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    if (subgroupElect()) {
                        break;
                    }
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10013;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    loopIdx0++;
                } while (true);
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10016;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        } else {
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001a;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            } else {
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001e;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex2]) {
            }
        }
        for (int loopIdx0 = 0;
                 loopIdx0 < inputA.a[2];
                 loopIdx0++) {
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
            if (gl_SubgroupInvocationID == loopIdx0) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002f;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            } else {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002f;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10035;
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
        void func0() {
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex3]) {
                if (subgroupElect()) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002f;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10032;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                for (int loopIdx0 = 0;
                         loopIdx0 < inputA.a[4];
                         loopIdx0++) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10035;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
            } else {
                if (gl_LocalInvocationIndex >= inputA.a[cmpIndex4]) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1003a;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
                if (inputA.a[1] == 1) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1003e;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
            }
            if (testBit(uvec4(0xaee27654, 0x51a0fa5f, 0x3f5cfafd, 0xa3b791c0), gl_SubgroupInvocationID)) {
                for (int loopIdx0 = 0;
                         loopIdx0 < inputA.a[5];
                         loopIdx0++) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10044;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
                if (subgroupElect()) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10048;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
            } else {
                {
                    int loopIdx0 = 0;
                    do {
                        if (subgroupElect()) {
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1004e;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                            break;
                        }
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10052;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        loopIdx0++;
                    } while (true);
                }
                if (testBit(uvec4(0xd49506e6, 0x69788d4b, 0x13e034bc, 0xcbb3b425), gl_SubgroupInvocationID)) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10056;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                } else {
                }
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1005b;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        }


void main()
{

    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10002;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        } else {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10005;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            if (inputA.a[1] == 1) {
                for (int loopIdx0 = 0;;loopIdx0++,                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true)) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10009;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    if (subgroupElect()) {
                        break;
                    }
                }
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10010;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            switch (inputA.a[0]) {
                case 1:
                {
                    if (inputA.a[3] == 3) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10015;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    } else {
                    }
                    break;
                }
                case 0:
                {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001b;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    break;
                }
                case 2:
                {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001f;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex2]) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10022;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    }
                    break;
                }
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10027;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002a;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        func0();
    }



}
#version 450 core
#extension GL_KHR_shader_subgroup_ballot : enable
#extension GL_KHR_shader_subgroup_vote : enable
#extension GL_NV_shader_subgroup_partitioned : enable
#extension GL_EXT_subgroup_uniform_control_flow : enable
layout(local_size_x_id = 0, local_size_y_id = 1, local_size_z = 1) in;
layout(set=0, binding=2) coherent buffer OutputC { uint loc[]; } outputC;
layout(set=0, binding=1) coherent buffer OutputB { uvec4 b[]; } outputB;
layout(set=0, binding=0) coherent buffer InputA  { uint  a[]; } inputA;
layout(push_constant) uniform PC {
   // set to the real stride when writing out ballots, or zero when just counting
   int  invocationStride;
   // wildcard fields, for an example the dimensions of rendered area in the case of graphics shaders
   int  width;
   int  height;
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

    if (inputA.a[3] == 3) {
        {
            int loopIdx0 = 0;
            do {
                loopIdx0++;
                if (inputA.a[3] == 3) {
                    if (gl_SubgroupInvocationID == loopIdx0) {
                    } else {
                    }
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10006;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
                continue;
            } while (loopIdx0 < inputA.a[3]);
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000b;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        if (subgroupElect()) {
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
                if (inputA.a[0] == 0) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10010;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
                if (testBit(uvec4(0x9181cd83, 0xdcab9b30, 0x521a842f, 0x1fc09387), gl_SubgroupInvocationID)) {
                } else {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10015;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10018;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            }
        }
    } else {
        if (testBit(uvec4(0xbc435729, 0x515db618, 0xfbddefa, 0xc044afed), gl_SubgroupInvocationID)) {
            {
                int loopIdx0 = 0;
                do {
                    if (subgroupElect()) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10020;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    }
                    for (int loopIdx1 = 0;
                             loopIdx1 < inputA.a[4];
                             loopIdx1++) {
                    }
                    if (subgroupElect()) {
                        break;
                    }
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10028;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    if (inputA.a[1] == 1) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002b;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    } else {
                    }
                    loopIdx0++;
                } while (true);
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10030;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            {
                int loopIdx0 = 0;
                do {
                    loopIdx0++;
                    if (inputA.a[0] == 0) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10034;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    }
                    if (testBit(uvec4(0x4d9ac54c, 0xd2e8e747, 0xd060f6db, 0x56dd3bd3), gl_SubgroupInvocationID)) {
                    } else {
                    }
                } while (loopIdx0 < inputA.a[5]);
            }
        }
        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
            switch (gl_SubgroupInvocationID & 3) {
                case 0:
                {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1003f;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex2]) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10042;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    } else {
                    }
                    break;
                }
                case 1:
                {
                    if (inputA.a[0] == 0) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10049;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    } else {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1004c;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    }
                    break;
                }
                case 2:
                {
                    if (subgroupElect()) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10052;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    }
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10055;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    break;
                }
                case 3:
                {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10059;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    break;
                }
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1005d;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            if (inputA.a[1] == 1) {
                if (testBit(uvec4(0xde0cfc02, 0x4527e14f, 0xb6b1b370, 0x61b047b3), gl_SubgroupInvocationID)) {
                } else {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10062;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10065;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            } else {
                if (testBit(uvec4(0xde0cfc02, 0x4527e14f, 0xb6b1b370, 0x61b047b3), gl_SubgroupInvocationID)) {
                } else {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10062;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10065;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10070;
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
    for (int loopIdx0 = 0;
             loopIdx0 < inputA.a[1];
             loopIdx0++) {
        if (testBit(uvec4(0xaa771a7e, 0xdcb3e81d, 0x692e392c, 0x24367332), gl_SubgroupInvocationID)) {
            continue;
        } else {
            continue;
        }
        if (subgroupElect()) {
            if (subgroupElect()) {
                for (int loopIdx1 = 0;
                         loopIdx1 < inputA.a[1];
                         loopIdx1++) {
                }
                {
                    int loopIdx1 = 0;
                    do {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000d;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        if (subgroupElect()) {
                            break;
                        }
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10012;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        loopIdx1++;
                    } while (true);
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10015;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            }
            if (testBit(uvec4(0xaa771a7e, 0xdcb3e81d, 0x692e392c, 0x24367332), gl_SubgroupInvocationID)) {
                break;
                if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001b;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                } else {
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

    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10000;
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
        for (int loopIdx0 = 0;
                 loopIdx0 < inputA.a[4];
                 loopIdx0++) {
            {
                int loopIdx1 = 0;
                do {
                    if (inputA.a[3] == 3) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10006;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    } else {
                    }
                    if (testBit(uvec4(0xcc6662ac, 0xdcbb39e6, 0xf7e9854, 0x42271730), gl_SubgroupInvocationID)) {
                        break;
                    } else {
                        break;
                    }
                    if (subgroupElect()) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10010;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        break;
                    }
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10014;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    {
                        int loopIdx2 = 0;
                        do {
                            loopIdx2++;
                        } while (loopIdx2 < inputA.a[2]);
                    }
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10018;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    if (inputA.a[0] == 0) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001b;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    } else {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001e;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    }
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10021;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    loopIdx1++;
                } while (true);
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10024;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            break;
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10027;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002a;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        if (testBit(uvec4(0xcc6662ac, 0xdcbb39e6, 0xf7e9854, 0x42271730), gl_SubgroupInvocationID)) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002d;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            {
                int loopIdx0 = 0;
                do {
                    loopIdx0++;
                    {
                        int loopIdx1 = 0;
                        do {
                            loopIdx1++;
                        } while (loopIdx1 < inputA.a[3]);
                    }
                    break;
                } while (loopIdx0 < inputA.a[5]);
            }
            {
                int loopIdx0 = 0;
                do {
                    loopIdx0++;
                    if (subgroupElect()) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10036;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    }
                    if (testBit(uvec4(0xf58394bb, 0xa0fe454, 0x7420162c, 0x8f6783ac), gl_SubgroupInvocationID)) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1003a;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    } else {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1003a;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    }
                } while (loopIdx0 < inputA.a[3]);
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10041;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        } else {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002d;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            {
                int loopIdx0 = 0;
                do {
                    loopIdx0++;
                    {
                        int loopIdx1 = 0;
                        do {
                            loopIdx1++;
                        } while (loopIdx1 < inputA.a[3]);
                    }
                    break;
                } while (loopIdx0 < inputA.a[5]);
            }
            {
                int loopIdx0 = 0;
                do {
                    loopIdx0++;
                    if (subgroupElect()) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10036;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    }
                    if (testBit(uvec4(0xf58394bb, 0xa0fe454, 0x7420162c, 0x8f6783ac), gl_SubgroupInvocationID)) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1003a;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    } else {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1003a;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    }
                } while (loopIdx0 < inputA.a[3]);
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10041;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        }
    } else {
        for (int loopIdx0 = 0;
                 loopIdx0 < inputA.a[4];
                 loopIdx0++) {
            {
                int loopIdx1 = 0;
                do {
                    if (inputA.a[0] == 0) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10006;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    } else {
                    }
                    if (testBit(uvec4(0xcc6662ac, 0xdcbb39e6, 0xf7e9854, 0x42271730), gl_SubgroupInvocationID)) {
                        break;
                    } else {
                        break;
                    }
                    if (subgroupElect()) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10010;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        break;
                    }
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10014;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    {
                        int loopIdx2 = 0;
                        do {
                            loopIdx2++;
                        } while (loopIdx2 < inputA.a[2]);
                    }
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10018;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    if (inputA.a[1] == 1) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001b;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    } else {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001e;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    }
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10021;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    loopIdx1++;
                } while (true);
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10024;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            break;
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10027;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002a;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        if (testBit(uvec4(0xcc6662ac, 0xdcbb39e6, 0xf7e9854, 0x42271730), gl_SubgroupInvocationID)) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002d;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            {
                int loopIdx0 = 0;
                do {
                    loopIdx0++;
                    {
                        int loopIdx1 = 0;
                        do {
                            loopIdx1++;
                        } while (loopIdx1 < inputA.a[3]);
                    }
                    break;
                } while (loopIdx0 < inputA.a[5]);
            }
            {
                int loopIdx0 = 0;
                do {
                    loopIdx0++;
                    if (subgroupElect()) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10036;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    }
                    if (testBit(uvec4(0xf58394bb, 0xa0fe454, 0x7420162c, 0x8f6783ac), gl_SubgroupInvocationID)) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1003a;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    } else {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1003a;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    }
                } while (loopIdx0 < inputA.a[3]);
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10041;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        } else {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002d;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            {
                int loopIdx0 = 0;
                do {
                    loopIdx0++;
                    {
                        int loopIdx1 = 0;
                        do {
                            loopIdx1++;
                        } while (loopIdx1 < inputA.a[3]);
                    }
                    break;
                } while (loopIdx0 < inputA.a[5]);
            }
            {
                int loopIdx0 = 0;
                do {
                    loopIdx0++;
                    if (subgroupElect()) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10036;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    }
                    if (testBit(uvec4(0xf58394bb, 0xa0fe454, 0x7420162c, 0x8f6783ac), gl_SubgroupInvocationID)) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1003a;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    } else {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1003a;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    }
                } while (loopIdx0 < inputA.a[3]);
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10041;
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


void main()
{

    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10000;
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
    if (subgroupElect()) {
        switch (inputA.a[4]) {
            case 5:
            {
                break;
            }
            case 4:
            {
                for (int loopIdx0 = 0;;loopIdx0++,                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true)) {
                    if (subgroupElect()) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10009;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    }
                    if (inputA.a[2] == 2) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000d;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    }
                    if (subgroupElect()) {
                        break;
                    }
                    if (subgroupElect()) {
                    }
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10015;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    if (inputA.a[1] == 1) {
                    } else {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10019;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    }
                }
                break;
            }
            case 6:
            {
                if (subgroupElect()) {
                    {
                        int loopIdx0 = 0;
                        do {
                            if (subgroupElect()) {
                                break;
                            }
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10024;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                            loopIdx0++;
                        } while (true);
                    }
                }
                break;
            }
        }
        if (subgroupElect()) {
            if (subgroupElect()) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002c;
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
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10036;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            }
        }
    }
    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1003b;
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

    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10000;
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
    for (int loopIdx0 = 0;
             loopIdx0 < inputA.a[5];
             loopIdx0++) {
        {
            int loopIdx1 = 0;
            do {
                loopIdx1++;
                switch (gl_SubgroupInvocationID & 3) {
                    case 0:
                    case 1:
                    {
                        continue;
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10007;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
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
                        break;
                    }
                    case 2:
                    case 3:
                    {
                        for (int loopIdx2 = 0;;loopIdx2++,                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true)) {
                            if (subgroupElect()) {
                                outputC.loc[gl_LocalInvocationIndex]++;
                                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10017;
                                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                                break;
                            }
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001b;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        }
                        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001f;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        }
                        break;
                    }
                }
                for (int loopIdx2 = 0;
                         loopIdx2 < gl_SubgroupInvocationID + 1;
                         loopIdx2++) {
                    if (subgroupElect()) {
                    }
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10027;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002a;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            } while (loopIdx1 < inputA.a[2]);
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

    switch (gl_SubgroupInvocationID & 3) {
        case 0:
        {
            {
                int loopIdx0 = 0;
                do {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10003;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    if (gl_SubgroupInvocationID == loopIdx0) {
                        if (subgroupElect()) {
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10007;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        }
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000a;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        {
                            int loopIdx1 = 0;
                            do {
                                loopIdx1++;
                                outputC.loc[gl_LocalInvocationIndex]++;
                                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000d;
                                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                            } while (loopIdx1 < inputA.a[3]);
                        }
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10010;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    }
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10013;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    if (subgroupElect()) {
                        break;
                    }
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10018;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    if (subgroupElect()) {
                        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
                        }
                        if (inputA.a[2] == 2) {
                        }
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001f;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    }
                    {
                        int loopIdx1 = 0;
                        do {
                            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
                            }
                            break;
                            if (subgroupElect()) {
                                break;
                            }
                            if (testBit(uvec4(0x6a16fcd3, 0x9dcb7399, 0x43a406e7, 0x20f1c08), gl_SubgroupInvocationID)) {
                                outputC.loc[gl_LocalInvocationIndex]++;
                                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002a;
                                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                            } else {
                                outputC.loc[gl_LocalInvocationIndex]++;
                                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002a;
                                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                            }
                            switch (inputA.a[4]) {
                                case 5:
                                {
                                    break;
                                }
                                case 4:
                                {
                                    outputC.loc[gl_LocalInvocationIndex]++;
                                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10034;
                                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                                    break;
                                }
                                case 6:
                                {
                                    outputC.loc[gl_LocalInvocationIndex]++;
                                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10038;
                                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                                    break;
                                }
                            }
                            loopIdx1++;
                        } while (true);
                    }
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1003d;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    loopIdx0++;
                } while (true);
            }
            break;
        }
        case 1:
        {
            break;
        }
        case 2:
        {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10044;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            break;
        }
        case 3:
        {
            break;
        }
    }
    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1004a;
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
{

    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10000;
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
    if (subgroupElect()) {
        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
            for (int loopIdx0 = 0;;loopIdx0++,            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true)) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10005;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                if (testBit(uvec4(0x24f2eba6, 0xda5b1bd3, 0x7ef57eb5, 0x5d5c9433), gl_SubgroupInvocationID)) {
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10009;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                break;
                if (subgroupElect()) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000d;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    break;
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10011;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                if (gl_SubgroupInvocationID == loopIdx0) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10014;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                } else {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10017;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001a;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                for (int loopIdx1 = 0;
                         loopIdx1 < inputA.a[4];
                         loopIdx1++) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001d;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10020;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            }
        } else {
            for (int loopIdx0 = 0;;loopIdx0++,            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true)) {
                if (gl_SubgroupInvocationID == loopIdx0) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10026;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                } else {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10029;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
                if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002d;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                } else {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002d;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10033;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                if (subgroupElect()) {
                    break;
                }
                if (gl_SubgroupInvocationID == loopIdx0) {
                } else {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1003a;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
                if (gl_LocalInvocationIndex >= inputA.a[cmpIndex2]) {
                }
            }
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex3]) {
                if (gl_LocalInvocationIndex >= inputA.a[cmpIndex4]) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10042;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                } else {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10042;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10048;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            } else {
                if (gl_LocalInvocationIndex >= inputA.a[cmpIndex5]) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10042;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                } else {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10042;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10048;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10055;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        }
    }
    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10059;
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);



}
