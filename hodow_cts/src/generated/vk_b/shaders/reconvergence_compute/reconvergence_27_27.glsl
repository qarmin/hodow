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

    for (int loopIdx0 = 0;
             loopIdx0 < inputA.a[5];
             loopIdx0++) {
        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        } else {
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        }
        for (int loopIdx1 = 0;;loopIdx1++,        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true)) {
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10008;
            if (subgroupElect()) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000a;
                break;
            }
        }
    }
    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
    }
    switch (inputA.a[4]) {
        case 5:
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
                    break;
                }
                case 2:
                {
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001c;
                    break;
                }
                case 3:
                {
                    break;
                }
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10021;
            break;
        }
        case 4:
        {
            {
                int loopIdx0 = 0;
                do {
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    if (subgroupElect()) {
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        break;
                    }
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002b;
                    loopIdx0++;
                } while (true);
            }
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex2]) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002e;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            } else {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10031;
            }
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            break;
        }
        case 6:
        {
            if (subgroupElect()) {
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
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
layout(constant_id = 12) const uint cmpIndex2 = 0u;


void main()
[[maximally_reconverges]]
{

    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10000;
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
        }
        if (inputA.a[1] == 1) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10006;
        }
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
    } else {
        for (int loopIdx0 = 0;
                 loopIdx0 < gl_SubgroupInvocationID + 1;
                 loopIdx0++) {
        }
    }
    if (inputA.a[2] == 2) {
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000e;
        {
            int loopIdx0 = 0;
            do {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10010;
                if (subgroupElect()) {
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    break;
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10015;
                loopIdx0++;
            } while (true);
        }
        if (subgroupElect()) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10018;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        }
    }
    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001c;
    for (int loopIdx0 = 0;
             loopIdx0 < gl_SubgroupInvocationID + 1;
             loopIdx0++) {
        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex2]) {
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        } else {
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        }
        if (testBit(uvec4(0x747b38eb, 0xdcabe30f, 0xb7e2334f, 0xfa3a7a50), gl_SubgroupInvocationID)) {
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10025;
        }
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10028;
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

    if (testBit(uvec4(0x42dcad6e, 0x9471480d, 0xffa3e60d, 0x1147d7a7), gl_SubgroupInvocationID)) {
        if (subgroupElect()) {
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        }
        for (int loopIdx0 = 0;
                 loopIdx0 < inputA.a[2];
                 loopIdx0++) {
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        }
    } else {
        if (testBit(uvec4(0xadba414a, 0xf7600dc, 0xd534f30e, 0x88c8e8db), gl_SubgroupInvocationID)) {
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        } else {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000b;
        }
        for (int loopIdx0 = 0;
                 loopIdx0 < gl_SubgroupInvocationID + 1;
                 loopIdx0++) {
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        }
    }
    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
        if (inputA.a[2] == 2) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10013;
        } else {
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10016;
        {
            int loopIdx0 = 0;
            do {
                loopIdx0++;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            } while (loopIdx0 < inputA.a[1]);
        }
    } else {
        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        } else {
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        }
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10021;
    }
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10024;



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

    if (testBit(uvec4(0x4f5bedce, 0xff3891ce, 0xfc0c4844, 0x7aa4e5bb), gl_SubgroupInvocationID)) {
        for (int loopIdx0 = 0;
                 loopIdx0 < inputA.a[5];
                 loopIdx0++) {
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        }
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
    }
    if (subgroupElect()) {
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
        {
            int loopIdx0 = 0;
            do {
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                if (subgroupElect()) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10016;
                    break;
                }
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001a;
                loopIdx0++;
            } while (true);
        }
    }
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001e;



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
            {
                int loopIdx1 = 0;
                do {
                    loopIdx1++;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                } while (loopIdx1 < inputA.a[2]);
            }
            if (subgroupElect()) {
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                break;
            }
            switch (inputA.a[1]) {
                case 2:
                {
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
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
                    break;
                }
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10013;
            if (testBit(uvec4(0x93a1d546, 0xe07426cb, 0x81c84aa9, 0xaf993f6f), gl_SubgroupInvocationID)) {
            } else {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10016;
            }
            loopIdx0++;
        } while (true);
    }
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001a;
    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001c;
        if (testBit(uvec4(0xb58593c9, 0x46be088b, 0x1ca665ca, 0xc0d80224), gl_SubgroupInvocationID)) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001e;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        } else {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001e;
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
layout(constant_id = 12) const uint cmpIndex2 = 0u;


void main()
[[maximally_reconverges]]
{

    if (testBit(uvec4(0xb2fa1b23, 0xd67920f6, 0xe677f900, 0x50f0c25a), gl_SubgroupInvocationID)) {
        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        } else {
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
    }
    {
        int loopIdx0 = 0;
        do {
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            } else {
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10017;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex2]) {
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            } else {
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            }
            if (subgroupElect()) {
                break;
            }
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            if (gl_SubgroupInvocationID == loopIdx0) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10023;
            } else {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10025;
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
layout(constant_id = 11) const uint cmpIndex1 = 0u;
layout(constant_id = 12) const uint cmpIndex2 = 0u;
layout(constant_id = 13) const uint cmpIndex3 = 0u;


void main()
[[maximally_reconverges]]
{

    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
    }
    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10002;
    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
        if (inputA.a[2] == 2) {
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        } else {
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        }
    }
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000b;
    if (testBit(uvec4(0x24209002, 0xa32c6f41, 0xbdeb4150, 0xeb453b5d), gl_SubgroupInvocationID)) {
        for (int loopIdx0 = 0;
                 loopIdx0 < inputA.a[1];
                 loopIdx0++) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000e;
        }
        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex2]) {
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10012;
    }
    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex3]) {
        switch (gl_SubgroupInvocationID & 3) {
            case 0:
            {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10017;
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
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001f;
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


void main()
[[maximally_reconverges]]
{

    if (inputA.a[3] == 3) {
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10003;
        } else {
        }
    } else {
        {
            int loopIdx0 = 0;
            do {
                if (subgroupElect()) {
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    break;
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000c;
                loopIdx0++;
            } while (true);
        }
        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
        }
    }
    switch (inputA.a[4]) {
        case 5:
        {
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            break;
        }
        case 4:
        {
            if (inputA.a[0] == 0) {
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10019;
            for (int loopIdx0 = 0;
                     loopIdx0 < gl_SubgroupInvocationID + 1;
                     loopIdx0++) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001b;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            }
            break;
        }
        case 6:
        {
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

    for (int loopIdx0 = 0;
             loopIdx0 < inputA.a[5];
             loopIdx0++) {
        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
            if (testBit(uvec4(0xf0153983, 0x5659d60c, 0x9176f58, 0xc4561528), gl_SubgroupInvocationID)) {
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            }
            if (inputA.a[0] == 0) {
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            } else {
            }
        }
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        continue;
    }
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
    for (int loopIdx0 = 0;;loopIdx0++,    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true)) {
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        switch (loopIdx0) {
            case 1: {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10012;
                if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                } else {
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                break;
            }
            case 2: {
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                break;
            }
            default: {
                for (int loopIdx1 = 0;
                         loopIdx1 < gl_SubgroupInvocationID + 1;
                         loopIdx1++) {
                }
                break;
            }
        }
        if (subgroupElect()) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10023;
            break;
        }
        if (gl_SubgroupInvocationID == loopIdx0) {
            if (inputA.a[1] == 1) {
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            } else {
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            }
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            break;
        }
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        for (int loopIdx1 = 0;
                 loopIdx1 < inputA.a[4];
                 loopIdx1++) {
            continue;
            for (int loopIdx2 = 0;
                     loopIdx2 < gl_SubgroupInvocationID + 1;
                     loopIdx2++) {
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
layout(constant_id = 10) const uint cmpIndex0 = 0u;
layout(constant_id = 11) const uint cmpIndex1 = 0u;
layout(constant_id = 12) const uint cmpIndex2 = 0u;
layout(constant_id = 13) const uint cmpIndex3 = 0u;
layout(constant_id = 14) const uint cmpIndex4 = 0u;
layout(constant_id = 15) const uint cmpIndex5 = 0u;


void main()
[[maximally_reconverges]]
{

    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10000;
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex2]) {
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            } else {
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10009;
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex3]) {
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            } else {
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            }
        }
        switch (inputA.a[3]) {
            case 4:
            {
                break;
            }
            case 3:
            {
                if (gl_LocalInvocationIndex >= inputA.a[cmpIndex4]) {
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                } else {
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                if (gl_LocalInvocationIndex >= inputA.a[cmpIndex5]) {
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
                break;
            }
            case 5:
            {
                if (testBit(uvec4(0x747b38eb, 0xdcabe30f, 0xb7e2334f, 0xfa3a7a50), gl_SubgroupInvocationID)) {
                }
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
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
layout(constant_id = 10) const uint cmpIndex0 = 0u;
layout(constant_id = 11) const uint cmpIndex1 = 0u;
layout(constant_id = 12) const uint cmpIndex2 = 0u;


void main()
[[maximally_reconverges]]
{

    if (testBit(uvec4(0x42dcad6e, 0x9471480d, 0xffa3e60d, 0x1147d7a7), gl_SubgroupInvocationID)) {
        if (subgroupElect()) {
            if (subgroupElect()) {
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10004;
        }
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
            if (testBit(uvec4(0xadba414a, 0xf7600dc, 0xd534f30e, 0x88c8e8db), gl_SubgroupInvocationID)) {
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            } else {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000b;
            }
            for (int loopIdx0 = 0;
                     loopIdx0 < gl_SubgroupInvocationID + 1;
                     loopIdx0++) {
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            }
        }
    }
    switch (gl_SubgroupInvocationID & 3) {
        case 0:
        {
            if (inputA.a[1] == 1) {
                if (subgroupElect()) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10016;
                }
                for (int loopIdx0 = 0;
                         loopIdx0 < inputA.a[1];
                         loopIdx0++) {
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
            }
            break;
        }
        case 1:
        {
            {
                int loopIdx0 = 0;
                do {
                    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    } else {
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    }
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10024;
                    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex2]) {
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    } else {
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    }
                    if (subgroupElect()) {
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        if (testBit(uvec4(0x12588461, 0xdcb33016, 0xd107e1bb, 0x9c19fa28), gl_SubgroupInvocationID)) {
                            break;
                        } else {
                            break;
                        }
                    }
                    for (int loopIdx1 = 0;
                             loopIdx1 < gl_SubgroupInvocationID + 1;
                             loopIdx1++) {
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    }
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10035;
                    loopIdx0++;
                } while (true);
            }
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

    if (testBit(uvec4(0x4f5bedce, 0xff3891ce, 0xfc0c4844, 0x7aa4e5bb), gl_SubgroupInvocationID)) {
        for (int loopIdx0 = 0;
                 loopIdx0 < inputA.a[5];
                 loopIdx0++) {
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            }
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        }
        if (testBit(uvec4(0x5724b049, 0xc78100ea, 0x94202959, 0xaf00e2b), gl_SubgroupInvocationID)) {
            if (testBit(uvec4(0x29bdb8bb, 0x5b69ed67, 0x3649f53f, 0xa3b66af1), gl_SubgroupInvocationID)) {
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            }
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000c;
            if (inputA.a[3] == 3) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000e;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            } else {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000e;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10014;
        }
    } else {
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10018;
        {
            int loopIdx0 = 0;
            do {
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                if (inputA.a[1] == 1) {
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001f;
                for (int loopIdx1 = 0;
                         loopIdx1 < inputA.a[5];
                         loopIdx1++) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10021;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
                if (subgroupElect()) {
                    break;
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
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                loopIdx0++;
            } while (true);
        }
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        if (subgroupElect()) {
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1003a;
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
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    break;
                }
            }
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10045;
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
    void func0() {
        if (testBit(uvec4(0x42962bce, 0xdc83561c, 0x804b9d28, 0xccd73ff2), gl_SubgroupInvocationID)) {
            switch (gl_SubgroupInvocationID & 3) {
                case 0:
                {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10018;
                    break;
                }
                case 1:
                {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001b;
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
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10023;
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10025;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            }
        } else {
            switch (gl_SubgroupInvocationID & 3) {
                case 0:
                {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10018;
                    break;
                }
                case 1:
                {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001b;
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
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10023;
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex2]) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10025;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            }
        }
        if (testBit(uvec4(0xb58593c9, 0x46be088b, 0x1ca665ca, 0xc0d80224), gl_SubgroupInvocationID)) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1003d;
            switch (gl_SubgroupInvocationID & 3) {
                case 0:
                {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10040;
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
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10046;
                    break;
                }
                case 3:
                {
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    break;
                }
            }
            for (int loopIdx0 = 0;
                     loopIdx0 < inputA.a[1];
                     loopIdx0++) {
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            }
        } else {
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex3]) {
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            } else {
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            }
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        }
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
    }


void main()
[[maximally_reconverges]]
{

    {
        int loopIdx0 = 0;
        do {
            {
                int loopIdx1 = 0;
                do {
                    loopIdx1++;
                    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    } else {
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    }
                } while (loopIdx1 < inputA.a[2]);
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10008;
            if (subgroupElect()) {
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                if (testBit(uvec4(0x42962bce, 0xdc83561c, 0x804b9d28, 0xccd73ff2), gl_SubgroupInvocationID)) {
                    break;
                } else {
                    break;
                }
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10011;
            loopIdx0++;
        } while (true);
    }
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
    func0();



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

    if (testBit(uvec4(0xb2fa1b23, 0xd67920f6, 0xe677f900, 0x50f0c25a), gl_SubgroupInvocationID)) {
        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            }
        } else {
            for (int loopIdx0 = 0;
                     loopIdx0 < inputA.a[1];
                     loopIdx0++) {
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            }
        }
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
    }
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
    if (subgroupElect()) {
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
    }
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
    if (testBit(uvec4(0x7f5707d0, 0x5d879aae, 0x14a07613, 0x2cdb4025), gl_SubgroupInvocationID)) {
        switch (inputA.a[1]) {
            case 2:
            {
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
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10021;
                break;
            }
            case 1:
            {
                for (int loopIdx0 = 0;;loopIdx0++,                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true)) {
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10026;
                    if (subgroupElect()) {
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        break;
                    }
                }
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
                        break;
                    }
                    case 3:
                    {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10036;
                        break;
                    }
                }
                break;
            }
            case 3:
            {
                {
                    int loopIdx0 = 0;
                    do {
                        loopIdx0++;
                    } while (loopIdx0 < inputA.a[3]);
                }
                break;
            }
        }
        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex2]) {
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
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        } else {
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex3]) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1004e;
            }
        }
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
layout(constant_id = 10) const uint cmpIndex0 = 0u;
layout(constant_id = 11) const uint cmpIndex1 = 0u;
layout(constant_id = 12) const uint cmpIndex2 = 0u;
layout(constant_id = 13) const uint cmpIndex3 = 0u;


void main()
[[maximally_reconverges]]
{

    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
    }
    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10002;
    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
        if (inputA.a[1] == 1) {
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            switch (gl_SubgroupInvocationID & 3) {
                case 0:
                {
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    break;
                }
                case 1:
                {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000b;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    break;
                }
                case 2:
                {
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10010;
                    break;
                }
                case 3:
                {
                    break;
                }
            }
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex2]) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10017;
            }
        }
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
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            {
                int loopIdx0 = 0;
                do {
                    switch (gl_SubgroupInvocationID & 3) {
                        case 0:
                        {
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10025;
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
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002d;
                            break;
                        }
                    }
                    if (subgroupElect()) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10031;
                        break;
                    }
                    {
                        int loopIdx1 = 0;
                        do {
                            if (subgroupElect()) {
                                break;
                            }
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                            loopIdx1++;
                        } while (true);
                    }
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1003a;
                    break;
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1003c;
                    loopIdx0++;
                } while (true);
            }
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            break;
        }
        case 2:
        {
            if (testBit(uvec4(0xdad44150, 0xcc9c23ad, 0x98038084, 0x4acdfcad), gl_SubgroupInvocationID)) {
                if (inputA.a[2] == 2) {
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10044;
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10046;
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
            break;
        }
        case 3:
        {
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            for (int loopIdx0 = 0;;loopIdx0++,            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true)) {
                if (gl_LocalInvocationIndex >= inputA.a[cmpIndex3]) {
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                } else {
                }
                break;
                if (subgroupElect()) {
                    break;
                }
                if (gl_SubgroupInvocationID == loopIdx0) {
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                } else {
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10064;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                switch (gl_SubgroupInvocationID & 3) {
                    case 0:
                    {
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        break;
                    }
                    case 1:
                    {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1006b;
                        break;
                    }
                    case 2:
                    {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1006e;
                        break;
                    }
                    case 3:
                    {
                        break;
                    }
                }
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10074;
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


void main()
[[maximally_reconverges]]
{

    if (inputA.a[1] == 1) {
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        } else {
            switch (inputA.a[4]) {
                case 5:
                {
                    break;
                }
                case 4:
                {
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000a;
                    break;
                }
                case 6:
                {
                    break;
                }
            }
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            }
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10013;
        for (int loopIdx0 = 0;
                 loopIdx0 < gl_SubgroupInvocationID + 1;
                 loopIdx0++) {
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex2]) {
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            }
        }
    } else {
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        if (inputA.a[1] == 1) {
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


void main()
[[maximally_reconverges]]
{

    for (int loopIdx0 = 0;
             loopIdx0 < inputA.a[5];
             loopIdx0++) {
        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
            if (testBit(uvec4(0xf0153983, 0x5659d60c, 0x9176f58, 0xc4561528), gl_SubgroupInvocationID)) {
                break;
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10004;
                if (gl_SubgroupInvocationID == loopIdx0) {
                }
            }
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            if (inputA.a[0] == 0) {
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
                        break;
                    }
                }
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                for (int loopIdx1 = 0;;loopIdx1++,                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true)) {
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    if (subgroupElect()) {
                        break;
                    }
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001d;
                }
            } else {
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                if (gl_SubgroupInvocationID == loopIdx0) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10022;
                }
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                {
                    int loopIdx1 = 0;
                    do {
                        loopIdx1++;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    } while (loopIdx1 < inputA.a[5]);
                }
            }
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002a;
        break;
    }
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002e;



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

    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10000;
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex2]) {
                for (int loopIdx0 = 0;;loopIdx0++,                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true)) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10006;
                    if (subgroupElect()) {
                        break;
                    }
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000a;
                }
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                {
                    int loopIdx0 = 0;
                    do {
                        loopIdx0++;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    } while (loopIdx0 < inputA.a[2]);
                }
            }
            if (inputA.a[0] == 0) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10012;
                {
                    int loopIdx0 = 0;
                    do {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10014;
                        if (subgroupElect()) {
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                            break;
                        }
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10019;
                        loopIdx0++;
                    } while (true);
                }
                if (subgroupElect()) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001c;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10020;
        } else {
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            for (int loopIdx0 = 0;
                     loopIdx0 < inputA.a[3];
                     loopIdx0++) {
                if (testBit(uvec4(0x99c3d736, 0x34d20d27, 0x16dcf3a0, 0xb002d6a4), gl_SubgroupInvocationID)) {
                }
                if (testBit(uvec4(0x99c3d736, 0x34d20d27, 0x16dcf3a0, 0xb002d6a4), gl_SubgroupInvocationID)) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10027;
                }
            }
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002b;
            for (int loopIdx0 = 0;
                     loopIdx0 < inputA.a[2];
                     loopIdx0++) {
                if (gl_SubgroupInvocationID == loopIdx0) {
                }
                if (gl_SubgroupInvocationID == loopIdx0) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10030;
                }
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            }
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10035;
    } else {
        if (inputA.a[0] == 0) {
            switch (inputA.a[1]) {
                case 2:
                {
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
                    break;
                }
                case 1:
                {
                    {
                        int loopIdx0 = 0;
                        do {
                            loopIdx0++;
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10045;
                        } while (loopIdx0 < inputA.a[1]);
                    }
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10047;
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

    if (testBit(uvec4(0x42dcad6e, 0x9471480d, 0xffa3e60d, 0x1147d7a7), gl_SubgroupInvocationID)) {
        if (subgroupElect()) {
            if (subgroupElect()) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10003;
                for (int loopIdx0 = 0;
                         loopIdx0 < inputA.a[2];
                         loopIdx0++) {
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10007;
            }
            {
                int loopIdx0 = 0;
                do {
                    loopIdx0++;
                    for (int loopIdx1 = 0;;loopIdx1++,                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true)) {
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        if (subgroupElect()) {
                            break;
                        }
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    }
                    break;
                } while (loopIdx0 < inputA.a[1]);
            }
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10014;
        if (subgroupElect()) {
            for (int loopIdx0 = 0;
                     loopIdx0 < gl_SubgroupInvocationID + 1;
                     loopIdx0++) {
                if (subgroupElect()) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10018;
                }
                for (int loopIdx1 = 0;
                         loopIdx1 < inputA.a[1];
                         loopIdx1++) {
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
            }
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
                if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                } else {
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10024;
                if (gl_LocalInvocationIndex >= inputA.a[cmpIndex2]) {
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                } else {
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
            }
        }
    } else {
        if (subgroupElect()) {
            if (subgroupElect()) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10003;
                for (int loopIdx0 = 0;
                         loopIdx0 < inputA.a[2];
                         loopIdx0++) {
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10007;
            }
            {
                int loopIdx0 = 0;
                do {
                    loopIdx0++;
                    for (int loopIdx1 = 0;;loopIdx1++,                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true)) {
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        if (subgroupElect()) {
                            break;
                        }
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    }
                    break;
                } while (loopIdx0 < inputA.a[1]);
            }
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10014;
        if (subgroupElect()) {
            for (int loopIdx0 = 0;
                     loopIdx0 < gl_SubgroupInvocationID + 1;
                     loopIdx0++) {
                if (subgroupElect()) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10018;
                }
                for (int loopIdx1 = 0;
                         loopIdx1 < inputA.a[1];
                         loopIdx1++) {
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
            }
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex3]) {
                if (gl_LocalInvocationIndex >= inputA.a[cmpIndex4]) {
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                } else {
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10024;
                if (gl_LocalInvocationIndex >= inputA.a[cmpIndex5]) {
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
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
layout(constant_id = 14) const uint cmpIndex4 = 0u;


void main()
[[maximally_reconverges]]
{

    if (testBit(uvec4(0x4f5bedce, 0xff3891ce, 0xfc0c4844, 0x7aa4e5bb), gl_SubgroupInvocationID)) {
        for (int loopIdx0 = 0;
                 loopIdx0 < inputA.a[5];
                 loopIdx0++) {
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                continue;
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10005;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            } else {
                if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                for (int loopIdx1 = 0;
                         loopIdx1 < gl_SubgroupInvocationID + 1;
                         loopIdx1++) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000d;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            }
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex2]) {
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                {
                    int loopIdx1 = 0;
                    do {
                        loopIdx1++;
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10015;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    } while (loopIdx1 < inputA.a[1]);
                }
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                {
                    int loopIdx1 = 0;
                    do {
                        loopIdx1++;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001b;
                    } while (loopIdx1 < inputA.a[5]);
                }
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            } else {
                {
                    int loopIdx1 = 0;
                    do {
                        loopIdx1++;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    } while (loopIdx1 < inputA.a[2]);
                }
                break;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10024;
            }
        }
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        for (int loopIdx0 = 0;
                 loopIdx0 < inputA.a[5];
                 loopIdx0++) {
            {
                int loopIdx1 = 0;
                do {
                    loopIdx1++;
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002a;
                    continue;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex3]) {
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    } else {
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10031;
                    }
                } while (loopIdx1 < inputA.a[3]);
            }
            {
                int loopIdx1 = 0;
                do {
                    if (testBit(uvec4(0x29bdb8bb, 0x5b69ed67, 0x3649f53f, 0xa3b66af1), gl_SubgroupInvocationID)) {
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    }
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10038;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    switch (loopIdx0) {
                        case 1: {
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1003c;
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
                        break;
                    }
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    if (subgroupElect()) {
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10049;
                    }
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex4]) {
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
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
layout(constant_id = 12) const uint cmpIndex2 = 0u;
layout(constant_id = 13) const uint cmpIndex3 = 0u;
layout(constant_id = 14) const uint cmpIndex4 = 0u;


void main()
[[maximally_reconverges]]
{

    {
        int loopIdx0 = 0;
        do {
            {
                int loopIdx1 = 0;
                do {
                    loopIdx1++;
                    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        if (testBit(uvec4(0x336819ca, 0xaaeacc85, 0x1c064f2a, 0x33a1f4a1), gl_SubgroupInvocationID)) {
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        }
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        {
                            int loopIdx2 = 0;
                            do {
                                loopIdx2++;
                                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                                outputC.loc[gl_LocalInvocationIndex]++;
                                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000a;
                            } while (loopIdx2 < inputA.a[2]);
                        }
                    }
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000e;
                    switch (gl_SubgroupInvocationID & 3) {
                        case 0:
                        {
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10011;
                            if (inputA.a[1] == 1) {
                            } else {
                            }
                            break;
                        }
                        case 1:
                        {
                            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
                            } else {
                                outputC.loc[gl_LocalInvocationIndex]++;
                                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10019;
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
                            {
                                int loopIdx2 = 0;
                                do {
                                    loopIdx2++;
                                    outputC.loc[gl_LocalInvocationIndex]++;
                                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10022;
                                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                                } while (loopIdx2 < inputA.a[5]);
                            }
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                            break;
                        }
                    }
                } while (loopIdx1 < inputA.a[2]);
            }
            if (subgroupElect()) {
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                break;
            }
            {
                int loopIdx1 = 0;
                do {
                    loopIdx1++;
                    switch (loopIdx1) {
                        case 1: {
                            if (gl_SubgroupInvocationID == loopIdx1) {
                                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                            } else {
                                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                            }
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10036;
                            break;
                        }
                        case 2: {
                            if (gl_SubgroupInvocationID == loopIdx1) {
                                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                                outputC.loc[gl_LocalInvocationIndex]++;
                                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1003b;
                            }
                            break;
                        }
                        default: {
                            for (int loopIdx2 = 0;
                                     loopIdx2 < gl_SubgroupInvocationID + 1;
                                     loopIdx2++) {
                                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                            }
                            break;
                        }
                    }
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    if (inputA.a[3] == 3) {
                        if (gl_SubgroupInvocationID == loopIdx1) {
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10047;
                        } else {
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10049;
                        }
                        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex2]) {
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1004d;
                        } else {
                        }
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    } else {
                        if (testBit(uvec4(0x42962bce, 0xdc83561c, 0x804b9d28, 0xccd73ff2), gl_SubgroupInvocationID)) {
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10053;
                        }
                        for (int loopIdx2 = 0;
                                 loopIdx2 < inputA.a[1];
                                 loopIdx2++) {
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        }
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10059;
                    }
                    while (!subgroupElect()) {}
                } while (loopIdx1 < inputA.a[2]);
            }
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            if (gl_SubgroupInvocationID == loopIdx0) {
                switch (inputA.a[0]) {
                    case 1:
                    {
                        for (int loopIdx1 = 0;
                                 loopIdx1 < inputA.a[5];
                                 loopIdx1++) {
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        }
                        break;
                    }
                    case 0:
                    {
                        if (inputA.a[3] == 3) {
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10067;
                        }
                        break;
                        break;
                    }
                    case 2:
                    {
                        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex3]) {
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1006e;
                        }
                        break;
                    }
                }
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                if (testBit(uvec4(0x5d5d909f, 0xc0cb6625, 0xf80726dc, 0x3b59be1c), gl_SubgroupInvocationID)) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10074;
                    if (testBit(uvec4(0x42962bce, 0xdc83561c, 0x804b9d28, 0xccd73ff2), gl_SubgroupInvocationID)) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10076;
                    }
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10078;
                } else {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10074;
                    if (testBit(uvec4(0x42962bce, 0xdc83561c, 0x804b9d28, 0xccd73ff2), gl_SubgroupInvocationID)) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10076;
                    }
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10078;
                }
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            } else {
                switch (loopIdx0) {
                    case 1: {
                        {
                            int loopIdx1 = 0;
                            do {
                                loopIdx1++;
                                outputC.loc[gl_LocalInvocationIndex]++;
                                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10085;
                            } while (loopIdx1 < inputA.a[4]);
                        }
                        break;
                    }
                    case 2: {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10089;
                        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex4]) {
                        } else {
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1008c;
                        }
                        break;
                    }
                    default: {
                        if (inputA.a[3] == 3) {
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10091;
                        }
                        break;
                    }
                }
                {
                    int loopIdx1 = 0;
                    do {
                        loopIdx1++;
                        if (inputA.a[2] == 2) {
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10097;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        } else {
                        }
                        for (int loopIdx2 = 0;
                                 loopIdx2 < inputA.a[5];
                                 loopIdx2++) {
                        }
                    } while (loopIdx1 < inputA.a[3]);
                }
            }
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
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


void main()
[[maximally_reconverges]]
{

    if (testBit(uvec4(0xb2fa1b23, 0xd67920f6, 0xe677f900, 0x50f0c25a), gl_SubgroupInvocationID)) {
        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
                if (subgroupElect()) {
                }
                {
                    int loopIdx0 = 0;
                    do {
                        if (subgroupElect()) {
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                            break;
                        }
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        loopIdx0++;
                    } while (true);
                }
            } else {
                if (subgroupElect()) {
                }
                {
                    int loopIdx0 = 0;
                    do {
                        if (subgroupElect()) {
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                            break;
                        }
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        loopIdx0++;
                    } while (true);
                }
            }
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        } else {
            if (inputA.a[0] == 0) {
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                if (inputA.a[0] == 0) {
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
            } else {
                if (inputA.a[2] == 2) {
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                } else {
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
                for (int loopIdx0 = 0;
                         loopIdx0 < inputA.a[3];
                         loopIdx0++) {
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10028;
            }
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002b;
        }
        for (int loopIdx0 = 0;
                 loopIdx0 < inputA.a[1];
                 loopIdx0++) {
            switch (gl_SubgroupInvocationID & 3) {
                case 0:
                {
                    if (testBit(uvec4(0xedd126dc, 0xdc84a6e2, 0x2f332044, 0x63902f01), gl_SubgroupInvocationID)) {
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10032;
                    }
                    break;
                }
                case 1:
                {
                    for (int loopIdx1 = 0;
                             loopIdx1 < gl_SubgroupInvocationID + 1;
                             loopIdx1++) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10037;
                    }
                    break;
                }
                case 2:
                {
                    if (subgroupElect()) {
                    }
                    break;
                }
                case 3:
                {
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    switch (gl_SubgroupInvocationID & 3) {
                        case 0:
                        {
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10042;
                            break;
                        }
                        case 1:
                        {
                            break;
                        }
                        case 2:
                        {
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10047;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
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
    }
    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10002;
    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
        if (inputA.a[0] == 0) {
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            switch (gl_SubgroupInvocationID & 3) {
                case 0:
                {
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex2]) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000a;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    } else {
                    }
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000e;
                    break;
                }
                case 1:
                {
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    break;
                }
                case 2:
                {
                    for (int loopIdx0 = 0;;loopIdx0++,                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true)) {
                        if (subgroupElect()) {
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10016;
                            break;
                        }
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    }
                    break;
                }
                case 3:
                {
                    if (inputA.a[0] == 0) {
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001f;
                    }
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10021;
                    break;
                }
            }
        }
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
    } else {
        if (inputA.a[3] == 3) {
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            switch (gl_SubgroupInvocationID & 3) {
                case 0:
                {
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex3]) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000a;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    } else {
                    }
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000e;
                    break;
                }
                case 1:
                {
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    break;
                }
                case 2:
                {
                    for (int loopIdx0 = 0;;loopIdx0++,                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true)) {
                        if (subgroupElect()) {
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10016;
                            break;
                        }
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    }
                    break;
                }
                case 3:
                {
                    if (inputA.a[2] == 2) {
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001f;
                    }
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10021;
                    break;
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

    if (inputA.a[0] == 0) {
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        } else {
            switch (inputA.a[4]) {
                case 5:
                {
                    if (subgroupElect()) {
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    }
                    break;
                }
                case 4:
                {
                    break;
                }
                case 6:
                {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000e;
                    if (inputA.a[2] == 2) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10010;
                    } else {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10012;
                    }
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    break;
                }
            }
            switch (inputA.a[0]) {
                case 1:
                {
                    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    }
                    break;
                }
                case 0:
                {
                    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex2]) {
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    }
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10021;
                    {
                        int loopIdx0 = 0;
                        do {
                            loopIdx0++;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        } while (loopIdx0 < inputA.a[4]);
                    }
                    break;
                }
                case 2:
                {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10027;
                    break;
                }
            }
        }
    } else {
        switch (gl_SubgroupInvocationID & 3) {
            case 0:
            {
                break;
            }
            case 1:
            {
                {
                    int loopIdx0 = 0;
                    do {
                        loopIdx0++;
                        for (int loopIdx1 = 0;
                                 loopIdx1 < inputA.a[1];
                                 loopIdx1++) {
                        }
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10033;
                    } while (loopIdx0 < inputA.a[2]);
                }
                break;
            }
            case 2:
            {
                for (int loopIdx0 = 0;;loopIdx0++,                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true)) {
                    if (testBit(uvec4(0x598bd779, 0xdc94c4ec, 0x9bea62b5, 0xd7cae80b), gl_SubgroupInvocationID)) {
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    }
                    if (subgroupElect()) {
                    }
                    if (subgroupElect()) {
                        break;
                    }
                    break;
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10042;
                break;
            }
            case 3:
            {
                break;
            }
        }
    }
    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10048;



}
#version 450 core
#extension GL_KHR_shader_subgroup_ballot : enable
#extension GL_KHR_shader_subgroup_vote : enable
#extension GL_NV_shader_subgroup_partitioned : enable
#extension GL_EXT_subgroup_uniform_control_flow : enable
layout(local_size_x_id = 0, local_size_y_id = 1, local_size_z = 1) in;
layout(set=0, binding=2) coherent buffer OutputC { uint loc[]; } outputC;
layout(set=0, binding=1) coherent buffer OutputB { uvec4 b[]; } outputB;
layout(set=0, binding=0) coherent buffer InputA  { uint  a[]; } inputA;
layout(push_constant) uniform PC {
   // set to the real stride when writing out ballots, or zero when just counting
   int  invocationStride;
   // wildcard fields, for an example the dimensions of rendered area in the case of graphics shaders
   int  width;
   int  height;
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

    for (int loopIdx0 = 0;
             loopIdx0 < inputA.a[5];
             loopIdx0++) {
        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10002;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        } else {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10002;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        }
        for (int loopIdx1 = 0;;loopIdx1++,        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect()) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10009;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            if (subgroupElect()) {
                break;
            }
        }
    }
    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
    }
    switch (inputA.a[4]) {
        case 5:
        {
            switch (gl_SubgroupInvocationID & 3) {
                case 0:
                case 1:
                {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10016;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
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
            break;
        }
        case 4:
        {
            {
                int loopIdx0 = 0;
                do {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10021;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    if (subgroupElect()) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10024;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                        break;
                    }
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10028;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    loopIdx0++;
                } while (true);
            }
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex2]) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002c;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            } else {
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10030;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            break;
        }
        case 6:
        {
            if (subgroupElect()) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10035;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            }
            break;
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


void main()
[[subgroup_uniform_control_flow]]
{

    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
        if (subgroupElect()) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10002;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        }
        for (int loopIdx0 = 0;
                 loopIdx0 < inputA.a[3];
                 loopIdx0++) {
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10007;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
    } else {
        if (subgroupElect()) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10002;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        }
        for (int loopIdx0 = 0;
                 loopIdx0 < inputA.a[3];
                 loopIdx0++) {
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10007;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
    }
    {
        int loopIdx0 = 0;
        do {
            if (inputA.a[1] == 1) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10015;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            } else {
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
            for (int loopIdx1 = 0;
                     loopIdx1 < gl_SubgroupInvocationID + 1;
                     loopIdx1++) {
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10022;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            if (subgroupElect()) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10025;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            }
            loopIdx0++;
        } while (true);
    }
    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10029;
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
        }
        if (inputA.a[1] == 1) {
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10007;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
    } else {
        for (int loopIdx0 = 0;
                 loopIdx0 < gl_SubgroupInvocationID + 1;
                 loopIdx0++) {
        }
    }
    if (inputA.a[2] == 2) {
        {
            int loopIdx0 = 0;
            do {
                if (subgroupElect()) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10010;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    break;
                }
                loopIdx0++;
            } while (true);
        }
        if (subgroupElect()) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10016;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        }
    }
    for (int loopIdx0 = 0;
             loopIdx0 < gl_SubgroupInvocationID + 1;
             loopIdx0++) {
        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex2]) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001c;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        } else {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001f;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        }
        if (testBit(uvec4(0x747b38eb, 0xdcabe30f, 0xb7e2334f, 0xfa3a7a50), gl_SubgroupInvocationID)) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10023;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10026;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
    }
    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10029;
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

    if (testBit(uvec4(0x42dcad6e, 0x9471480d, 0xffa3e60d, 0x1147d7a7), gl_SubgroupInvocationID)) {
        if (subgroupElect()) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10002;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        }
        for (int loopIdx0 = 0;
                 loopIdx0 < inputA.a[2];
                 loopIdx0++) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10006;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        }
    } else {
        if (testBit(uvec4(0xadba414a, 0xf7600dc, 0xd534f30e, 0x88c8e8db), gl_SubgroupInvocationID)) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000b;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        } else {
        }
        for (int loopIdx0 = 0;
                 loopIdx0 < gl_SubgroupInvocationID + 1;
                 loopIdx0++) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10010;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        }
    }
    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
        if (inputA.a[2] == 2) {
        } else {
        }
        {
            int loopIdx0 = 0;
            do {
                loopIdx0++;
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10019;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            } while (loopIdx0 < inputA.a[1]);
        }
    } else {
        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001e;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        } else {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10021;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
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
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
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
            break;
        }
        case 2:
        case 3:
        {
            switch (gl_SubgroupInvocationID & 3) {
                case 0:
                case 1:
                {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10011;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    break;
                }
                case 2:
                case 3:
                {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10015;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    break;
                }
            }
            for (int loopIdx0 = 0;;loopIdx0++,            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect()) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001a;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                if (subgroupElect()) {
                    break;
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001f;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10022;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            break;
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


void main()
[[subgroup_uniform_control_flow]]
{

    if (testBit(uvec4(0x4f5bedce, 0xff3891ce, 0xfc0c4844, 0x7aa4e5bb), gl_SubgroupInvocationID)) {
        for (int loopIdx0 = 0;
                 loopIdx0 < inputA.a[5];
                 loopIdx0++) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10002;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10005;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
    }
    if (subgroupElect()) {
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
        {
            int loopIdx0 = 0;
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
                loopIdx0++;
            } while (true);
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


void main()
[[subgroup_uniform_control_flow]]
{

    {
        int loopIdx0 = 0;
        do {
            {
                int loopIdx1 = 0;
                do {
                    loopIdx1++;
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10002;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                } while (loopIdx1 < inputA.a[2]);
            }
            if (subgroupElect()) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10006;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                break;
            }
            switch (inputA.a[1]) {
                case 2:
                {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000c;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    break;
                }
                case 1:
                {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10010;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    break;
                }
                case 3:
                {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10014;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    break;
                }
            }
            if (testBit(uvec4(0x93a1d546, 0xe07426cb, 0x81c84aa9, 0xaf993f6f), gl_SubgroupInvocationID)) {
            } else {
            }
            loopIdx0++;
        } while (true);
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


void main()
[[subgroup_uniform_control_flow]]
{

    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10000;
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
    switch (inputA.a[3]) {
        case 4:
        {
            for (int loopIdx0 = 0;
                     loopIdx0 < gl_SubgroupInvocationID + 1;
                     loopIdx0++) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10005;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            }
            break;
        }
        case 3:
        {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000a;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            if (inputA.a[0] == 0) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000d;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            } else {
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10011;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            if (inputA.a[2] == 2) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10014;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            } else {
            }
            break;
        }
        case 5:
        {
            {
                int loopIdx0 = 0;
                do {
                    if (subgroupElect()) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001c;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                        if (testBit(uvec4(0xedd126dc, 0xdc84a6e2, 0x2f332044, 0x63902f01), gl_SubgroupInvocationID)) {
                            break;
                        } else {
                            break;
                        }
                    }
                    loopIdx0++;
                } while (true);
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

    if (testBit(uvec4(0xb2fa1b23, 0xd67920f6, 0xe677f900, 0x50f0c25a), gl_SubgroupInvocationID)) {
        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10002;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        } else {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10002;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
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
                break;
            }
        }
    }
    {
        int loopIdx0 = 0;
        do {
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10013;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            } else {
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10017;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex2]) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001a;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            } else {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001a;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            }
            if (subgroupElect()) {
                break;
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10023;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            if (gl_SubgroupInvocationID == loopIdx0) {
            } else {
            }
            loopIdx0++;
        } while (true);
    }
    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10029;
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

    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
    }
    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
        if (inputA.a[2] == 2) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10004;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        } else {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10004;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        }
    }
    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000b;
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
    if (testBit(uvec4(0x24209002, 0xa32c6f41, 0xbdeb4150, 0xeb453b5d), gl_SubgroupInvocationID)) {
        for (int loopIdx0 = 0;
                 loopIdx0 < inputA.a[1];
                 loopIdx0++) {
        }
        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex2]) {
        }
    }
    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex3]) {
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
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10018;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                break;
            }
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
layout(constant_id = 11) const uint cmpIndex1 = 0u;


void main()
[[subgroup_uniform_control_flow]]
{

    if (inputA.a[3] == 3) {
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10001;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
        } else {
        }
    } else {
        {
            int loopIdx0 = 0;
            do {
                if (subgroupElect()) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10009;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    break;
                }
                loopIdx0++;
            } while (true);
        }
        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
        }
    }
    switch (inputA.a[4]) {
        case 5:
        {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10013;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            break;
        }
        case 4:
        {
            if (inputA.a[0] == 0) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10018;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            }
            for (int loopIdx0 = 0;
                     loopIdx0 < gl_SubgroupInvocationID + 1;
                     loopIdx0++) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001c;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            }
            break;
        }
        case 6:
        {
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

    for (int loopIdx0 = 0;
             loopIdx0 < inputA.a[5];
             loopIdx0++) {
        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
            if (testBit(uvec4(0xf0153983, 0x5659d60c, 0x9176f58, 0xc4561528), gl_SubgroupInvocationID)) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10003;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            }
            if (inputA.a[0] == 0) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10007;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            } else {
            }
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000c;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        continue;
    }
    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10010;
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
    for (int loopIdx0 = 0;;loopIdx0++,    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect()) {
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10013;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        switch (loopIdx0) {
            case 1: {
                if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10018;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                } else {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10018;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001e;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                break;
            }
            case 2: {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10022;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                break;
            }
            default: {
                for (int loopIdx1 = 0;
                         loopIdx1 < gl_SubgroupInvocationID + 1;
                         loopIdx1++) {
                }
                break;
            }
        }
        if (subgroupElect()) {
            break;
        }
        if (gl_SubgroupInvocationID == loopIdx0) {
            if (inputA.a[1] == 1) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002f;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            } else {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10032;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10035;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            break;
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10039;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        for (int loopIdx1 = 0;
                 loopIdx1 < inputA.a[4];
                 loopIdx1++) {
            continue;
            for (int loopIdx2 = 0;
                     loopIdx2 < gl_SubgroupInvocationID + 1;
                     loopIdx2++) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1003e;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10041;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10044;
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
[[subgroup_uniform_control_flow]]
{

    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10000;
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex2]) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10005;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            } else {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10008;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            }
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex3]) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000c;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            } else {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000c;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            }
        }
        switch (inputA.a[3]) {
            case 4:
            {
                break;
            }
            case 3:
            {
                if (gl_LocalInvocationIndex >= inputA.a[cmpIndex4]) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10018;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                } else {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10018;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001e;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                if (gl_LocalInvocationIndex >= inputA.a[cmpIndex5]) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10021;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                }
                break;
            }
            case 5:
            {
                if (testBit(uvec4(0x747b38eb, 0xdcabe30f, 0xb7e2334f, 0xfa3a7a50), gl_SubgroupInvocationID)) {
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10028;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                break;
            }
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002c;
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

    if (subgroupElect()) {
        {
            int loopIdx0 = 0;
            do {
                if (testBit(uvec4(0x12588461, 0xdcb33016, 0xd107e1bb, 0x9c19fa28), gl_SubgroupInvocationID)) {
                } else {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10004;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                }
                break;
                if (subgroupElect()) {
                    break;
                }
                if (inputA.a[2] == 2) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000c;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                } else {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000f;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                }
                if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10013;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                }
                loopIdx0++;
            } while (true);
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10017;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        switch (gl_SubgroupInvocationID & 3) {
            case 0:
            {
                if (subgroupElect()) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001c;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                }
                break;
            }
            case 1:
            {
                for (int loopIdx0 = 0;
                         loopIdx0 < gl_SubgroupInvocationID + 1;
                         loopIdx0++) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10022;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10025;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                break;
            }
            case 2:
            {
                if (testBit(uvec4(0xadba414a, 0xf7600dc, 0xd534f30e, 0x88c8e8db), gl_SubgroupInvocationID)) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002a;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002d;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                break;
            }
            case 3:
            {
                if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10032;
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


void main()
[[subgroup_uniform_control_flow]]
{

    if (testBit(uvec4(0x4f5bedce, 0xff3891ce, 0xfc0c4844, 0x7aa4e5bb), gl_SubgroupInvocationID)) {
        for (int loopIdx0 = 0;
                 loopIdx0 < inputA.a[5];
                 loopIdx0++) {
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10003;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10006;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        }
        if (testBit(uvec4(0x5724b049, 0xc78100ea, 0x94202959, 0xaf00e2b), gl_SubgroupInvocationID)) {
            if (testBit(uvec4(0x29bdb8bb, 0x5b69ed67, 0x3649f53f, 0xa3b66af1), gl_SubgroupInvocationID)) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000b;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000e;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            if (inputA.a[3] == 3) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10011;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            } else {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10011;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            }
        }
    } else {
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10019;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        {
            int loopIdx0 = 0;
            do {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001c;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                if (inputA.a[1] == 1) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001f;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10022;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                for (int loopIdx1 = 0;
                         loopIdx1 < inputA.a[5];
                         loopIdx1++) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10025;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                }
                if (subgroupElect()) {
                    break;
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002b;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                switch (gl_SubgroupInvocationID & 3) {
                    case 0:
                    {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002f;
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
                break;
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1003a;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                loopIdx0++;
            } while (true);
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1003d;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        if (subgroupElect()) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10040;
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
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10048;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    break;
                }
            }
        }
    }
    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1004e;
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

    for (int loopIdx0 = 0;
             loopIdx0 < gl_SubgroupInvocationID + 1;
             loopIdx0++) {
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10001;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        break;
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10004;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
    }
    for (int loopIdx0 = 0;;loopIdx0++,    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect()) {
        for (int loopIdx1 = 0;;loopIdx1++,        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect()) {
            if (subgroupElect()) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000a;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            }
            if (subgroupElect()) {
                if (testBit(uvec4(0x42962bce, 0xdc83561c, 0x804b9d28, 0xccd73ff2), gl_SubgroupInvocationID)) {
                    break;
                } else {
                    break;
                }
            }
            break;
            break;
        }
        break;
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10018;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        if (subgroupElect()) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001b;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            break;
        }
        for (int loopIdx1 = 0;
                 loopIdx1 < inputA.a[1];
                 loopIdx1++) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10020;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10023;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                while (!subgroupElect()) {}
            } else {
            }
            if (gl_SubgroupInvocationID == loopIdx1) {
            } else {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002a;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            }
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002e;
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
    void func0() {
        if (testBit(uvec4(0x42962bce, 0xdc83561c, 0x804b9d28, 0xccd73ff2), gl_SubgroupInvocationID)) {
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
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001e;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    break;
                }
                case 3:
                {
                    break;
                }
            }
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10025;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
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
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001e;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    break;
                }
                case 3:
                {
                    break;
                }
            }
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex2]) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10025;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            }
        }
        if (testBit(uvec4(0xb58593c9, 0x46be088b, 0x1ca665ca, 0xc0d80224), gl_SubgroupInvocationID)) {
            switch (gl_SubgroupInvocationID & 3) {
                case 0:
                {
                    break;
                }
                case 1:
                {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1003f;
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
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10045;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    break;
                }
            }
            for (int loopIdx0 = 0;
                     loopIdx0 < inputA.a[1];
                     loopIdx0++) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1004a;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            }
        } else {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1004e;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex3]) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10051;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            } else {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10051;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10057;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1005a;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
    }


void main()
[[subgroup_uniform_control_flow]]
{

    {
        int loopIdx0 = 0;
        do {
            {
                int loopIdx1 = 0;
                do {
                    loopIdx1++;
                    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10003;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    } else {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10003;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    }
                } while (loopIdx1 < inputA.a[2]);
            }
            if (subgroupElect()) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000b;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                if (testBit(uvec4(0x42962bce, 0xdc83561c, 0x804b9d28, 0xccd73ff2), gl_SubgroupInvocationID)) {
                    break;
                } else {
                    break;
                }
            }
            loopIdx0++;
        } while (true);
    }
    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10014;
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
    func0();



}
#version 450 core
#extension GL_KHR_shader_subgroup_ballot : enable
#extension GL_KHR_shader_subgroup_vote : enable
#extension GL_NV_shader_subgroup_partitioned : enable
#extension GL_EXT_subgroup_uniform_control_flow : enable
layout(local_size_x_id = 0, local_size_y_id = 1, local_size_z = 1) in;
layout(set=0, binding=2) coherent buffer OutputC { uint loc[]; } outputC;
layout(set=0, binding=1) coherent buffer OutputB { uvec4 b[]; } outputB;
layout(set=0, binding=0) coherent buffer InputA  { uint  a[]; } inputA;
layout(push_constant) uniform PC {
   // set to the real stride when writing out ballots, or zero when just counting
   int  invocationStride;
   // wildcard fields, for an example the dimensions of rendered area in the case of graphics shaders
   int  width;
   int  height;
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

    if (testBit(uvec4(0xb2fa1b23, 0xd67920f6, 0xe677f900, 0x50f0c25a), gl_SubgroupInvocationID)) {
        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10002;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10005;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            }
        } else {
            for (int loopIdx0 = 0;
                     loopIdx0 < inputA.a[1];
                     loopIdx0++) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000a;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            }
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000e;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
    }
    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10011;
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
    if (subgroupElect()) {
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10014;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
    }
    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10017;
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
    if (testBit(uvec4(0x7f5707d0, 0x5d879aae, 0x14a07613, 0x2cdb4025), gl_SubgroupInvocationID)) {
        switch (inputA.a[1]) {
            case 2:
            {
                switch (gl_SubgroupInvocationID & 3) {
                    case 0:
                    case 1:
                    {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001e;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                        break;
                    }
                    case 2:
                    case 3:
                    {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10022;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                        break;
                    }
                }
                break;
            }
            case 1:
            {
                for (int loopIdx0 = 0;;loopIdx0++,                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect()) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10029;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    if (subgroupElect()) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002c;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
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
                break;
            }
            case 3:
            {
                {
                    int loopIdx0 = 0;
                    do {
                        loopIdx0++;
                    } while (loopIdx0 < inputA.a[3]);
                }
                break;
            }
        }
        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex2]) {
            switch (gl_SubgroupInvocationID & 3) {
                case 0:
                {
                    break;
                }
                case 1:
                {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10044;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
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
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1004c;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        } else {
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex3]) {
            }
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10052;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
    }
    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10055;
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
        {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10002;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            break;
        }
        case 1:
        {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10006;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            {
                int loopIdx0 = 0;
                do {
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
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000d;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                            break;
                        }
                    }
                    if (subgroupElect()) {
                        break;
                    }
                    {
                        int loopIdx1 = 0;
                        do {
                            if (subgroupElect()) {
                                break;
                            }
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10018;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                            loopIdx1++;
                        } while (true);
                    }
                    break;
                    loopIdx0++;
                } while (true);
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001d;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            break;
        }
        case 2:
        {
            if (testBit(uvec4(0xdad44150, 0xcc9c23ad, 0x98038084, 0x4acdfcad), gl_SubgroupInvocationID)) {
                if (inputA.a[1] == 1) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10023;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
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
                        break;
                    }
                }
            }
            break;
        }
        case 3:
        {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10031;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            for (int loopIdx0 = 0;;loopIdx0++,            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect()) {
                if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10035;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                } else {
                }
                break;
                if (subgroupElect()) {
                    break;
                }
                if (gl_SubgroupInvocationID == loopIdx0) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1003e;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                } else {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10041;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10044;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                switch (gl_SubgroupInvocationID & 3) {
                    case 0:
                    {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10048;
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
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10052;
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

    if (inputA.a[1] == 1) {
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10001;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10004;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        } else {
            switch (inputA.a[4]) {
                case 5:
                {
                    break;
                }
                case 4:
                {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000b;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    break;
                }
                case 6:
                {
                    break;
                }
            }
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10012;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            }
        }
        for (int loopIdx0 = 0;
                 loopIdx0 < gl_SubgroupInvocationID + 1;
                 loopIdx0++) {
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex2]) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10018;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            }
        }
    } else {
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001d;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        if (inputA.a[1] == 1) {
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex3]) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10021;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            }
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10025;
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
             loopIdx0 < inputA.a[5];
             loopIdx0++) {
        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
            if (testBit(uvec4(0xf0153983, 0x5659d60c, 0x9176f58, 0xc4561528), gl_SubgroupInvocationID)) {
                break;
                if (gl_SubgroupInvocationID == loopIdx0) {
                }
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10007;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            if (inputA.a[0] == 0) {
                switch (gl_SubgroupInvocationID & 3) {
                    case 0:
                    {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000c;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                        break;
                    }
                    case 1:
                    {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10010;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
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
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10018;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                for (int loopIdx1 = 0;;loopIdx1++,                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect()) {
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
            } else {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10024;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                if (gl_SubgroupInvocationID == loopIdx0) {
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10028;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                {
                    int loopIdx1 = 0;
                    do {
                        loopIdx1++;
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002b;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    } while (loopIdx1 < inputA.a[5]);
                }
            }
        }
        break;
    }
    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10032;
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
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex2]) {
                for (int loopIdx0 = 0;;loopIdx0++,                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect()) {
                    if (subgroupElect()) {
                        break;
                    }
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000a;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                {
                    int loopIdx0 = 0;
                    do {
                        loopIdx0++;
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000d;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    } while (loopIdx0 < inputA.a[2]);
                }
            }
            if (inputA.a[0] == 0) {
                {
                    int loopIdx0 = 0;
                    do {
                        if (subgroupElect()) {
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10014;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                            break;
                        }
                        loopIdx0++;
                    } while (true);
                }
                if (subgroupElect()) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001a;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                }
            }
        } else {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001f;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            for (int loopIdx0 = 0;
                     loopIdx0 < inputA.a[3];
                     loopIdx0++) {
                if (testBit(uvec4(0x99c3d736, 0x34d20d27, 0x16dcf3a0, 0xb002d6a4), gl_SubgroupInvocationID)) {
                }
                if (testBit(uvec4(0x99c3d736, 0x34d20d27, 0x16dcf3a0, 0xb002d6a4), gl_SubgroupInvocationID)) {
                }
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10027;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            for (int loopIdx0 = 0;
                     loopIdx0 < inputA.a[2];
                     loopIdx0++) {
                if (gl_SubgroupInvocationID == loopIdx0) {
                }
                if (gl_SubgroupInvocationID == loopIdx0) {
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002e;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            }
        }
    } else {
        if (inputA.a[0] == 0) {
            switch (inputA.a[1]) {
                case 2:
                {
                    {
                        int loopIdx0 = 0;
                        do {
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10037;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                            if (subgroupElect()) {
                                outputC.loc[gl_LocalInvocationIndex]++;
                                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1003a;
                                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                                break;
                            }
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1003e;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                            loopIdx0++;
                        } while (true);
                    }
                    break;
                }
                case 1:
                {
                    {
                        int loopIdx0 = 0;
                        do {
                            loopIdx0++;
                        } while (loopIdx0 < inputA.a[1]);
                    }
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
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1004c;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
    }
    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1004f;
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

    if (testBit(uvec4(0x42dcad6e, 0x9471480d, 0xffa3e60d, 0x1147d7a7), gl_SubgroupInvocationID)) {
        if (subgroupElect()) {
            if (subgroupElect()) {
                for (int loopIdx0 = 0;
                         loopIdx0 < inputA.a[2];
                         loopIdx0++) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10004;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                }
            }
            {
                int loopIdx0 = 0;
                do {
                    loopIdx0++;
                    for (int loopIdx1 = 0;;loopIdx1++,                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect()) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000a;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                        if (subgroupElect()) {
                            break;
                        }
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000f;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    }
                    break;
                } while (loopIdx0 < inputA.a[1]);
            }
        }
        if (subgroupElect()) {
            for (int loopIdx0 = 0;
                     loopIdx0 < gl_SubgroupInvocationID + 1;
                     loopIdx0++) {
                if (subgroupElect()) {
                }
                for (int loopIdx1 = 0;
                         loopIdx1 < inputA.a[1];
                         loopIdx1++) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001a;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                }
            }
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
                if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10020;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                } else {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10023;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                }
                if (gl_LocalInvocationIndex >= inputA.a[cmpIndex2]) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10027;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                } else {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002a;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                }
            }
        }
    } else {
        if (subgroupElect()) {
            if (subgroupElect()) {
                for (int loopIdx0 = 0;
                         loopIdx0 < inputA.a[2];
                         loopIdx0++) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10004;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                }
            }
            {
                int loopIdx0 = 0;
                do {
                    loopIdx0++;
                    for (int loopIdx1 = 0;;loopIdx1++,                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect()) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000a;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                        if (subgroupElect()) {
                            break;
                        }
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000f;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    }
                    break;
                } while (loopIdx0 < inputA.a[1]);
            }
        }
        if (subgroupElect()) {
            for (int loopIdx0 = 0;
                     loopIdx0 < gl_SubgroupInvocationID + 1;
                     loopIdx0++) {
                if (subgroupElect()) {
                }
                for (int loopIdx1 = 0;
                         loopIdx1 < inputA.a[1];
                         loopIdx1++) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001a;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                }
            }
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex3]) {
                if (gl_LocalInvocationIndex >= inputA.a[cmpIndex4]) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10020;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                } else {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10023;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                }
                if (gl_LocalInvocationIndex >= inputA.a[cmpIndex5]) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10027;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                } else {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002a;
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
layout(constant_id = 14) const uint cmpIndex4 = 0u;


void main()
[[subgroup_uniform_control_flow]]
{

    if (testBit(uvec4(0x4f5bedce, 0xff3891ce, 0xfc0c4844, 0x7aa4e5bb), gl_SubgroupInvocationID)) {
        for (int loopIdx0 = 0;
                 loopIdx0 < inputA.a[5];
                 loopIdx0++) {
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10003;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                continue;
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10006;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            } else {
                if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000a;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000d;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                for (int loopIdx1 = 0;
                         loopIdx1 < gl_SubgroupInvocationID + 1;
                         loopIdx1++) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10010;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10013;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            }
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex2]) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10017;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                {
                    int loopIdx1 = 0;
                    do {
                        loopIdx1++;
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001a;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    } while (loopIdx1 < inputA.a[1]);
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001d;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                {
                    int loopIdx1 = 0;
                    do {
                        loopIdx1++;
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10020;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    } while (loopIdx1 < inputA.a[5]);
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10023;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            } else {
                {
                    int loopIdx1 = 0;
                    do {
                        loopIdx1++;
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10027;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    } while (loopIdx1 < inputA.a[2]);
                }
                break;
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002b;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            }
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002f;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        for (int loopIdx0 = 0;
                 loopIdx0 < inputA.a[5];
                 loopIdx0++) {
            {
                int loopIdx1 = 0;
                do {
                    loopIdx1++;
                    continue;
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10034;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex3]) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10037;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    } else {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1003a;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    }
                } while (loopIdx1 < inputA.a[3]);
            }
            {
                int loopIdx1 = 0;
                do {
                    if (testBit(uvec4(0x29bdb8bb, 0x5b69ed67, 0x3649f53f, 0xa3b66af1), gl_SubgroupInvocationID)) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10040;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    }
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10043;
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
                    if (subgroupElect()) {
                        break;
                    }
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10050;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    if (subgroupElect()) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10053;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    }
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10056;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex4]) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10059;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
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
layout(constant_id = 12) const uint cmpIndex2 = 0u;
layout(constant_id = 13) const uint cmpIndex3 = 0u;
layout(constant_id = 14) const uint cmpIndex4 = 0u;


void main()
[[subgroup_uniform_control_flow]]
{

    {
        int loopIdx0 = 0;
        do {
            {
                int loopIdx1 = 0;
                do {
                    loopIdx1++;
                    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10003;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                        if (testBit(uvec4(0x336819ca, 0xaaeacc85, 0x1c064f2a, 0x33a1f4a1), gl_SubgroupInvocationID)) {
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10006;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                        }
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10009;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                        {
                            int loopIdx2 = 0;
                            do {
                                loopIdx2++;
                                outputC.loc[gl_LocalInvocationIndex]++;
                                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000c;
                                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                            } while (loopIdx2 < inputA.a[2]);
                        }
                    }
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10010;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    switch (gl_SubgroupInvocationID & 3) {
                        case 0:
                        {
                            if (inputA.a[1] == 1) {
                            } else {
                            }
                            break;
                        }
                        case 1:
                        {
                            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
                            } else {
                            }
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001c;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                            break;
                        }
                        case 2:
                        {
                            break;
                            break;
                        }
                        case 3:
                        {
                            {
                                int loopIdx2 = 0;
                                do {
                                    loopIdx2++;
                                    outputC.loc[gl_LocalInvocationIndex]++;
                                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10024;
                                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                                } while (loopIdx2 < inputA.a[5]);
                            }
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10027;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                            break;
                        }
                    }
                } while (loopIdx1 < inputA.a[2]);
            }
            if (subgroupElect()) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002d;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                break;
            }
            {
                int loopIdx1 = 0;
                do {
                    loopIdx1++;
                    switch (loopIdx1) {
                        case 1: {
                            if (gl_SubgroupInvocationID == loopIdx1) {
                                outputC.loc[gl_LocalInvocationIndex]++;
                                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10035;
                                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                            } else {
                                outputC.loc[gl_LocalInvocationIndex]++;
                                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10038;
                                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                            }
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1003b;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                            break;
                        }
                        case 2: {
                            if (gl_SubgroupInvocationID == loopIdx1) {
                                outputC.loc[gl_LocalInvocationIndex]++;
                                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10040;
                                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                            }
                            break;
                        }
                        default: {
                            for (int loopIdx2 = 0;
                                     loopIdx2 < gl_SubgroupInvocationID + 1;
                                     loopIdx2++) {
                                outputC.loc[gl_LocalInvocationIndex]++;
                                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10046;
                                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                            }
                            break;
                        }
                    }
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1004b;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    if (inputA.a[3] == 3) {
                        if (gl_SubgroupInvocationID == loopIdx1) {
                        } else {
                        }
                        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex2]) {
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10052;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                        } else {
                        }
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10056;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    } else {
                        if (testBit(uvec4(0x42962bce, 0xdc83561c, 0x804b9d28, 0xccd73ff2), gl_SubgroupInvocationID)) {
                        }
                        for (int loopIdx2 = 0;
                                 loopIdx2 < inputA.a[1];
                                 loopIdx2++) {
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1005c;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                        }
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1005f;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    }
                    while (!subgroupElect()) {}
                } while (loopIdx1 < inputA.a[2]);
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10064;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            if (gl_SubgroupInvocationID == loopIdx0) {
                switch (inputA.a[0]) {
                    case 1:
                    {
                        for (int loopIdx1 = 0;
                                 loopIdx1 < inputA.a[5];
                                 loopIdx1++) {
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1006a;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                        }
                        break;
                    }
                    case 0:
                    {
                        if (inputA.a[3] == 3) {
                        }
                        break;
                        break;
                    }
                    case 2:
                    {
                        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex3]) {
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10075;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                        }
                        break;
                    }
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1007a;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                if (testBit(uvec4(0x5d5d909f, 0xc0cb6625, 0xf80726dc, 0x3b59be1c), gl_SubgroupInvocationID)) {
                    if (testBit(uvec4(0x42962bce, 0xdc83561c, 0x804b9d28, 0xccd73ff2), gl_SubgroupInvocationID)) {
                    }
                } else {
                    if (testBit(uvec4(0x42962bce, 0xdc83561c, 0x804b9d28, 0xccd73ff2), gl_SubgroupInvocationID)) {
                    }
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10083;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            } else {
                switch (loopIdx0) {
                    case 1: {
                        {
                            int loopIdx1 = 0;
                            do {
                                loopIdx1++;
                            } while (loopIdx1 < inputA.a[4]);
                        }
                        break;
                    }
                    case 2: {
                        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex4]) {
                        } else {
                        }
                        break;
                    }
                    default: {
                        if (inputA.a[3] == 3) {
                        }
                        break;
                    }
                }
                {
                    int loopIdx1 = 0;
                    do {
                        loopIdx1++;
                        if (inputA.a[2] == 2) {
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10097;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                        } else {
                        }
                        for (int loopIdx2 = 0;
                                 loopIdx2 < inputA.a[5];
                                 loopIdx2++) {
                        }
                    } while (loopIdx1 < inputA.a[3]);
                }
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1009f;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
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

    if (testBit(uvec4(0xb2fa1b23, 0xd67920f6, 0xe677f900, 0x50f0c25a), gl_SubgroupInvocationID)) {
        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10002;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
                if (subgroupElect()) {
                }
                {
                    int loopIdx0 = 0;
                    do {
                        if (subgroupElect()) {
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10009;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                            break;
                        }
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000d;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                        loopIdx0++;
                    } while (true);
                }
            } else {
                if (subgroupElect()) {
                }
                {
                    int loopIdx0 = 0;
                    do {
                        if (subgroupElect()) {
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10009;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                            break;
                        }
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000d;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                        loopIdx0++;
                    } while (true);
                }
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001d;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        } else {
            if (inputA.a[0] == 0) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10021;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                if (inputA.a[0] == 0) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10024;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                }
            } else {
                if (inputA.a[2] == 2) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10029;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                } else {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10029;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                }
                for (int loopIdx0 = 0;
                         loopIdx0 < inputA.a[3];
                         loopIdx0++) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10030;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                }
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10034;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        }
        for (int loopIdx0 = 0;
                 loopIdx0 < inputA.a[1];
                 loopIdx0++) {
            switch (gl_SubgroupInvocationID & 3) {
                case 0:
                {
                    if (testBit(uvec4(0xedd126dc, 0xdc84a6e2, 0x2f332044, 0x63902f01), gl_SubgroupInvocationID)) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1003b;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    }
                    break;
                }
                case 1:
                {
                    for (int loopIdx1 = 0;
                             loopIdx1 < gl_SubgroupInvocationID + 1;
                             loopIdx1++) {
                    }
                    break;
                }
                case 2:
                {
                    if (subgroupElect()) {
                    }
                    break;
                }
                case 3:
                {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10048;
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
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1004e;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                            break;
                        }
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


void main()
[[subgroup_uniform_control_flow]]
{

    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
    }
    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
        if (inputA.a[0] == 0) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10004;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            switch (gl_SubgroupInvocationID & 3) {
                case 0:
                {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10008;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex2]) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000b;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    } else {
                    }
                    break;
                }
                case 1:
                {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10011;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    break;
                }
                case 2:
                {
                    for (int loopIdx0 = 0;;loopIdx0++,                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect()) {
                        if (subgroupElect()) {
                            break;
                        }
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10019;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    }
                    break;
                }
                case 3:
                {
                    if (inputA.a[0] == 0) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001f;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    }
                    break;
                }
            }
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10025;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
    } else {
        if (inputA.a[3] == 3) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10004;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            switch (gl_SubgroupInvocationID & 3) {
                case 0:
                {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10008;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex3]) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000b;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    } else {
                    }
                    break;
                }
                case 1:
                {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10011;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    break;
                }
                case 2:
                {
                    for (int loopIdx0 = 0;;loopIdx0++,                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect()) {
                        if (subgroupElect()) {
                            break;
                        }
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10019;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    }
                    break;
                }
                case 3:
                {
                    if (inputA.a[2] == 2) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001f;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    }
                    break;
                }
            }
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10025;
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


void main()
[[subgroup_uniform_control_flow]]
{

    if (inputA.a[0] == 0) {
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10001;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10004;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        } else {
            switch (inputA.a[4]) {
                case 5:
                {
                    if (subgroupElect()) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000a;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    }
                    break;
                }
                case 4:
                {
                    break;
                }
                case 6:
                {
                    if (inputA.a[2] == 2) {
                    } else {
                    }
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10014;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    break;
                }
            }
            switch (inputA.a[0]) {
                case 1:
                {
                    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001b;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    }
                    break;
                }
                case 0:
                {
                    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex2]) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10021;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    }
                    {
                        int loopIdx0 = 0;
                        do {
                            loopIdx0++;
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10025;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                        } while (loopIdx0 < inputA.a[4]);
                    }
                    break;
                }
                case 2:
                {
                    break;
                }
            }
        }
    } else {
        switch (gl_SubgroupInvocationID & 3) {
            case 0:
            case 1:
            {
                {
                    int loopIdx0 = 0;
                    do {
                        loopIdx0++;
                        for (int loopIdx1 = 0;
                                 loopIdx1 < inputA.a[1];
                                 loopIdx1++) {
                        }
                    } while (loopIdx0 < inputA.a[2]);
                }
                break;
            }
            case 2:
            case 3:
            {
                for (int loopIdx0 = 0;;loopIdx0++,                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect()) {
                    if (testBit(uvec4(0x598bd779, 0xdc94c4ec, 0x9bea62b5, 0xd7cae80b), gl_SubgroupInvocationID)) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10038;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    }
                    if (subgroupElect()) {
                    }
                    if (subgroupElect()) {
                        break;
                    }
                    break;
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


void main()
[[subgroup_uniform_control_flow]]
{

    for (int loopIdx0 = 0;
             loopIdx0 < inputA.a[5];
             loopIdx0++) {
        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10002;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        } else {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10002;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        }
        for (int loopIdx1 = 0;;loopIdx1++,        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true)) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10009;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            if (subgroupElect()) {
                break;
            }
        }
    }
    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
    }
    switch (inputA.a[4]) {
        case 5:
        {
            switch (gl_SubgroupInvocationID & 3) {
                case 0:
                case 1:
                {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10016;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
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
            break;
        }
        case 4:
        {
            {
                int loopIdx0 = 0;
                do {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10021;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    if (subgroupElect()) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10024;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        break;
                    }
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10028;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    loopIdx0++;
                } while (true);
            }
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex2]) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002c;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            } else {
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10030;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            break;
        }
        case 6:
        {
            if (subgroupElect()) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10035;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            }
            break;
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


void main()
[[subgroup_uniform_control_flow]]
{

    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
        if (subgroupElect()) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10002;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        }
        for (int loopIdx0 = 0;
                 loopIdx0 < inputA.a[3];
                 loopIdx0++) {
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10007;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
    } else {
        if (subgroupElect()) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10002;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        }
        for (int loopIdx0 = 0;
                 loopIdx0 < inputA.a[3];
                 loopIdx0++) {
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10007;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
    }
    {
        int loopIdx0 = 0;
        do {
            if (inputA.a[1] == 1) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10015;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            } else {
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
            for (int loopIdx1 = 0;
                     loopIdx1 < gl_SubgroupInvocationID + 1;
                     loopIdx1++) {
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10022;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            if (subgroupElect()) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10025;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            }
            loopIdx0++;
        } while (true);
    }
    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10029;
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
        }
        if (inputA.a[1] == 1) {
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10007;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
    } else {
        for (int loopIdx0 = 0;
                 loopIdx0 < gl_SubgroupInvocationID + 1;
                 loopIdx0++) {
        }
    }
    if (inputA.a[2] == 2) {
        {
            int loopIdx0 = 0;
            do {
                if (subgroupElect()) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10010;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    break;
                }
                loopIdx0++;
            } while (true);
        }
        if (subgroupElect()) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10016;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        }
    }
    for (int loopIdx0 = 0;
             loopIdx0 < gl_SubgroupInvocationID + 1;
             loopIdx0++) {
        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex2]) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001c;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        } else {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001f;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        }
        if (testBit(uvec4(0x747b38eb, 0xdcabe30f, 0xb7e2334f, 0xfa3a7a50), gl_SubgroupInvocationID)) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10023;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10026;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
    }
    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10029;
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

    if (testBit(uvec4(0x42dcad6e, 0x9471480d, 0xffa3e60d, 0x1147d7a7), gl_SubgroupInvocationID)) {
        if (subgroupElect()) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10002;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        }
        for (int loopIdx0 = 0;
                 loopIdx0 < inputA.a[2];
                 loopIdx0++) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10006;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        }
    } else {
        if (testBit(uvec4(0xadba414a, 0xf7600dc, 0xd534f30e, 0x88c8e8db), gl_SubgroupInvocationID)) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000b;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        } else {
        }
        for (int loopIdx0 = 0;
                 loopIdx0 < gl_SubgroupInvocationID + 1;
                 loopIdx0++) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10010;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        }
    }
    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
        if (inputA.a[2] == 2) {
        } else {
        }
        {
            int loopIdx0 = 0;
            do {
                loopIdx0++;
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10019;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            } while (loopIdx0 < inputA.a[1]);
        }
    } else {
        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001e;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        } else {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10021;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
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
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
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
            break;
        }
        case 2:
        case 3:
        {
            switch (gl_SubgroupInvocationID & 3) {
                case 0:
                case 1:
                {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10011;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    break;
                }
                case 2:
                case 3:
                {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10015;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    break;
                }
            }
            for (int loopIdx0 = 0;;loopIdx0++,            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true)) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001a;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                if (subgroupElect()) {
                    break;
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001f;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10022;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            break;
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


void main()
[[subgroup_uniform_control_flow]]
{

    if (testBit(uvec4(0x4f5bedce, 0xff3891ce, 0xfc0c4844, 0x7aa4e5bb), gl_SubgroupInvocationID)) {
        for (int loopIdx0 = 0;
                 loopIdx0 < inputA.a[5];
                 loopIdx0++) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10002;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10005;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
    }
    if (subgroupElect()) {
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
        {
            int loopIdx0 = 0;
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
                loopIdx0++;
            } while (true);
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


void main()
[[subgroup_uniform_control_flow]]
{

    {
        int loopIdx0 = 0;
        do {
            {
                int loopIdx1 = 0;
                do {
                    loopIdx1++;
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10002;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                } while (loopIdx1 < inputA.a[2]);
            }
            if (subgroupElect()) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10006;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                break;
            }
            switch (inputA.a[1]) {
                case 2:
                {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000c;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    break;
                }
                case 1:
                {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10010;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    break;
                }
                case 3:
                {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10014;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    break;
                }
            }
            if (testBit(uvec4(0x93a1d546, 0xe07426cb, 0x81c84aa9, 0xaf993f6f), gl_SubgroupInvocationID)) {
            } else {
            }
            loopIdx0++;
        } while (true);
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


void main()
[[subgroup_uniform_control_flow]]
{

    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10000;
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
    switch (inputA.a[3]) {
        case 4:
        {
            for (int loopIdx0 = 0;
                     loopIdx0 < gl_SubgroupInvocationID + 1;
                     loopIdx0++) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10005;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            }
            break;
        }
        case 3:
        {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000a;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            if (inputA.a[0] == 0) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000d;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            } else {
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10011;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            if (inputA.a[2] == 2) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10014;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            } else {
            }
            break;
        }
        case 5:
        {
            {
                int loopIdx0 = 0;
                do {
                    if (subgroupElect()) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001c;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        if (testBit(uvec4(0xedd126dc, 0xdc84a6e2, 0x2f332044, 0x63902f01), gl_SubgroupInvocationID)) {
                            break;
                        } else {
                            break;
                        }
                    }
                    loopIdx0++;
                } while (true);
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

    if (testBit(uvec4(0xb2fa1b23, 0xd67920f6, 0xe677f900, 0x50f0c25a), gl_SubgroupInvocationID)) {
        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10002;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        } else {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10002;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
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
                break;
            }
        }
    }
    {
        int loopIdx0 = 0;
        do {
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10013;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            } else {
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10017;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex2]) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001a;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            } else {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001a;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            }
            if (subgroupElect()) {
                break;
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10023;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            if (gl_SubgroupInvocationID == loopIdx0) {
            } else {
            }
            loopIdx0++;
        } while (true);
    }
    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10029;
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

    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
    }
    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
        if (inputA.a[2] == 2) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10004;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        } else {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10004;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        }
    }
    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000b;
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
    if (testBit(uvec4(0x24209002, 0xa32c6f41, 0xbdeb4150, 0xeb453b5d), gl_SubgroupInvocationID)) {
        for (int loopIdx0 = 0;
                 loopIdx0 < inputA.a[1];
                 loopIdx0++) {
        }
        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex2]) {
        }
    }
    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex3]) {
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
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10018;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                break;
            }
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
layout(constant_id = 11) const uint cmpIndex1 = 0u;


void main()
[[subgroup_uniform_control_flow]]
{

    if (inputA.a[3] == 3) {
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10001;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
        } else {
        }
    } else {
        {
            int loopIdx0 = 0;
            do {
                if (subgroupElect()) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10009;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    break;
                }
                loopIdx0++;
            } while (true);
        }
        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
        }
    }
    switch (inputA.a[4]) {
        case 5:
        {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10013;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            break;
        }
        case 4:
        {
            if (inputA.a[0] == 0) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10018;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            }
            for (int loopIdx0 = 0;
                     loopIdx0 < gl_SubgroupInvocationID + 1;
                     loopIdx0++) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001c;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            }
            break;
        }
        case 6:
        {
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

    for (int loopIdx0 = 0;
             loopIdx0 < inputA.a[5];
             loopIdx0++) {
        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
            if (testBit(uvec4(0xf0153983, 0x5659d60c, 0x9176f58, 0xc4561528), gl_SubgroupInvocationID)) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10003;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            }
            if (inputA.a[0] == 0) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10007;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            } else {
            }
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000c;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        continue;
    }
    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10010;
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
    for (int loopIdx0 = 0;;loopIdx0++,    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true)) {
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10013;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        switch (loopIdx0) {
            case 1: {
                if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10018;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                } else {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10018;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001e;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                break;
            }
            case 2: {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10022;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                break;
            }
            default: {
                for (int loopIdx1 = 0;
                         loopIdx1 < gl_SubgroupInvocationID + 1;
                         loopIdx1++) {
                }
                break;
            }
        }
        if (subgroupElect()) {
            break;
        }
        if (gl_SubgroupInvocationID == loopIdx0) {
            if (inputA.a[1] == 1) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002f;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            } else {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10032;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10035;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            break;
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10039;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        for (int loopIdx1 = 0;
                 loopIdx1 < inputA.a[4];
                 loopIdx1++) {
            continue;
            for (int loopIdx2 = 0;
                     loopIdx2 < gl_SubgroupInvocationID + 1;
                     loopIdx2++) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1003e;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10041;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10044;
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
[[subgroup_uniform_control_flow]]
{

    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10000;
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex2]) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10005;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            } else {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10008;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            }
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex3]) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000c;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            } else {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000c;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            }
        }
        switch (inputA.a[3]) {
            case 4:
            {
                break;
            }
            case 3:
            {
                if (gl_LocalInvocationIndex >= inputA.a[cmpIndex4]) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10018;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                } else {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10018;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001e;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                if (gl_LocalInvocationIndex >= inputA.a[cmpIndex5]) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10021;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
                break;
            }
            case 5:
            {
                if (testBit(uvec4(0x747b38eb, 0xdcabe30f, 0xb7e2334f, 0xfa3a7a50), gl_SubgroupInvocationID)) {
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10028;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                break;
            }
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002c;
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

    if (subgroupElect()) {
        {
            int loopIdx0 = 0;
            do {
                if (testBit(uvec4(0x12588461, 0xdcb33016, 0xd107e1bb, 0x9c19fa28), gl_SubgroupInvocationID)) {
                } else {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10004;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
                break;
                if (subgroupElect()) {
                    break;
                }
                if (inputA.a[2] == 2) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000c;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                } else {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000f;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
                if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10013;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
                loopIdx0++;
            } while (true);
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10017;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        switch (gl_SubgroupInvocationID & 3) {
            case 0:
            {
                if (subgroupElect()) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001c;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
                break;
            }
            case 1:
            {
                for (int loopIdx0 = 0;
                         loopIdx0 < gl_SubgroupInvocationID + 1;
                         loopIdx0++) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10022;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10025;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                break;
            }
            case 2:
            {
                if (testBit(uvec4(0xadba414a, 0xf7600dc, 0xd534f30e, 0x88c8e8db), gl_SubgroupInvocationID)) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002a;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002d;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                break;
            }
            case 3:
            {
                if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10032;
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


void main()
[[subgroup_uniform_control_flow]]
{

    if (testBit(uvec4(0x4f5bedce, 0xff3891ce, 0xfc0c4844, 0x7aa4e5bb), gl_SubgroupInvocationID)) {
        for (int loopIdx0 = 0;
                 loopIdx0 < inputA.a[5];
                 loopIdx0++) {
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10003;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10006;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        }
        if (testBit(uvec4(0x5724b049, 0xc78100ea, 0x94202959, 0xaf00e2b), gl_SubgroupInvocationID)) {
            if (testBit(uvec4(0x29bdb8bb, 0x5b69ed67, 0x3649f53f, 0xa3b66af1), gl_SubgroupInvocationID)) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000b;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000e;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            if (inputA.a[3] == 3) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10011;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            } else {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10011;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            }
        }
    } else {
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10019;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        {
            int loopIdx0 = 0;
            do {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001c;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                if (inputA.a[1] == 1) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001f;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10022;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                for (int loopIdx1 = 0;
                         loopIdx1 < inputA.a[5];
                         loopIdx1++) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10025;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
                if (subgroupElect()) {
                    break;
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002b;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                switch (gl_SubgroupInvocationID & 3) {
                    case 0:
                    {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002f;
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
                break;
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1003a;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                loopIdx0++;
            } while (true);
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1003d;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        if (subgroupElect()) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10040;
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
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10048;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    break;
                }
            }
        }
    }
    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1004e;
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

    for (int loopIdx0 = 0;
             loopIdx0 < gl_SubgroupInvocationID + 1;
             loopIdx0++) {
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10001;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        break;
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10004;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
    }
    for (int loopIdx0 = 0;;loopIdx0++,    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true)) {
        for (int loopIdx1 = 0;;loopIdx1++,        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true)) {
            if (subgroupElect()) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000a;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            }
            if (subgroupElect()) {
                if (testBit(uvec4(0x42962bce, 0xdc83561c, 0x804b9d28, 0xccd73ff2), gl_SubgroupInvocationID)) {
                    break;
                } else {
                    break;
                }
            }
            break;
            break;
        }
        break;
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10018;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        if (subgroupElect()) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001b;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            break;
        }
        for (int loopIdx1 = 0;
                 loopIdx1 < inputA.a[1];
                 loopIdx1++) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10020;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10023;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                while (!subgroupElect()) {}
            } else {
            }
            if (gl_SubgroupInvocationID == loopIdx1) {
            } else {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002a;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            }
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002e;
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
    void func0() {
        if (testBit(uvec4(0x42962bce, 0xdc83561c, 0x804b9d28, 0xccd73ff2), gl_SubgroupInvocationID)) {
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
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001e;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    break;
                }
                case 3:
                {
                    break;
                }
            }
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10025;
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
                    break;
                }
                case 2:
                {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001e;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    break;
                }
                case 3:
                {
                    break;
                }
            }
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex2]) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10025;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            }
        }
        if (testBit(uvec4(0xb58593c9, 0x46be088b, 0x1ca665ca, 0xc0d80224), gl_SubgroupInvocationID)) {
            switch (gl_SubgroupInvocationID & 3) {
                case 0:
                {
                    break;
                }
                case 1:
                {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1003f;
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
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10045;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    break;
                }
            }
            for (int loopIdx0 = 0;
                     loopIdx0 < inputA.a[1];
                     loopIdx0++) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1004a;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            }
        } else {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1004e;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex3]) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10051;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            } else {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10051;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10057;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1005a;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
    }


void main()
[[subgroup_uniform_control_flow]]
{

    {
        int loopIdx0 = 0;
        do {
            {
                int loopIdx1 = 0;
                do {
                    loopIdx1++;
                    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10003;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    } else {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10003;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    }
                } while (loopIdx1 < inputA.a[2]);
            }
            if (subgroupElect()) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000b;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                if (testBit(uvec4(0x42962bce, 0xdc83561c, 0x804b9d28, 0xccd73ff2), gl_SubgroupInvocationID)) {
                    break;
                } else {
                    break;
                }
            }
            loopIdx0++;
        } while (true);
    }
    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10014;
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
    func0();



}
#version 450 core
#extension GL_KHR_shader_subgroup_ballot : enable
#extension GL_KHR_shader_subgroup_vote : enable
#extension GL_NV_shader_subgroup_partitioned : enable
#extension GL_EXT_subgroup_uniform_control_flow : enable
layout(local_size_x_id = 0, local_size_y_id = 1, local_size_z = 1) in;
layout(set=0, binding=2) coherent buffer OutputC { uint loc[]; } outputC;
layout(set=0, binding=1) coherent buffer OutputB { uvec4 b[]; } outputB;
layout(set=0, binding=0) coherent buffer InputA  { uint  a[]; } inputA;
layout(push_constant) uniform PC {
   // set to the real stride when writing out ballots, or zero when just counting
   int  invocationStride;
   // wildcard fields, for an example the dimensions of rendered area in the case of graphics shaders
   int  width;
   int  height;
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

    if (testBit(uvec4(0xb2fa1b23, 0xd67920f6, 0xe677f900, 0x50f0c25a), gl_SubgroupInvocationID)) {
        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10002;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10005;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            }
        } else {
            for (int loopIdx0 = 0;
                     loopIdx0 < inputA.a[1];
                     loopIdx0++) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000a;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            }
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000e;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
    }
    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10011;
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
    if (subgroupElect()) {
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10014;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
    }
    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10017;
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
    if (testBit(uvec4(0x7f5707d0, 0x5d879aae, 0x14a07613, 0x2cdb4025), gl_SubgroupInvocationID)) {
        switch (inputA.a[1]) {
            case 2:
            {
                switch (gl_SubgroupInvocationID & 3) {
                    case 0:
                    case 1:
                    {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001e;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        break;
                    }
                    case 2:
                    case 3:
                    {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10022;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        break;
                    }
                }
                break;
            }
            case 1:
            {
                for (int loopIdx0 = 0;;loopIdx0++,                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true)) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10029;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    if (subgroupElect()) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002c;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
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
                break;
            }
            case 3:
            {
                {
                    int loopIdx0 = 0;
                    do {
                        loopIdx0++;
                    } while (loopIdx0 < inputA.a[3]);
                }
                break;
            }
        }
        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex2]) {
            switch (gl_SubgroupInvocationID & 3) {
                case 0:
                {
                    break;
                }
                case 1:
                {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10044;
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
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1004c;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        } else {
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex3]) {
            }
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10052;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
    }
    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10055;
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
        {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10002;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            break;
        }
        case 1:
        {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10006;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            {
                int loopIdx0 = 0;
                do {
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
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000d;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                            break;
                        }
                    }
                    if (subgroupElect()) {
                        break;
                    }
                    {
                        int loopIdx1 = 0;
                        do {
                            if (subgroupElect()) {
                                break;
                            }
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10018;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                            loopIdx1++;
                        } while (true);
                    }
                    break;
                    loopIdx0++;
                } while (true);
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001d;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            break;
        }
        case 2:
        {
            if (testBit(uvec4(0xdad44150, 0xcc9c23ad, 0x98038084, 0x4acdfcad), gl_SubgroupInvocationID)) {
                if (inputA.a[1] == 1) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10023;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
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
                        break;
                    }
                }
            }
            break;
        }
        case 3:
        {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10031;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            for (int loopIdx0 = 0;;loopIdx0++,            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true)) {
                if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10035;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                } else {
                }
                break;
                if (subgroupElect()) {
                    break;
                }
                if (gl_SubgroupInvocationID == loopIdx0) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1003e;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                } else {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10041;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10044;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                switch (gl_SubgroupInvocationID & 3) {
                    case 0:
                    {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10048;
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
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10052;
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

    if (inputA.a[1] == 1) {
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10001;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10004;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        } else {
            switch (inputA.a[4]) {
                case 5:
                {
                    break;
                }
                case 4:
                {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000b;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    break;
                }
                case 6:
                {
                    break;
                }
            }
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10012;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            }
        }
        for (int loopIdx0 = 0;
                 loopIdx0 < gl_SubgroupInvocationID + 1;
                 loopIdx0++) {
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex2]) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10018;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            }
        }
    } else {
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001d;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        if (inputA.a[1] == 1) {
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex3]) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10021;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            }
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10025;
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
             loopIdx0 < inputA.a[5];
             loopIdx0++) {
        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
            if (testBit(uvec4(0xf0153983, 0x5659d60c, 0x9176f58, 0xc4561528), gl_SubgroupInvocationID)) {
                break;
                if (gl_SubgroupInvocationID == loopIdx0) {
                }
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10007;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            if (inputA.a[0] == 0) {
                switch (gl_SubgroupInvocationID & 3) {
                    case 0:
                    {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000c;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        break;
                    }
                    case 1:
                    {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10010;
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
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10018;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                for (int loopIdx1 = 0;;loopIdx1++,                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true)) {
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
            } else {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10024;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                if (gl_SubgroupInvocationID == loopIdx0) {
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10028;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                {
                    int loopIdx1 = 0;
                    do {
                        loopIdx1++;
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002b;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    } while (loopIdx1 < inputA.a[5]);
                }
            }
        }
        break;
    }
    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10032;
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
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex2]) {
                for (int loopIdx0 = 0;;loopIdx0++,                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true)) {
                    if (subgroupElect()) {
                        break;
                    }
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000a;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                {
                    int loopIdx0 = 0;
                    do {
                        loopIdx0++;
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000d;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    } while (loopIdx0 < inputA.a[2]);
                }
            }
            if (inputA.a[0] == 0) {
                {
                    int loopIdx0 = 0;
                    do {
                        if (subgroupElect()) {
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10014;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                            break;
                        }
                        loopIdx0++;
                    } while (true);
                }
                if (subgroupElect()) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001a;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
            }
        } else {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001f;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            for (int loopIdx0 = 0;
                     loopIdx0 < inputA.a[3];
                     loopIdx0++) {
                if (testBit(uvec4(0x99c3d736, 0x34d20d27, 0x16dcf3a0, 0xb002d6a4), gl_SubgroupInvocationID)) {
                }
                if (testBit(uvec4(0x99c3d736, 0x34d20d27, 0x16dcf3a0, 0xb002d6a4), gl_SubgroupInvocationID)) {
                }
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10027;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            for (int loopIdx0 = 0;
                     loopIdx0 < inputA.a[2];
                     loopIdx0++) {
                if (gl_SubgroupInvocationID == loopIdx0) {
                }
                if (gl_SubgroupInvocationID == loopIdx0) {
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002e;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            }
        }
    } else {
        if (inputA.a[0] == 0) {
            switch (inputA.a[1]) {
                case 2:
                {
                    {
                        int loopIdx0 = 0;
                        do {
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10037;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                            if (subgroupElect()) {
                                outputC.loc[gl_LocalInvocationIndex]++;
                                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1003a;
                                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                                break;
                            }
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1003e;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                            loopIdx0++;
                        } while (true);
                    }
                    break;
                }
                case 1:
                {
                    {
                        int loopIdx0 = 0;
                        do {
                            loopIdx0++;
                        } while (loopIdx0 < inputA.a[1]);
                    }
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
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1004c;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
    }
    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1004f;
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

    if (testBit(uvec4(0x42dcad6e, 0x9471480d, 0xffa3e60d, 0x1147d7a7), gl_SubgroupInvocationID)) {
        if (subgroupElect()) {
            if (subgroupElect()) {
                for (int loopIdx0 = 0;
                         loopIdx0 < inputA.a[2];
                         loopIdx0++) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10004;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
            }
            {
                int loopIdx0 = 0;
                do {
                    loopIdx0++;
                    for (int loopIdx1 = 0;;loopIdx1++,                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true)) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000a;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        if (subgroupElect()) {
                            break;
                        }
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000f;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    }
                    break;
                } while (loopIdx0 < inputA.a[1]);
            }
        }
        if (subgroupElect()) {
            for (int loopIdx0 = 0;
                     loopIdx0 < gl_SubgroupInvocationID + 1;
                     loopIdx0++) {
                if (subgroupElect()) {
                }
                for (int loopIdx1 = 0;
                         loopIdx1 < inputA.a[1];
                         loopIdx1++) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001a;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
            }
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
                if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10020;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                } else {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10023;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
                if (gl_LocalInvocationIndex >= inputA.a[cmpIndex2]) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10027;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                } else {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002a;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
            }
        }
    } else {
        if (subgroupElect()) {
            if (subgroupElect()) {
                for (int loopIdx0 = 0;
                         loopIdx0 < inputA.a[2];
                         loopIdx0++) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10004;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
            }
            {
                int loopIdx0 = 0;
                do {
                    loopIdx0++;
                    for (int loopIdx1 = 0;;loopIdx1++,                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true)) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000a;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        if (subgroupElect()) {
                            break;
                        }
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000f;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    }
                    break;
                } while (loopIdx0 < inputA.a[1]);
            }
        }
        if (subgroupElect()) {
            for (int loopIdx0 = 0;
                     loopIdx0 < gl_SubgroupInvocationID + 1;
                     loopIdx0++) {
                if (subgroupElect()) {
                }
                for (int loopIdx1 = 0;
                         loopIdx1 < inputA.a[1];
                         loopIdx1++) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001a;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
            }
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex3]) {
                if (gl_LocalInvocationIndex >= inputA.a[cmpIndex4]) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10020;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                } else {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10023;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
                if (gl_LocalInvocationIndex >= inputA.a[cmpIndex5]) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10027;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                } else {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002a;
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
layout(constant_id = 14) const uint cmpIndex4 = 0u;


void main()
[[subgroup_uniform_control_flow]]
{

    if (testBit(uvec4(0x4f5bedce, 0xff3891ce, 0xfc0c4844, 0x7aa4e5bb), gl_SubgroupInvocationID)) {
        for (int loopIdx0 = 0;
                 loopIdx0 < inputA.a[5];
                 loopIdx0++) {
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10003;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                continue;
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10006;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            } else {
                if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000a;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000d;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                for (int loopIdx1 = 0;
                         loopIdx1 < gl_SubgroupInvocationID + 1;
                         loopIdx1++) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10010;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10013;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            }
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex2]) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10017;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                {
                    int loopIdx1 = 0;
                    do {
                        loopIdx1++;
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001a;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    } while (loopIdx1 < inputA.a[1]);
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001d;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                {
                    int loopIdx1 = 0;
                    do {
                        loopIdx1++;
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10020;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    } while (loopIdx1 < inputA.a[5]);
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10023;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            } else {
                {
                    int loopIdx1 = 0;
                    do {
                        loopIdx1++;
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10027;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    } while (loopIdx1 < inputA.a[2]);
                }
                break;
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002b;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            }
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002f;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        for (int loopIdx0 = 0;
                 loopIdx0 < inputA.a[5];
                 loopIdx0++) {
            {
                int loopIdx1 = 0;
                do {
                    loopIdx1++;
                    continue;
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10034;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex3]) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10037;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    } else {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1003a;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    }
                } while (loopIdx1 < inputA.a[3]);
            }
            {
                int loopIdx1 = 0;
                do {
                    if (testBit(uvec4(0x29bdb8bb, 0x5b69ed67, 0x3649f53f, 0xa3b66af1), gl_SubgroupInvocationID)) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10040;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    }
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10043;
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
                    if (subgroupElect()) {
                        break;
                    }
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10050;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    if (subgroupElect()) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10053;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    }
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10056;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex4]) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10059;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
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
layout(constant_id = 12) const uint cmpIndex2 = 0u;
layout(constant_id = 13) const uint cmpIndex3 = 0u;
layout(constant_id = 14) const uint cmpIndex4 = 0u;


void main()
[[subgroup_uniform_control_flow]]
{

    {
        int loopIdx0 = 0;
        do {
            {
                int loopIdx1 = 0;
                do {
                    loopIdx1++;
                    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10003;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        if (testBit(uvec4(0x336819ca, 0xaaeacc85, 0x1c064f2a, 0x33a1f4a1), gl_SubgroupInvocationID)) {
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10006;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        }
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10009;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        {
                            int loopIdx2 = 0;
                            do {
                                loopIdx2++;
                                outputC.loc[gl_LocalInvocationIndex]++;
                                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000c;
                                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                            } while (loopIdx2 < inputA.a[2]);
                        }
                    }
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10010;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    switch (gl_SubgroupInvocationID & 3) {
                        case 0:
                        {
                            if (inputA.a[1] == 1) {
                            } else {
                            }
                            break;
                        }
                        case 1:
                        {
                            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
                            } else {
                            }
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001c;
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
                            {
                                int loopIdx2 = 0;
                                do {
                                    loopIdx2++;
                                    outputC.loc[gl_LocalInvocationIndex]++;
                                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10024;
                                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                                } while (loopIdx2 < inputA.a[5]);
                            }
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10027;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                            break;
                        }
                    }
                } while (loopIdx1 < inputA.a[2]);
            }
            if (subgroupElect()) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002d;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                break;
            }
            {
                int loopIdx1 = 0;
                do {
                    loopIdx1++;
                    switch (loopIdx1) {
                        case 1: {
                            if (gl_SubgroupInvocationID == loopIdx1) {
                                outputC.loc[gl_LocalInvocationIndex]++;
                                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10035;
                                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                            } else {
                                outputC.loc[gl_LocalInvocationIndex]++;
                                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10038;
                                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                            }
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1003b;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                            break;
                        }
                        case 2: {
                            if (gl_SubgroupInvocationID == loopIdx1) {
                                outputC.loc[gl_LocalInvocationIndex]++;
                                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10040;
                                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                            }
                            break;
                        }
                        default: {
                            for (int loopIdx2 = 0;
                                     loopIdx2 < gl_SubgroupInvocationID + 1;
                                     loopIdx2++) {
                                outputC.loc[gl_LocalInvocationIndex]++;
                                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10046;
                                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                            }
                            break;
                        }
                    }
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1004b;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    if (inputA.a[3] == 3) {
                        if (gl_SubgroupInvocationID == loopIdx1) {
                        } else {
                        }
                        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex2]) {
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10052;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        } else {
                        }
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10056;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    } else {
                        if (testBit(uvec4(0x42962bce, 0xdc83561c, 0x804b9d28, 0xccd73ff2), gl_SubgroupInvocationID)) {
                        }
                        for (int loopIdx2 = 0;
                                 loopIdx2 < inputA.a[1];
                                 loopIdx2++) {
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1005c;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        }
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1005f;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    }
                    while (!subgroupElect()) {}
                } while (loopIdx1 < inputA.a[2]);
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10064;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            if (gl_SubgroupInvocationID == loopIdx0) {
                switch (inputA.a[0]) {
                    case 1:
                    {
                        for (int loopIdx1 = 0;
                                 loopIdx1 < inputA.a[5];
                                 loopIdx1++) {
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1006a;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        }
                        break;
                    }
                    case 0:
                    {
                        if (inputA.a[3] == 3) {
                        }
                        break;
                        break;
                    }
                    case 2:
                    {
                        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex3]) {
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10075;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        }
                        break;
                    }
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1007a;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                if (testBit(uvec4(0x5d5d909f, 0xc0cb6625, 0xf80726dc, 0x3b59be1c), gl_SubgroupInvocationID)) {
                    if (testBit(uvec4(0x42962bce, 0xdc83561c, 0x804b9d28, 0xccd73ff2), gl_SubgroupInvocationID)) {
                    }
                } else {
                    if (testBit(uvec4(0x42962bce, 0xdc83561c, 0x804b9d28, 0xccd73ff2), gl_SubgroupInvocationID)) {
                    }
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10083;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            } else {
                switch (loopIdx0) {
                    case 1: {
                        {
                            int loopIdx1 = 0;
                            do {
                                loopIdx1++;
                            } while (loopIdx1 < inputA.a[4]);
                        }
                        break;
                    }
                    case 2: {
                        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex4]) {
                        } else {
                        }
                        break;
                    }
                    default: {
                        if (inputA.a[3] == 3) {
                        }
                        break;
                    }
                }
                {
                    int loopIdx1 = 0;
                    do {
                        loopIdx1++;
                        if (inputA.a[2] == 2) {
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10097;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        } else {
                        }
                        for (int loopIdx2 = 0;
                                 loopIdx2 < inputA.a[5];
                                 loopIdx2++) {
                        }
                    } while (loopIdx1 < inputA.a[3]);
                }
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1009f;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
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

    if (testBit(uvec4(0xb2fa1b23, 0xd67920f6, 0xe677f900, 0x50f0c25a), gl_SubgroupInvocationID)) {
        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10002;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
                if (subgroupElect()) {
                }
                {
                    int loopIdx0 = 0;
                    do {
                        if (subgroupElect()) {
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10009;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                            break;
                        }
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000d;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        loopIdx0++;
                    } while (true);
                }
            } else {
                if (subgroupElect()) {
                }
                {
                    int loopIdx0 = 0;
                    do {
                        if (subgroupElect()) {
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10009;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                            break;
                        }
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000d;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        loopIdx0++;
                    } while (true);
                }
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001d;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        } else {
            if (inputA.a[0] == 0) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10021;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                if (inputA.a[0] == 0) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10024;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
            } else {
                if (inputA.a[2] == 2) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10029;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                } else {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10029;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
                for (int loopIdx0 = 0;
                         loopIdx0 < inputA.a[3];
                         loopIdx0++) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10030;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10034;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        }
        for (int loopIdx0 = 0;
                 loopIdx0 < inputA.a[1];
                 loopIdx0++) {
            switch (gl_SubgroupInvocationID & 3) {
                case 0:
                {
                    if (testBit(uvec4(0xedd126dc, 0xdc84a6e2, 0x2f332044, 0x63902f01), gl_SubgroupInvocationID)) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1003b;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    }
                    break;
                }
                case 1:
                {
                    for (int loopIdx1 = 0;
                             loopIdx1 < gl_SubgroupInvocationID + 1;
                             loopIdx1++) {
                    }
                    break;
                }
                case 2:
                {
                    if (subgroupElect()) {
                    }
                    break;
                }
                case 3:
                {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10048;
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
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1004e;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                            break;
                        }
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


void main()
[[subgroup_uniform_control_flow]]
{

    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
    }
    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
        if (inputA.a[0] == 0) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10004;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            switch (gl_SubgroupInvocationID & 3) {
                case 0:
                {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10008;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex2]) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000b;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    } else {
                    }
                    break;
                }
                case 1:
                {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10011;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    break;
                }
                case 2:
                {
                    for (int loopIdx0 = 0;;loopIdx0++,                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true)) {
                        if (subgroupElect()) {
                            break;
                        }
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10019;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    }
                    break;
                }
                case 3:
                {
                    if (inputA.a[0] == 0) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001f;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    }
                    break;
                }
            }
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10025;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
    } else {
        if (inputA.a[3] == 3) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10004;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            switch (gl_SubgroupInvocationID & 3) {
                case 0:
                {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10008;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex3]) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000b;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    } else {
                    }
                    break;
                }
                case 1:
                {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10011;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    break;
                }
                case 2:
                {
                    for (int loopIdx0 = 0;;loopIdx0++,                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true)) {
                        if (subgroupElect()) {
                            break;
                        }
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10019;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    }
                    break;
                }
                case 3:
                {
                    if (inputA.a[2] == 2) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001f;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    }
                    break;
                }
            }
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10025;
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


void main()
[[subgroup_uniform_control_flow]]
{

    if (inputA.a[0] == 0) {
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10001;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10004;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        } else {
            switch (inputA.a[4]) {
                case 5:
                {
                    if (subgroupElect()) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000a;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    }
                    break;
                }
                case 4:
                {
                    break;
                }
                case 6:
                {
                    if (inputA.a[2] == 2) {
                    } else {
                    }
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10014;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    break;
                }
            }
            switch (inputA.a[0]) {
                case 1:
                {
                    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001b;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    }
                    break;
                }
                case 0:
                {
                    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex2]) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10021;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    }
                    {
                        int loopIdx0 = 0;
                        do {
                            loopIdx0++;
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10025;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        } while (loopIdx0 < inputA.a[4]);
                    }
                    break;
                }
                case 2:
                {
                    break;
                }
            }
        }
    } else {
        switch (gl_SubgroupInvocationID & 3) {
            case 0:
            case 1:
            {
                {
                    int loopIdx0 = 0;
                    do {
                        loopIdx0++;
                        for (int loopIdx1 = 0;
                                 loopIdx1 < inputA.a[1];
                                 loopIdx1++) {
                        }
                    } while (loopIdx0 < inputA.a[2]);
                }
                break;
            }
            case 2:
            case 3:
            {
                for (int loopIdx0 = 0;;loopIdx0++,                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true)) {
                    if (testBit(uvec4(0x598bd779, 0xdc94c4ec, 0x9bea62b5, 0xd7cae80b), gl_SubgroupInvocationID)) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10038;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    }
                    if (subgroupElect()) {
                    }
                    if (subgroupElect()) {
                        break;
                    }
                    break;
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


void main()
{

    for (int loopIdx0 = 0;
             loopIdx0 < inputA.a[5];
             loopIdx0++) {
        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10002;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        } else {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10002;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        }
        for (int loopIdx1 = 0;;loopIdx1++,        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect()) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10009;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            if (subgroupElect()) {
                break;
            }
        }
    }
    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
    }
    switch (inputA.a[4]) {
        case 5:
        {
            switch (gl_SubgroupInvocationID & 3) {
                case 0:
                case 1:
                {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10016;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
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
            break;
        }
        case 4:
        {
            {
                int loopIdx0 = 0;
                do {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10021;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    if (subgroupElect()) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10024;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                        break;
                    }
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10028;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    loopIdx0++;
                } while (true);
            }
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex2]) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002c;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            } else {
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10030;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            break;
        }
        case 6:
        {
            if (subgroupElect()) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10035;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            }
            break;
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


void main()
{

    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
        if (subgroupElect()) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10002;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        }
        for (int loopIdx0 = 0;
                 loopIdx0 < inputA.a[3];
                 loopIdx0++) {
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10007;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
    } else {
        if (subgroupElect()) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10002;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        }
        for (int loopIdx0 = 0;
                 loopIdx0 < inputA.a[3];
                 loopIdx0++) {
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10007;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
    }
    {
        int loopIdx0 = 0;
        do {
            if (inputA.a[1] == 1) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10015;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            } else {
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
            for (int loopIdx1 = 0;
                     loopIdx1 < gl_SubgroupInvocationID + 1;
                     loopIdx1++) {
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10022;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            if (subgroupElect()) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10025;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            }
            loopIdx0++;
        } while (true);
    }
    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10029;
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

    if (testBit(uvec4(0x42dcad6e, 0x9471480d, 0xffa3e60d, 0x1147d7a7), gl_SubgroupInvocationID)) {
        if (subgroupElect()) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10002;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        }
        for (int loopIdx0 = 0;
                 loopIdx0 < inputA.a[2];
                 loopIdx0++) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10006;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        }
    } else {
        if (testBit(uvec4(0xadba414a, 0xf7600dc, 0xd534f30e, 0x88c8e8db), gl_SubgroupInvocationID)) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000b;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        } else {
        }
        for (int loopIdx0 = 0;
                 loopIdx0 < gl_SubgroupInvocationID + 1;
                 loopIdx0++) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10010;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        }
    }
    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
        if (inputA.a[2] == 2) {
        } else {
        }
        {
            int loopIdx0 = 0;
            do {
                loopIdx0++;
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10019;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            } while (loopIdx0 < inputA.a[1]);
        }
    } else {
        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001e;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        } else {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10021;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
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


void main()
{

    switch (gl_SubgroupInvocationID & 3) {
        case 0:
        case 1:
        {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10002;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
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
            break;
        }
        case 2:
        case 3:
        {
            switch (gl_SubgroupInvocationID & 3) {
                case 0:
                case 1:
                {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10011;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    break;
                }
                case 2:
                case 3:
                {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10015;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    break;
                }
            }
            for (int loopIdx0 = 0;;loopIdx0++,            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect()) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001a;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                if (subgroupElect()) {
                    break;
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001f;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10022;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            break;
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


void main()
{

    if (testBit(uvec4(0x4f5bedce, 0xff3891ce, 0xfc0c4844, 0x7aa4e5bb), gl_SubgroupInvocationID)) {
        for (int loopIdx0 = 0;
                 loopIdx0 < inputA.a[5];
                 loopIdx0++) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10002;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10005;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
    }
    if (subgroupElect()) {
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
        {
            int loopIdx0 = 0;
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
                loopIdx0++;
            } while (true);
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


void main()
{

    {
        int loopIdx0 = 0;
        do {
            {
                int loopIdx1 = 0;
                do {
                    loopIdx1++;
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10002;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                } while (loopIdx1 < inputA.a[2]);
            }
            if (subgroupElect()) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10006;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                break;
            }
            switch (inputA.a[1]) {
                case 2:
                {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000c;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    break;
                }
                case 1:
                {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10010;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    break;
                }
                case 3:
                {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10014;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    break;
                }
            }
            if (testBit(uvec4(0x93a1d546, 0xe07426cb, 0x81c84aa9, 0xaf993f6f), gl_SubgroupInvocationID)) {
            } else {
            }
            loopIdx0++;
        } while (true);
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


void main()
{

    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10000;
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
    switch (inputA.a[3]) {
        case 4:
        {
            for (int loopIdx0 = 0;
                     loopIdx0 < gl_SubgroupInvocationID + 1;
                     loopIdx0++) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10005;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            }
            break;
        }
        case 3:
        {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000a;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            if (inputA.a[0] == 0) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000d;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            } else {
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10011;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            if (inputA.a[2] == 2) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10014;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            } else {
            }
            break;
        }
        case 5:
        {
            {
                int loopIdx0 = 0;
                do {
                    if (subgroupElect()) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001c;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                        if (testBit(uvec4(0xedd126dc, 0xdc84a6e2, 0x2f332044, 0x63902f01), gl_SubgroupInvocationID)) {
                            break;
                        } else {
                            break;
                        }
                    }
                    loopIdx0++;
                } while (true);
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

    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
    }
    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
        if (inputA.a[2] == 2) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10004;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        } else {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10004;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        }
    }
    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000b;
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
    if (testBit(uvec4(0x24209002, 0xa32c6f41, 0xbdeb4150, 0xeb453b5d), gl_SubgroupInvocationID)) {
        for (int loopIdx0 = 0;
                 loopIdx0 < inputA.a[1];
                 loopIdx0++) {
        }
        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex2]) {
        }
    }
    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex3]) {
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
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10018;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                break;
            }
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
layout(constant_id = 11) const uint cmpIndex1 = 0u;


void main()
{

    if (inputA.a[3] == 3) {
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10001;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
        } else {
        }
    } else {
        {
            int loopIdx0 = 0;
            do {
                if (subgroupElect()) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10009;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    break;
                }
                loopIdx0++;
            } while (true);
        }
        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
        }
    }
    switch (inputA.a[4]) {
        case 5:
        {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10013;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            break;
        }
        case 4:
        {
            if (inputA.a[0] == 0) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10018;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            }
            for (int loopIdx0 = 0;
                     loopIdx0 < gl_SubgroupInvocationID + 1;
                     loopIdx0++) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001c;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            }
            break;
        }
        case 6:
        {
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

    for (int loopIdx0 = 0;
             loopIdx0 < inputA.a[5];
             loopIdx0++) {
        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
            if (testBit(uvec4(0xf0153983, 0x5659d60c, 0x9176f58, 0xc4561528), gl_SubgroupInvocationID)) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10003;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            }
            if (inputA.a[0] == 0) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10007;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            } else {
            }
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000c;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        continue;
    }
    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10010;
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
    for (int loopIdx0 = 0;;loopIdx0++,    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect()) {
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10013;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        switch (loopIdx0) {
            case 1: {
                if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10018;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                } else {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10018;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001e;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                break;
            }
            case 2: {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10022;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                break;
            }
            default: {
                for (int loopIdx1 = 0;
                         loopIdx1 < gl_SubgroupInvocationID + 1;
                         loopIdx1++) {
                }
                break;
            }
        }
        if (subgroupElect()) {
            break;
        }
        if (gl_SubgroupInvocationID == loopIdx0) {
            if (inputA.a[1] == 1) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002f;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            } else {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10032;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10035;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            break;
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10039;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        for (int loopIdx1 = 0;
                 loopIdx1 < inputA.a[4];
                 loopIdx1++) {
            continue;
            for (int loopIdx2 = 0;
                     loopIdx2 < gl_SubgroupInvocationID + 1;
                     loopIdx2++) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1003e;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10041;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10044;
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
    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex2]) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10005;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            } else {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10008;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            }
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex3]) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000c;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            } else {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000c;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            }
        }
        switch (inputA.a[3]) {
            case 4:
            {
                break;
            }
            case 3:
            {
                if (gl_LocalInvocationIndex >= inputA.a[cmpIndex4]) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10018;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                } else {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10018;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001e;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                if (gl_LocalInvocationIndex >= inputA.a[cmpIndex5]) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10021;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                }
                break;
            }
            case 5:
            {
                if (testBit(uvec4(0x747b38eb, 0xdcabe30f, 0xb7e2334f, 0xfa3a7a50), gl_SubgroupInvocationID)) {
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10028;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                break;
            }
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002c;
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

    if (subgroupElect()) {
        {
            int loopIdx0 = 0;
            do {
                if (testBit(uvec4(0x12588461, 0xdcb33016, 0xd107e1bb, 0x9c19fa28), gl_SubgroupInvocationID)) {
                } else {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10004;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                }
                break;
                if (subgroupElect()) {
                    break;
                }
                if (inputA.a[2] == 2) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000c;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                } else {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000f;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                }
                if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10013;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                }
                loopIdx0++;
            } while (true);
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10017;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        switch (gl_SubgroupInvocationID & 3) {
            case 0:
            {
                if (subgroupElect()) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001c;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                }
                break;
            }
            case 1:
            {
                for (int loopIdx0 = 0;
                         loopIdx0 < gl_SubgroupInvocationID + 1;
                         loopIdx0++) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10022;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10025;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                break;
            }
            case 2:
            {
                if (testBit(uvec4(0xadba414a, 0xf7600dc, 0xd534f30e, 0x88c8e8db), gl_SubgroupInvocationID)) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002a;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002d;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                break;
            }
            case 3:
            {
                if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10032;
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


void main()
{

    if (testBit(uvec4(0x4f5bedce, 0xff3891ce, 0xfc0c4844, 0x7aa4e5bb), gl_SubgroupInvocationID)) {
        for (int loopIdx0 = 0;
                 loopIdx0 < inputA.a[5];
                 loopIdx0++) {
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10003;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10006;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        }
        if (testBit(uvec4(0x5724b049, 0xc78100ea, 0x94202959, 0xaf00e2b), gl_SubgroupInvocationID)) {
            if (testBit(uvec4(0x29bdb8bb, 0x5b69ed67, 0x3649f53f, 0xa3b66af1), gl_SubgroupInvocationID)) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000b;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000e;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            if (inputA.a[3] == 3) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10011;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            } else {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10011;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            }
        }
    } else {
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10019;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        {
            int loopIdx0 = 0;
            do {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001c;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                if (inputA.a[1] == 1) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001f;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10022;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                for (int loopIdx1 = 0;
                         loopIdx1 < inputA.a[5];
                         loopIdx1++) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10025;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                }
                if (subgroupElect()) {
                    break;
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002b;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                switch (gl_SubgroupInvocationID & 3) {
                    case 0:
                    {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002f;
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
                break;
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1003a;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                loopIdx0++;
            } while (true);
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1003d;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        if (subgroupElect()) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10040;
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
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10048;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    break;
                }
            }
        }
    }
    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1004e;
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

    for (int loopIdx0 = 0;
             loopIdx0 < gl_SubgroupInvocationID + 1;
             loopIdx0++) {
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10001;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        break;
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10004;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
    }
    for (int loopIdx0 = 0;;loopIdx0++,    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect()) {
        for (int loopIdx1 = 0;;loopIdx1++,        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect()) {
            if (subgroupElect()) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000a;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            }
            if (subgroupElect()) {
                if (testBit(uvec4(0x42962bce, 0xdc83561c, 0x804b9d28, 0xccd73ff2), gl_SubgroupInvocationID)) {
                    break;
                } else {
                    break;
                }
            }
            break;
            break;
        }
        break;
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10018;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        if (subgroupElect()) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001b;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            break;
        }
        for (int loopIdx1 = 0;
                 loopIdx1 < inputA.a[1];
                 loopIdx1++) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10020;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10023;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                while (!subgroupElect()) {}
            } else {
            }
            if (gl_SubgroupInvocationID == loopIdx1) {
            } else {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002a;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            }
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002e;
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

    if (testBit(uvec4(0xb2fa1b23, 0xd67920f6, 0xe677f900, 0x50f0c25a), gl_SubgroupInvocationID)) {
        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10002;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10005;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            }
        } else {
            for (int loopIdx0 = 0;
                     loopIdx0 < inputA.a[1];
                     loopIdx0++) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000a;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            }
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000e;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
    }
    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10011;
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
    if (subgroupElect()) {
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10014;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
    }
    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10017;
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
    if (testBit(uvec4(0x7f5707d0, 0x5d879aae, 0x14a07613, 0x2cdb4025), gl_SubgroupInvocationID)) {
        switch (inputA.a[1]) {
            case 2:
            {
                switch (gl_SubgroupInvocationID & 3) {
                    case 0:
                    case 1:
                    {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001e;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                        break;
                    }
                    case 2:
                    case 3:
                    {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10022;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                        break;
                    }
                }
                break;
            }
            case 1:
            {
                for (int loopIdx0 = 0;;loopIdx0++,                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect()) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10029;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    if (subgroupElect()) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002c;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
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
                break;
            }
            case 3:
            {
                {
                    int loopIdx0 = 0;
                    do {
                        loopIdx0++;
                    } while (loopIdx0 < inputA.a[3]);
                }
                break;
            }
        }
        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex2]) {
            switch (gl_SubgroupInvocationID & 3) {
                case 0:
                {
                    break;
                }
                case 1:
                {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10044;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
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
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1004c;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        } else {
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex3]) {
            }
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10052;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
    }
    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10055;
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
        {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10002;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            break;
        }
        case 1:
        {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10006;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            {
                int loopIdx0 = 0;
                do {
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
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000d;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                            break;
                        }
                    }
                    if (subgroupElect()) {
                        break;
                    }
                    {
                        int loopIdx1 = 0;
                        do {
                            if (subgroupElect()) {
                                break;
                            }
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10018;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                            loopIdx1++;
                        } while (true);
                    }
                    break;
                    loopIdx0++;
                } while (true);
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001d;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            break;
        }
        case 2:
        {
            if (testBit(uvec4(0xdad44150, 0xcc9c23ad, 0x98038084, 0x4acdfcad), gl_SubgroupInvocationID)) {
                if (inputA.a[1] == 1) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10023;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
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
                        break;
                    }
                }
            }
            break;
        }
        case 3:
        {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10031;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            for (int loopIdx0 = 0;;loopIdx0++,            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect()) {
                if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10035;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                } else {
                }
                break;
                if (subgroupElect()) {
                    break;
                }
                if (gl_SubgroupInvocationID == loopIdx0) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1003e;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                } else {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10041;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10044;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                switch (gl_SubgroupInvocationID & 3) {
                    case 0:
                    {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10048;
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
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10052;
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

    if (inputA.a[1] == 1) {
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10001;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10004;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        } else {
            switch (inputA.a[4]) {
                case 5:
                {
                    break;
                }
                case 4:
                {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000b;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    break;
                }
                case 6:
                {
                    break;
                }
            }
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10012;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            }
        }
        for (int loopIdx0 = 0;
                 loopIdx0 < gl_SubgroupInvocationID + 1;
                 loopIdx0++) {
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex2]) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10018;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            }
        }
    } else {
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001d;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        if (inputA.a[1] == 1) {
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex3]) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10021;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            }
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10025;
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
             loopIdx0 < inputA.a[5];
             loopIdx0++) {
        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
            if (testBit(uvec4(0xf0153983, 0x5659d60c, 0x9176f58, 0xc4561528), gl_SubgroupInvocationID)) {
                break;
                if (gl_SubgroupInvocationID == loopIdx0) {
                }
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10007;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            if (inputA.a[0] == 0) {
                switch (gl_SubgroupInvocationID & 3) {
                    case 0:
                    {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000c;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                        break;
                    }
                    case 1:
                    {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10010;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
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
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10018;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                for (int loopIdx1 = 0;;loopIdx1++,                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect()) {
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
            } else {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10024;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                if (gl_SubgroupInvocationID == loopIdx0) {
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10028;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                {
                    int loopIdx1 = 0;
                    do {
                        loopIdx1++;
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002b;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    } while (loopIdx1 < inputA.a[5]);
                }
            }
        }
        break;
    }
    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10032;
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
    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex2]) {
                for (int loopIdx0 = 0;;loopIdx0++,                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect()) {
                    if (subgroupElect()) {
                        break;
                    }
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000a;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                {
                    int loopIdx0 = 0;
                    do {
                        loopIdx0++;
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000d;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    } while (loopIdx0 < inputA.a[2]);
                }
            }
            if (inputA.a[0] == 0) {
                {
                    int loopIdx0 = 0;
                    do {
                        if (subgroupElect()) {
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10014;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                            break;
                        }
                        loopIdx0++;
                    } while (true);
                }
                if (subgroupElect()) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001a;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                }
            }
        } else {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001f;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            for (int loopIdx0 = 0;
                     loopIdx0 < inputA.a[3];
                     loopIdx0++) {
                if (testBit(uvec4(0x99c3d736, 0x34d20d27, 0x16dcf3a0, 0xb002d6a4), gl_SubgroupInvocationID)) {
                }
                if (testBit(uvec4(0x99c3d736, 0x34d20d27, 0x16dcf3a0, 0xb002d6a4), gl_SubgroupInvocationID)) {
                }
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10027;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            for (int loopIdx0 = 0;
                     loopIdx0 < inputA.a[2];
                     loopIdx0++) {
                if (gl_SubgroupInvocationID == loopIdx0) {
                }
                if (gl_SubgroupInvocationID == loopIdx0) {
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002e;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            }
        }
    } else {
        if (inputA.a[0] == 0) {
            switch (inputA.a[1]) {
                case 2:
                {
                    {
                        int loopIdx0 = 0;
                        do {
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10037;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                            if (subgroupElect()) {
                                outputC.loc[gl_LocalInvocationIndex]++;
                                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1003a;
                                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                                break;
                            }
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1003e;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                            loopIdx0++;
                        } while (true);
                    }
                    break;
                }
                case 1:
                {
                    {
                        int loopIdx0 = 0;
                        do {
                            loopIdx0++;
                        } while (loopIdx0 < inputA.a[1]);
                    }
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
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1004c;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
    }
    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1004f;
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

    if (testBit(uvec4(0x42dcad6e, 0x9471480d, 0xffa3e60d, 0x1147d7a7), gl_SubgroupInvocationID)) {
        if (subgroupElect()) {
            if (subgroupElect()) {
                for (int loopIdx0 = 0;
                         loopIdx0 < inputA.a[2];
                         loopIdx0++) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10004;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                }
            }
            {
                int loopIdx0 = 0;
                do {
                    loopIdx0++;
                    for (int loopIdx1 = 0;;loopIdx1++,                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect()) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000a;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                        if (subgroupElect()) {
                            break;
                        }
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000f;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    }
                    break;
                } while (loopIdx0 < inputA.a[1]);
            }
        }
        if (subgroupElect()) {
            for (int loopIdx0 = 0;
                     loopIdx0 < gl_SubgroupInvocationID + 1;
                     loopIdx0++) {
                if (subgroupElect()) {
                }
                for (int loopIdx1 = 0;
                         loopIdx1 < inputA.a[1];
                         loopIdx1++) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001a;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                }
            }
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
                if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10020;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                } else {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10023;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                }
                if (gl_LocalInvocationIndex >= inputA.a[cmpIndex2]) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10027;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                } else {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002a;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                }
            }
        }
    } else {
        if (subgroupElect()) {
            if (subgroupElect()) {
                for (int loopIdx0 = 0;
                         loopIdx0 < inputA.a[2];
                         loopIdx0++) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10004;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                }
            }
            {
                int loopIdx0 = 0;
                do {
                    loopIdx0++;
                    for (int loopIdx1 = 0;;loopIdx1++,                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect()) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000a;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                        if (subgroupElect()) {
                            break;
                        }
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000f;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    }
                    break;
                } while (loopIdx0 < inputA.a[1]);
            }
        }
        if (subgroupElect()) {
            for (int loopIdx0 = 0;
                     loopIdx0 < gl_SubgroupInvocationID + 1;
                     loopIdx0++) {
                if (subgroupElect()) {
                }
                for (int loopIdx1 = 0;
                         loopIdx1 < inputA.a[1];
                         loopIdx1++) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001a;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                }
            }
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex3]) {
                if (gl_LocalInvocationIndex >= inputA.a[cmpIndex4]) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10020;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                } else {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10023;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                }
                if (gl_LocalInvocationIndex >= inputA.a[cmpIndex5]) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10027;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                } else {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002a;
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
layout(constant_id = 14) const uint cmpIndex4 = 0u;


void main()
{

    if (testBit(uvec4(0x4f5bedce, 0xff3891ce, 0xfc0c4844, 0x7aa4e5bb), gl_SubgroupInvocationID)) {
        for (int loopIdx0 = 0;
                 loopIdx0 < inputA.a[5];
                 loopIdx0++) {
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10003;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                continue;
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10006;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            } else {
                if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000a;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000d;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                for (int loopIdx1 = 0;
                         loopIdx1 < gl_SubgroupInvocationID + 1;
                         loopIdx1++) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10010;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10013;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            }
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex2]) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10017;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                {
                    int loopIdx1 = 0;
                    do {
                        loopIdx1++;
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001a;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    } while (loopIdx1 < inputA.a[1]);
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001d;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                {
                    int loopIdx1 = 0;
                    do {
                        loopIdx1++;
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10020;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    } while (loopIdx1 < inputA.a[5]);
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10023;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            } else {
                {
                    int loopIdx1 = 0;
                    do {
                        loopIdx1++;
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10027;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    } while (loopIdx1 < inputA.a[2]);
                }
                break;
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002b;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            }
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002f;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        for (int loopIdx0 = 0;
                 loopIdx0 < inputA.a[5];
                 loopIdx0++) {
            {
                int loopIdx1 = 0;
                do {
                    loopIdx1++;
                    continue;
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10034;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex3]) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10037;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    } else {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1003a;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    }
                } while (loopIdx1 < inputA.a[3]);
            }
            {
                int loopIdx1 = 0;
                do {
                    if (testBit(uvec4(0x29bdb8bb, 0x5b69ed67, 0x3649f53f, 0xa3b66af1), gl_SubgroupInvocationID)) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10040;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    }
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10043;
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
                    if (subgroupElect()) {
                        break;
                    }
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10050;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    if (subgroupElect()) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10053;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    }
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10056;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex4]) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10059;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
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
layout(constant_id = 12) const uint cmpIndex2 = 0u;
layout(constant_id = 13) const uint cmpIndex3 = 0u;
layout(constant_id = 14) const uint cmpIndex4 = 0u;


void main()
{

    {
        int loopIdx0 = 0;
        do {
            {
                int loopIdx1 = 0;
                do {
                    loopIdx1++;
                    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10003;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                        if (testBit(uvec4(0x336819ca, 0xaaeacc85, 0x1c064f2a, 0x33a1f4a1), gl_SubgroupInvocationID)) {
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10006;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                        }
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10009;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                        {
                            int loopIdx2 = 0;
                            do {
                                loopIdx2++;
                                outputC.loc[gl_LocalInvocationIndex]++;
                                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000c;
                                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                            } while (loopIdx2 < inputA.a[2]);
                        }
                    }
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10010;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    switch (gl_SubgroupInvocationID & 3) {
                        case 0:
                        {
                            if (inputA.a[1] == 1) {
                            } else {
                            }
                            break;
                        }
                        case 1:
                        {
                            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
                            } else {
                            }
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001c;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                            break;
                        }
                        case 2:
                        {
                            break;
                            break;
                        }
                        case 3:
                        {
                            {
                                int loopIdx2 = 0;
                                do {
                                    loopIdx2++;
                                    outputC.loc[gl_LocalInvocationIndex]++;
                                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10024;
                                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                                } while (loopIdx2 < inputA.a[5]);
                            }
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10027;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                            break;
                        }
                    }
                } while (loopIdx1 < inputA.a[2]);
            }
            if (subgroupElect()) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002d;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                break;
            }
            {
                int loopIdx1 = 0;
                do {
                    loopIdx1++;
                    switch (loopIdx1) {
                        case 1: {
                            if (gl_SubgroupInvocationID == loopIdx1) {
                                outputC.loc[gl_LocalInvocationIndex]++;
                                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10035;
                                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                            } else {
                                outputC.loc[gl_LocalInvocationIndex]++;
                                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10038;
                                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                            }
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1003b;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                            break;
                        }
                        case 2: {
                            if (gl_SubgroupInvocationID == loopIdx1) {
                                outputC.loc[gl_LocalInvocationIndex]++;
                                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10040;
                                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                            }
                            break;
                        }
                        default: {
                            for (int loopIdx2 = 0;
                                     loopIdx2 < gl_SubgroupInvocationID + 1;
                                     loopIdx2++) {
                                outputC.loc[gl_LocalInvocationIndex]++;
                                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10046;
                                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                            }
                            break;
                        }
                    }
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1004b;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    if (inputA.a[3] == 3) {
                        if (gl_SubgroupInvocationID == loopIdx1) {
                        } else {
                        }
                        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex2]) {
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10052;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                        } else {
                        }
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10056;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    } else {
                        if (testBit(uvec4(0x42962bce, 0xdc83561c, 0x804b9d28, 0xccd73ff2), gl_SubgroupInvocationID)) {
                        }
                        for (int loopIdx2 = 0;
                                 loopIdx2 < inputA.a[1];
                                 loopIdx2++) {
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1005c;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                        }
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1005f;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    }
                    while (!subgroupElect()) {}
                } while (loopIdx1 < inputA.a[2]);
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10064;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            if (gl_SubgroupInvocationID == loopIdx0) {
                switch (inputA.a[0]) {
                    case 1:
                    {
                        for (int loopIdx1 = 0;
                                 loopIdx1 < inputA.a[5];
                                 loopIdx1++) {
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1006a;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                        }
                        break;
                    }
                    case 0:
                    {
                        if (inputA.a[3] == 3) {
                        }
                        break;
                        break;
                    }
                    case 2:
                    {
                        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex3]) {
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10075;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                        }
                        break;
                    }
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1007a;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                if (testBit(uvec4(0x5d5d909f, 0xc0cb6625, 0xf80726dc, 0x3b59be1c), gl_SubgroupInvocationID)) {
                    if (testBit(uvec4(0x42962bce, 0xdc83561c, 0x804b9d28, 0xccd73ff2), gl_SubgroupInvocationID)) {
                    }
                } else {
                    if (testBit(uvec4(0x42962bce, 0xdc83561c, 0x804b9d28, 0xccd73ff2), gl_SubgroupInvocationID)) {
                    }
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10083;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            } else {
                switch (loopIdx0) {
                    case 1: {
                        {
                            int loopIdx1 = 0;
                            do {
                                loopIdx1++;
                            } while (loopIdx1 < inputA.a[4]);
                        }
                        break;
                    }
                    case 2: {
                        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex4]) {
                        } else {
                        }
                        break;
                    }
                    default: {
                        if (inputA.a[3] == 3) {
                        }
                        break;
                    }
                }
                {
                    int loopIdx1 = 0;
                    do {
                        loopIdx1++;
                        if (inputA.a[2] == 2) {
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10097;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                        } else {
                        }
                        for (int loopIdx2 = 0;
                                 loopIdx2 < inputA.a[5];
                                 loopIdx2++) {
                        }
                    } while (loopIdx1 < inputA.a[3]);
                }
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1009f;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
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

    if (testBit(uvec4(0xb2fa1b23, 0xd67920f6, 0xe677f900, 0x50f0c25a), gl_SubgroupInvocationID)) {
        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10002;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
                if (subgroupElect()) {
                }
                {
                    int loopIdx0 = 0;
                    do {
                        if (subgroupElect()) {
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10009;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                            break;
                        }
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000d;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                        loopIdx0++;
                    } while (true);
                }
            } else {
                if (subgroupElect()) {
                }
                {
                    int loopIdx0 = 0;
                    do {
                        if (subgroupElect()) {
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10009;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                            break;
                        }
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000d;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                        loopIdx0++;
                    } while (true);
                }
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001d;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        } else {
            if (inputA.a[0] == 0) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10021;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                if (inputA.a[0] == 0) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10024;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                }
            } else {
                if (inputA.a[2] == 2) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10029;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                } else {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10029;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                }
                for (int loopIdx0 = 0;
                         loopIdx0 < inputA.a[3];
                         loopIdx0++) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10030;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                }
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10034;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        }
        for (int loopIdx0 = 0;
                 loopIdx0 < inputA.a[1];
                 loopIdx0++) {
            switch (gl_SubgroupInvocationID & 3) {
                case 0:
                {
                    if (testBit(uvec4(0xedd126dc, 0xdc84a6e2, 0x2f332044, 0x63902f01), gl_SubgroupInvocationID)) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1003b;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    }
                    break;
                }
                case 1:
                {
                    for (int loopIdx1 = 0;
                             loopIdx1 < gl_SubgroupInvocationID + 1;
                             loopIdx1++) {
                    }
                    break;
                }
                case 2:
                {
                    if (subgroupElect()) {
                    }
                    break;
                }
                case 3:
                {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10048;
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
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1004e;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                            break;
                        }
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


void main()
{

    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
    }
    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
        if (inputA.a[0] == 0) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10004;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            switch (gl_SubgroupInvocationID & 3) {
                case 0:
                {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10008;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex2]) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000b;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    } else {
                    }
                    break;
                }
                case 1:
                {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10011;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    break;
                }
                case 2:
                {
                    for (int loopIdx0 = 0;;loopIdx0++,                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect()) {
                        if (subgroupElect()) {
                            break;
                        }
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10019;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    }
                    break;
                }
                case 3:
                {
                    if (inputA.a[0] == 0) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001f;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    }
                    break;
                }
            }
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10025;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
    } else {
        if (inputA.a[3] == 3) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10004;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
            switch (gl_SubgroupInvocationID & 3) {
                case 0:
                {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10008;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex3]) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000b;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    } else {
                    }
                    break;
                }
                case 1:
                {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10011;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    break;
                }
                case 2:
                {
                    for (int loopIdx0 = 0;;loopIdx0++,                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect()) {
                        if (subgroupElect()) {
                            break;
                        }
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10019;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    }
                    break;
                }
                case 3:
                {
                    if (inputA.a[2] == 2) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001f;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    }
                    break;
                }
            }
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10025;
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


void main()
{

    if (inputA.a[0] == 0) {
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10001;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10004;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
        } else {
            switch (inputA.a[4]) {
                case 5:
                {
                    if (subgroupElect()) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000a;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    }
                    break;
                }
                case 4:
                {
                    break;
                }
                case 6:
                {
                    if (inputA.a[2] == 2) {
                    } else {
                    }
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10014;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    break;
                }
            }
            switch (inputA.a[0]) {
                case 1:
                {
                    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001b;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    }
                    break;
                }
                case 0:
                {
                    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex2]) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10021;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    }
                    {
                        int loopIdx0 = 0;
                        do {
                            loopIdx0++;
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10025;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                        } while (loopIdx0 < inputA.a[4]);
                    }
                    break;
                }
                case 2:
                {
                    break;
                }
            }
        }
    } else {
        switch (gl_SubgroupInvocationID & 3) {
            case 0:
            case 1:
            {
                {
                    int loopIdx0 = 0;
                    do {
                        loopIdx0++;
                        for (int loopIdx1 = 0;
                                 loopIdx1 < inputA.a[1];
                                 loopIdx1++) {
                        }
                    } while (loopIdx0 < inputA.a[2]);
                }
                break;
            }
            case 2:
            case 3:
            {
                for (int loopIdx0 = 0;;loopIdx0++,                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect()) {
                    if (testBit(uvec4(0x598bd779, 0xdc94c4ec, 0x9bea62b5, 0xd7cae80b), gl_SubgroupInvocationID)) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10038;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = elect();
                    }
                    if (subgroupElect()) {
                    }
                    if (subgroupElect()) {
                        break;
                    }
                    break;
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


void main()
{

    for (int loopIdx0 = 0;
             loopIdx0 < inputA.a[5];
             loopIdx0++) {
        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10002;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        } else {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10002;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        }
        for (int loopIdx1 = 0;;loopIdx1++,        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true)) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10009;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            if (subgroupElect()) {
                break;
            }
        }
    }
    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
    }
    switch (inputA.a[4]) {
        case 5:
        {
            switch (gl_SubgroupInvocationID & 3) {
                case 0:
                case 1:
                {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10016;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
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
            break;
        }
        case 4:
        {
            {
                int loopIdx0 = 0;
                do {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10021;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    if (subgroupElect()) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10024;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        break;
                    }
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10028;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    loopIdx0++;
                } while (true);
            }
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex2]) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002c;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            } else {
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10030;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            break;
        }
        case 6:
        {
            if (subgroupElect()) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10035;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            }
            break;
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


void main()
{

    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
        if (subgroupElect()) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10002;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        }
        for (int loopIdx0 = 0;
                 loopIdx0 < inputA.a[3];
                 loopIdx0++) {
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10007;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
    } else {
        if (subgroupElect()) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10002;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        }
        for (int loopIdx0 = 0;
                 loopIdx0 < inputA.a[3];
                 loopIdx0++) {
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10007;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
    }
    {
        int loopIdx0 = 0;
        do {
            if (inputA.a[1] == 1) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10015;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            } else {
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
            for (int loopIdx1 = 0;
                     loopIdx1 < gl_SubgroupInvocationID + 1;
                     loopIdx1++) {
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10022;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            if (subgroupElect()) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10025;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            }
            loopIdx0++;
        } while (true);
    }
    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10029;
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

    if (testBit(uvec4(0x42dcad6e, 0x9471480d, 0xffa3e60d, 0x1147d7a7), gl_SubgroupInvocationID)) {
        if (subgroupElect()) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10002;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        }
        for (int loopIdx0 = 0;
                 loopIdx0 < inputA.a[2];
                 loopIdx0++) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10006;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        }
    } else {
        if (testBit(uvec4(0xadba414a, 0xf7600dc, 0xd534f30e, 0x88c8e8db), gl_SubgroupInvocationID)) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000b;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        } else {
        }
        for (int loopIdx0 = 0;
                 loopIdx0 < gl_SubgroupInvocationID + 1;
                 loopIdx0++) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10010;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        }
    }
    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
        if (inputA.a[2] == 2) {
        } else {
        }
        {
            int loopIdx0 = 0;
            do {
                loopIdx0++;
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10019;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            } while (loopIdx0 < inputA.a[1]);
        }
    } else {
        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001e;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        } else {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10021;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
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


void main()
{

    switch (gl_SubgroupInvocationID & 3) {
        case 0:
        case 1:
        {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10002;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
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
            break;
        }
        case 2:
        case 3:
        {
            switch (gl_SubgroupInvocationID & 3) {
                case 0:
                case 1:
                {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10011;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    break;
                }
                case 2:
                case 3:
                {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10015;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    break;
                }
            }
            for (int loopIdx0 = 0;;loopIdx0++,            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true)) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001a;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                if (subgroupElect()) {
                    break;
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001f;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10022;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            break;
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


void main()
{

    if (testBit(uvec4(0x4f5bedce, 0xff3891ce, 0xfc0c4844, 0x7aa4e5bb), gl_SubgroupInvocationID)) {
        for (int loopIdx0 = 0;
                 loopIdx0 < inputA.a[5];
                 loopIdx0++) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10002;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10005;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
    }
    if (subgroupElect()) {
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
        {
            int loopIdx0 = 0;
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
                loopIdx0++;
            } while (true);
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


void main()
{

    {
        int loopIdx0 = 0;
        do {
            {
                int loopIdx1 = 0;
                do {
                    loopIdx1++;
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10002;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                } while (loopIdx1 < inputA.a[2]);
            }
            if (subgroupElect()) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10006;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                break;
            }
            switch (inputA.a[1]) {
                case 2:
                {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000c;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    break;
                }
                case 1:
                {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10010;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    break;
                }
                case 3:
                {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10014;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    break;
                }
            }
            if (testBit(uvec4(0x93a1d546, 0xe07426cb, 0x81c84aa9, 0xaf993f6f), gl_SubgroupInvocationID)) {
            } else {
            }
            loopIdx0++;
        } while (true);
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


void main()
{

    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10000;
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
    switch (inputA.a[3]) {
        case 4:
        {
            for (int loopIdx0 = 0;
                     loopIdx0 < gl_SubgroupInvocationID + 1;
                     loopIdx0++) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10005;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            }
            break;
        }
        case 3:
        {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000a;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            if (inputA.a[0] == 0) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000d;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            } else {
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10011;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            if (inputA.a[2] == 2) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10014;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            } else {
            }
            break;
        }
        case 5:
        {
            {
                int loopIdx0 = 0;
                do {
                    if (subgroupElect()) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001c;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        if (testBit(uvec4(0xedd126dc, 0xdc84a6e2, 0x2f332044, 0x63902f01), gl_SubgroupInvocationID)) {
                            break;
                        } else {
                            break;
                        }
                    }
                    loopIdx0++;
                } while (true);
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

    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
    }
    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
        if (inputA.a[2] == 2) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10004;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        } else {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10004;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        }
    }
    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000b;
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
    if (testBit(uvec4(0x24209002, 0xa32c6f41, 0xbdeb4150, 0xeb453b5d), gl_SubgroupInvocationID)) {
        for (int loopIdx0 = 0;
                 loopIdx0 < inputA.a[1];
                 loopIdx0++) {
        }
        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex2]) {
        }
    }
    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex3]) {
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
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10018;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                break;
            }
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
layout(constant_id = 11) const uint cmpIndex1 = 0u;


void main()
{

    if (inputA.a[3] == 3) {
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10001;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
        } else {
        }
    } else {
        {
            int loopIdx0 = 0;
            do {
                if (subgroupElect()) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10009;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    break;
                }
                loopIdx0++;
            } while (true);
        }
        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
        }
    }
    switch (inputA.a[4]) {
        case 5:
        {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10013;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            break;
        }
        case 4:
        {
            if (inputA.a[0] == 0) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10018;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            }
            for (int loopIdx0 = 0;
                     loopIdx0 < gl_SubgroupInvocationID + 1;
                     loopIdx0++) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001c;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            }
            break;
        }
        case 6:
        {
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

    for (int loopIdx0 = 0;
             loopIdx0 < inputA.a[5];
             loopIdx0++) {
        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
            if (testBit(uvec4(0xf0153983, 0x5659d60c, 0x9176f58, 0xc4561528), gl_SubgroupInvocationID)) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10003;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            }
            if (inputA.a[0] == 0) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10007;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            } else {
            }
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000c;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        continue;
    }
    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10010;
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
    for (int loopIdx0 = 0;;loopIdx0++,    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true)) {
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10013;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        switch (loopIdx0) {
            case 1: {
                if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10018;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                } else {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10018;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001e;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                break;
            }
            case 2: {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10022;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                break;
            }
            default: {
                for (int loopIdx1 = 0;
                         loopIdx1 < gl_SubgroupInvocationID + 1;
                         loopIdx1++) {
                }
                break;
            }
        }
        if (subgroupElect()) {
            break;
        }
        if (gl_SubgroupInvocationID == loopIdx0) {
            if (inputA.a[1] == 1) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002f;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            } else {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10032;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10035;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            break;
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10039;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        for (int loopIdx1 = 0;
                 loopIdx1 < inputA.a[4];
                 loopIdx1++) {
            continue;
            for (int loopIdx2 = 0;
                     loopIdx2 < gl_SubgroupInvocationID + 1;
                     loopIdx2++) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1003e;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10041;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10044;
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
    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex2]) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10005;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            } else {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10008;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            }
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex3]) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000c;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            } else {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000c;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            }
        }
        switch (inputA.a[3]) {
            case 4:
            {
                break;
            }
            case 3:
            {
                if (gl_LocalInvocationIndex >= inputA.a[cmpIndex4]) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10018;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                } else {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10018;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001e;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                if (gl_LocalInvocationIndex >= inputA.a[cmpIndex5]) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10021;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
                break;
            }
            case 5:
            {
                if (testBit(uvec4(0x747b38eb, 0xdcabe30f, 0xb7e2334f, 0xfa3a7a50), gl_SubgroupInvocationID)) {
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10028;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                break;
            }
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002c;
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

    if (subgroupElect()) {
        {
            int loopIdx0 = 0;
            do {
                if (testBit(uvec4(0x12588461, 0xdcb33016, 0xd107e1bb, 0x9c19fa28), gl_SubgroupInvocationID)) {
                } else {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10004;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
                break;
                if (subgroupElect()) {
                    break;
                }
                if (inputA.a[2] == 2) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000c;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                } else {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000f;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
                if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10013;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
                loopIdx0++;
            } while (true);
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10017;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        switch (gl_SubgroupInvocationID & 3) {
            case 0:
            {
                if (subgroupElect()) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001c;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
                break;
            }
            case 1:
            {
                for (int loopIdx0 = 0;
                         loopIdx0 < gl_SubgroupInvocationID + 1;
                         loopIdx0++) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10022;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10025;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                break;
            }
            case 2:
            {
                if (testBit(uvec4(0xadba414a, 0xf7600dc, 0xd534f30e, 0x88c8e8db), gl_SubgroupInvocationID)) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002a;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002d;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                break;
            }
            case 3:
            {
                if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10032;
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


void main()
{

    if (testBit(uvec4(0x4f5bedce, 0xff3891ce, 0xfc0c4844, 0x7aa4e5bb), gl_SubgroupInvocationID)) {
        for (int loopIdx0 = 0;
                 loopIdx0 < inputA.a[5];
                 loopIdx0++) {
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10003;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10006;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        }
        if (testBit(uvec4(0x5724b049, 0xc78100ea, 0x94202959, 0xaf00e2b), gl_SubgroupInvocationID)) {
            if (testBit(uvec4(0x29bdb8bb, 0x5b69ed67, 0x3649f53f, 0xa3b66af1), gl_SubgroupInvocationID)) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000b;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000e;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            if (inputA.a[3] == 3) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10011;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            } else {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10011;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            }
        }
    } else {
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10019;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        {
            int loopIdx0 = 0;
            do {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001c;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                if (inputA.a[1] == 1) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001f;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10022;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                for (int loopIdx1 = 0;
                         loopIdx1 < inputA.a[5];
                         loopIdx1++) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10025;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
                if (subgroupElect()) {
                    break;
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002b;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                switch (gl_SubgroupInvocationID & 3) {
                    case 0:
                    {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002f;
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
                break;
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1003a;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                loopIdx0++;
            } while (true);
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1003d;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        if (subgroupElect()) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10040;
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
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10048;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    break;
                }
            }
        }
    }
    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1004e;
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

    for (int loopIdx0 = 0;
             loopIdx0 < gl_SubgroupInvocationID + 1;
             loopIdx0++) {
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10001;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        break;
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10004;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
    }
    for (int loopIdx0 = 0;;loopIdx0++,    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true)) {
        for (int loopIdx1 = 0;;loopIdx1++,        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true)) {
            if (subgroupElect()) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000a;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            }
            if (subgroupElect()) {
                if (testBit(uvec4(0x42962bce, 0xdc83561c, 0x804b9d28, 0xccd73ff2), gl_SubgroupInvocationID)) {
                    break;
                } else {
                    break;
                }
            }
            break;
            break;
        }
        break;
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10018;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        if (subgroupElect()) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001b;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            break;
        }
        for (int loopIdx1 = 0;
                 loopIdx1 < inputA.a[1];
                 loopIdx1++) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10020;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10023;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                while (!subgroupElect()) {}
            } else {
            }
            if (gl_SubgroupInvocationID == loopIdx1) {
            } else {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002a;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            }
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002e;
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

    if (testBit(uvec4(0xb2fa1b23, 0xd67920f6, 0xe677f900, 0x50f0c25a), gl_SubgroupInvocationID)) {
        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10002;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10005;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            }
        } else {
            for (int loopIdx0 = 0;
                     loopIdx0 < inputA.a[1];
                     loopIdx0++) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000a;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            }
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000e;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
    }
    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10011;
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
    if (subgroupElect()) {
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10014;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
    }
    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10017;
    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
    if (testBit(uvec4(0x7f5707d0, 0x5d879aae, 0x14a07613, 0x2cdb4025), gl_SubgroupInvocationID)) {
        switch (inputA.a[1]) {
            case 2:
            {
                switch (gl_SubgroupInvocationID & 3) {
                    case 0:
                    case 1:
                    {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001e;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        break;
                    }
                    case 2:
                    case 3:
                    {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10022;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        break;
                    }
                }
                break;
            }
            case 1:
            {
                for (int loopIdx0 = 0;;loopIdx0++,                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true)) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10029;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    if (subgroupElect()) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002c;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
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
                break;
            }
            case 3:
            {
                {
                    int loopIdx0 = 0;
                    do {
                        loopIdx0++;
                    } while (loopIdx0 < inputA.a[3]);
                }
                break;
            }
        }
        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex2]) {
            switch (gl_SubgroupInvocationID & 3) {
                case 0:
                {
                    break;
                }
                case 1:
                {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10044;
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
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1004c;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        } else {
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex3]) {
            }
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10052;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
    }
    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10055;
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
        {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10002;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            break;
        }
        case 1:
        {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10006;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            {
                int loopIdx0 = 0;
                do {
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
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000d;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                            break;
                        }
                    }
                    if (subgroupElect()) {
                        break;
                    }
                    {
                        int loopIdx1 = 0;
                        do {
                            if (subgroupElect()) {
                                break;
                            }
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10018;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                            loopIdx1++;
                        } while (true);
                    }
                    break;
                    loopIdx0++;
                } while (true);
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001d;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            break;
        }
        case 2:
        {
            if (testBit(uvec4(0xdad44150, 0xcc9c23ad, 0x98038084, 0x4acdfcad), gl_SubgroupInvocationID)) {
                if (inputA.a[1] == 1) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10023;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
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
                        break;
                    }
                }
            }
            break;
        }
        case 3:
        {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10031;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            for (int loopIdx0 = 0;;loopIdx0++,            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true)) {
                if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10035;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                } else {
                }
                break;
                if (subgroupElect()) {
                    break;
                }
                if (gl_SubgroupInvocationID == loopIdx0) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1003e;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                } else {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10041;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10044;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                switch (gl_SubgroupInvocationID & 3) {
                    case 0:
                    {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10048;
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
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10052;
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

    if (inputA.a[1] == 1) {
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10001;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10004;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        } else {
            switch (inputA.a[4]) {
                case 5:
                {
                    break;
                }
                case 4:
                {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000b;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    break;
                }
                case 6:
                {
                    break;
                }
            }
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10012;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            }
        }
        for (int loopIdx0 = 0;
                 loopIdx0 < gl_SubgroupInvocationID + 1;
                 loopIdx0++) {
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex2]) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10018;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            }
        }
    } else {
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001d;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        if (inputA.a[1] == 1) {
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex3]) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10021;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            }
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10025;
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
             loopIdx0 < inputA.a[5];
             loopIdx0++) {
        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
            if (testBit(uvec4(0xf0153983, 0x5659d60c, 0x9176f58, 0xc4561528), gl_SubgroupInvocationID)) {
                break;
                if (gl_SubgroupInvocationID == loopIdx0) {
                }
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10007;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            if (inputA.a[0] == 0) {
                switch (gl_SubgroupInvocationID & 3) {
                    case 0:
                    {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000c;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        break;
                    }
                    case 1:
                    {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10010;
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
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10018;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                for (int loopIdx1 = 0;;loopIdx1++,                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true)) {
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
            } else {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10024;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                if (gl_SubgroupInvocationID == loopIdx0) {
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10028;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                {
                    int loopIdx1 = 0;
                    do {
                        loopIdx1++;
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002b;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    } while (loopIdx1 < inputA.a[5]);
                }
            }
        }
        break;
    }
    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10032;
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
    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex2]) {
                for (int loopIdx0 = 0;;loopIdx0++,                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true)) {
                    if (subgroupElect()) {
                        break;
                    }
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000a;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                {
                    int loopIdx0 = 0;
                    do {
                        loopIdx0++;
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000d;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    } while (loopIdx0 < inputA.a[2]);
                }
            }
            if (inputA.a[0] == 0) {
                {
                    int loopIdx0 = 0;
                    do {
                        if (subgroupElect()) {
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10014;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                            break;
                        }
                        loopIdx0++;
                    } while (true);
                }
                if (subgroupElect()) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001a;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
            }
        } else {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001f;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            for (int loopIdx0 = 0;
                     loopIdx0 < inputA.a[3];
                     loopIdx0++) {
                if (testBit(uvec4(0x99c3d736, 0x34d20d27, 0x16dcf3a0, 0xb002d6a4), gl_SubgroupInvocationID)) {
                }
                if (testBit(uvec4(0x99c3d736, 0x34d20d27, 0x16dcf3a0, 0xb002d6a4), gl_SubgroupInvocationID)) {
                }
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10027;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            for (int loopIdx0 = 0;
                     loopIdx0 < inputA.a[2];
                     loopIdx0++) {
                if (gl_SubgroupInvocationID == loopIdx0) {
                }
                if (gl_SubgroupInvocationID == loopIdx0) {
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002e;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            }
        }
    } else {
        if (inputA.a[0] == 0) {
            switch (inputA.a[1]) {
                case 2:
                {
                    {
                        int loopIdx0 = 0;
                        do {
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10037;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                            if (subgroupElect()) {
                                outputC.loc[gl_LocalInvocationIndex]++;
                                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1003a;
                                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                                break;
                            }
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1003e;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                            loopIdx0++;
                        } while (true);
                    }
                    break;
                }
                case 1:
                {
                    {
                        int loopIdx0 = 0;
                        do {
                            loopIdx0++;
                        } while (loopIdx0 < inputA.a[1]);
                    }
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
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1004c;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
    }
    outputC.loc[gl_LocalInvocationIndex]++;
    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1004f;
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

    if (testBit(uvec4(0x42dcad6e, 0x9471480d, 0xffa3e60d, 0x1147d7a7), gl_SubgroupInvocationID)) {
        if (subgroupElect()) {
            if (subgroupElect()) {
                for (int loopIdx0 = 0;
                         loopIdx0 < inputA.a[2];
                         loopIdx0++) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10004;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
            }
            {
                int loopIdx0 = 0;
                do {
                    loopIdx0++;
                    for (int loopIdx1 = 0;;loopIdx1++,                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true)) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000a;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        if (subgroupElect()) {
                            break;
                        }
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000f;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    }
                    break;
                } while (loopIdx0 < inputA.a[1]);
            }
        }
        if (subgroupElect()) {
            for (int loopIdx0 = 0;
                     loopIdx0 < gl_SubgroupInvocationID + 1;
                     loopIdx0++) {
                if (subgroupElect()) {
                }
                for (int loopIdx1 = 0;
                         loopIdx1 < inputA.a[1];
                         loopIdx1++) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001a;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
            }
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
                if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10020;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                } else {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10023;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
                if (gl_LocalInvocationIndex >= inputA.a[cmpIndex2]) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10027;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                } else {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002a;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
            }
        }
    } else {
        if (subgroupElect()) {
            if (subgroupElect()) {
                for (int loopIdx0 = 0;
                         loopIdx0 < inputA.a[2];
                         loopIdx0++) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10004;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
            }
            {
                int loopIdx0 = 0;
                do {
                    loopIdx0++;
                    for (int loopIdx1 = 0;;loopIdx1++,                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true)) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000a;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        if (subgroupElect()) {
                            break;
                        }
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000f;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    }
                    break;
                } while (loopIdx0 < inputA.a[1]);
            }
        }
        if (subgroupElect()) {
            for (int loopIdx0 = 0;
                     loopIdx0 < gl_SubgroupInvocationID + 1;
                     loopIdx0++) {
                if (subgroupElect()) {
                }
                for (int loopIdx1 = 0;
                         loopIdx1 < inputA.a[1];
                         loopIdx1++) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001a;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
            }
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex3]) {
                if (gl_LocalInvocationIndex >= inputA.a[cmpIndex4]) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10020;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                } else {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10023;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
                if (gl_LocalInvocationIndex >= inputA.a[cmpIndex5]) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10027;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                } else {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002a;
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
layout(constant_id = 14) const uint cmpIndex4 = 0u;


void main()
{

    if (testBit(uvec4(0x4f5bedce, 0xff3891ce, 0xfc0c4844, 0x7aa4e5bb), gl_SubgroupInvocationID)) {
        for (int loopIdx0 = 0;
                 loopIdx0 < inputA.a[5];
                 loopIdx0++) {
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10003;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                continue;
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10006;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            } else {
                if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000a;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000d;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                for (int loopIdx1 = 0;
                         loopIdx1 < gl_SubgroupInvocationID + 1;
                         loopIdx1++) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10010;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10013;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            }
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex2]) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10017;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                {
                    int loopIdx1 = 0;
                    do {
                        loopIdx1++;
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001a;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    } while (loopIdx1 < inputA.a[1]);
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001d;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                {
                    int loopIdx1 = 0;
                    do {
                        loopIdx1++;
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10020;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    } while (loopIdx1 < inputA.a[5]);
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10023;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            } else {
                {
                    int loopIdx1 = 0;
                    do {
                        loopIdx1++;
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10027;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    } while (loopIdx1 < inputA.a[2]);
                }
                break;
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002b;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            }
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002f;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        for (int loopIdx0 = 0;
                 loopIdx0 < inputA.a[5];
                 loopIdx0++) {
            {
                int loopIdx1 = 0;
                do {
                    loopIdx1++;
                    continue;
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10034;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex3]) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10037;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    } else {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1003a;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    }
                } while (loopIdx1 < inputA.a[3]);
            }
            {
                int loopIdx1 = 0;
                do {
                    if (testBit(uvec4(0x29bdb8bb, 0x5b69ed67, 0x3649f53f, 0xa3b66af1), gl_SubgroupInvocationID)) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10040;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    }
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10043;
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
                    if (subgroupElect()) {
                        break;
                    }
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10050;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    if (subgroupElect()) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10053;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    }
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10056;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex4]) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10059;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
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
layout(constant_id = 12) const uint cmpIndex2 = 0u;
layout(constant_id = 13) const uint cmpIndex3 = 0u;
layout(constant_id = 14) const uint cmpIndex4 = 0u;


void main()
{

    {
        int loopIdx0 = 0;
        do {
            {
                int loopIdx1 = 0;
                do {
                    loopIdx1++;
                    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10003;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        if (testBit(uvec4(0x336819ca, 0xaaeacc85, 0x1c064f2a, 0x33a1f4a1), gl_SubgroupInvocationID)) {
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10006;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        }
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10009;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        {
                            int loopIdx2 = 0;
                            do {
                                loopIdx2++;
                                outputC.loc[gl_LocalInvocationIndex]++;
                                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000c;
                                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                            } while (loopIdx2 < inputA.a[2]);
                        }
                    }
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10010;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    switch (gl_SubgroupInvocationID & 3) {
                        case 0:
                        {
                            if (inputA.a[1] == 1) {
                            } else {
                            }
                            break;
                        }
                        case 1:
                        {
                            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
                            } else {
                            }
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001c;
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
                            {
                                int loopIdx2 = 0;
                                do {
                                    loopIdx2++;
                                    outputC.loc[gl_LocalInvocationIndex]++;
                                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10024;
                                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                                } while (loopIdx2 < inputA.a[5]);
                            }
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10027;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                            break;
                        }
                    }
                } while (loopIdx1 < inputA.a[2]);
            }
            if (subgroupElect()) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1002d;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                break;
            }
            {
                int loopIdx1 = 0;
                do {
                    loopIdx1++;
                    switch (loopIdx1) {
                        case 1: {
                            if (gl_SubgroupInvocationID == loopIdx1) {
                                outputC.loc[gl_LocalInvocationIndex]++;
                                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10035;
                                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                            } else {
                                outputC.loc[gl_LocalInvocationIndex]++;
                                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10038;
                                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                            }
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1003b;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                            break;
                        }
                        case 2: {
                            if (gl_SubgroupInvocationID == loopIdx1) {
                                outputC.loc[gl_LocalInvocationIndex]++;
                                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10040;
                                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                            }
                            break;
                        }
                        default: {
                            for (int loopIdx2 = 0;
                                     loopIdx2 < gl_SubgroupInvocationID + 1;
                                     loopIdx2++) {
                                outputC.loc[gl_LocalInvocationIndex]++;
                                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10046;
                                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                            }
                            break;
                        }
                    }
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1004b;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    if (inputA.a[3] == 3) {
                        if (gl_SubgroupInvocationID == loopIdx1) {
                        } else {
                        }
                        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex2]) {
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10052;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        } else {
                        }
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10056;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    } else {
                        if (testBit(uvec4(0x42962bce, 0xdc83561c, 0x804b9d28, 0xccd73ff2), gl_SubgroupInvocationID)) {
                        }
                        for (int loopIdx2 = 0;
                                 loopIdx2 < inputA.a[1];
                                 loopIdx2++) {
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1005c;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        }
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1005f;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    }
                    while (!subgroupElect()) {}
                } while (loopIdx1 < inputA.a[2]);
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10064;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            if (gl_SubgroupInvocationID == loopIdx0) {
                switch (inputA.a[0]) {
                    case 1:
                    {
                        for (int loopIdx1 = 0;
                                 loopIdx1 < inputA.a[5];
                                 loopIdx1++) {
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1006a;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        }
                        break;
                    }
                    case 0:
                    {
                        if (inputA.a[3] == 3) {
                        }
                        break;
                        break;
                    }
                    case 2:
                    {
                        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex3]) {
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10075;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        }
                        break;
                    }
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1007a;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                if (testBit(uvec4(0x5d5d909f, 0xc0cb6625, 0xf80726dc, 0x3b59be1c), gl_SubgroupInvocationID)) {
                    if (testBit(uvec4(0x42962bce, 0xdc83561c, 0x804b9d28, 0xccd73ff2), gl_SubgroupInvocationID)) {
                    }
                } else {
                    if (testBit(uvec4(0x42962bce, 0xdc83561c, 0x804b9d28, 0xccd73ff2), gl_SubgroupInvocationID)) {
                    }
                }
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10083;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            } else {
                switch (loopIdx0) {
                    case 1: {
                        {
                            int loopIdx1 = 0;
                            do {
                                loopIdx1++;
                            } while (loopIdx1 < inputA.a[4]);
                        }
                        break;
                    }
                    case 2: {
                        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex4]) {
                        } else {
                        }
                        break;
                    }
                    default: {
                        if (inputA.a[3] == 3) {
                        }
                        break;
                    }
                }
                {
                    int loopIdx1 = 0;
                    do {
                        loopIdx1++;
                        if (inputA.a[2] == 2) {
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10097;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        } else {
                        }
                        for (int loopIdx2 = 0;
                                 loopIdx2 < inputA.a[5];
                                 loopIdx2++) {
                        }
                    } while (loopIdx1 < inputA.a[3]);
                }
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1009f;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
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

    if (testBit(uvec4(0xb2fa1b23, 0xd67920f6, 0xe677f900, 0x50f0c25a), gl_SubgroupInvocationID)) {
        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10002;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
                if (subgroupElect()) {
                }
                {
                    int loopIdx0 = 0;
                    do {
                        if (subgroupElect()) {
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10009;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                            break;
                        }
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000d;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        loopIdx0++;
                    } while (true);
                }
            } else {
                if (subgroupElect()) {
                }
                {
                    int loopIdx0 = 0;
                    do {
                        if (subgroupElect()) {
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10009;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                            break;
                        }
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000d;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        loopIdx0++;
                    } while (true);
                }
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001d;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        } else {
            if (inputA.a[0] == 0) {
                outputC.loc[gl_LocalInvocationIndex]++;
                outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10021;
                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                if (inputA.a[0] == 0) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10024;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
            } else {
                if (inputA.a[2] == 2) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10029;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                } else {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10029;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
                for (int loopIdx0 = 0;
                         loopIdx0 < inputA.a[3];
                         loopIdx0++) {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10030;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                }
            }
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10034;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        }
        for (int loopIdx0 = 0;
                 loopIdx0 < inputA.a[1];
                 loopIdx0++) {
            switch (gl_SubgroupInvocationID & 3) {
                case 0:
                {
                    if (testBit(uvec4(0xedd126dc, 0xdc84a6e2, 0x2f332044, 0x63902f01), gl_SubgroupInvocationID)) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1003b;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    }
                    break;
                }
                case 1:
                {
                    for (int loopIdx1 = 0;
                             loopIdx1 < gl_SubgroupInvocationID + 1;
                             loopIdx1++) {
                    }
                    break;
                }
                case 2:
                {
                    if (subgroupElect()) {
                    }
                    break;
                }
                case 3:
                {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10048;
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
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1004e;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                            break;
                        }
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


void main()
{

    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
    }
    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
        if (inputA.a[0] == 0) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10004;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            switch (gl_SubgroupInvocationID & 3) {
                case 0:
                {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10008;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex2]) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000b;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    } else {
                    }
                    break;
                }
                case 1:
                {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10011;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    break;
                }
                case 2:
                {
                    for (int loopIdx0 = 0;;loopIdx0++,                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true)) {
                        if (subgroupElect()) {
                            break;
                        }
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10019;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    }
                    break;
                }
                case 3:
                {
                    if (inputA.a[0] == 0) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001f;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    }
                    break;
                }
            }
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10025;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
    } else {
        if (inputA.a[3] == 3) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10004;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
            switch (gl_SubgroupInvocationID & 3) {
                case 0:
                {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10008;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex3]) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000b;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    } else {
                    }
                    break;
                }
                case 1:
                {
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10011;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    break;
                }
                case 2:
                {
                    for (int loopIdx0 = 0;;loopIdx0++,                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true)) {
                        if (subgroupElect()) {
                            break;
                        }
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10019;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    }
                    break;
                }
                case 3:
                {
                    if (inputA.a[2] == 2) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001f;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    }
                    break;
                }
            }
        }
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10025;
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


void main()
{

    if (inputA.a[0] == 0) {
        outputC.loc[gl_LocalInvocationIndex]++;
        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10001;
        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        if (gl_LocalInvocationIndex >= inputA.a[cmpIndex0]) {
            outputC.loc[gl_LocalInvocationIndex]++;
            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10004;
            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
        } else {
            switch (inputA.a[4]) {
                case 5:
                {
                    if (subgroupElect()) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1000a;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    }
                    break;
                }
                case 4:
                {
                    break;
                }
                case 6:
                {
                    if (inputA.a[2] == 2) {
                    } else {
                    }
                    outputC.loc[gl_LocalInvocationIndex]++;
                    outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10014;
                    outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    break;
                }
            }
            switch (inputA.a[0]) {
                case 1:
                {
                    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex1]) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x1001b;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    }
                    break;
                }
                case 0:
                {
                    if (gl_LocalInvocationIndex >= inputA.a[cmpIndex2]) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10021;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    }
                    {
                        int loopIdx0 = 0;
                        do {
                            loopIdx0++;
                            outputC.loc[gl_LocalInvocationIndex]++;
                            outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10025;
                            outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                        } while (loopIdx0 < inputA.a[4]);
                    }
                    break;
                }
                case 2:
                {
                    break;
                }
            }
        }
    } else {
        switch (gl_SubgroupInvocationID & 3) {
            case 0:
            case 1:
            {
                {
                    int loopIdx0 = 0;
                    do {
                        loopIdx0++;
                        for (int loopIdx1 = 0;
                                 loopIdx1 < inputA.a[1];
                                 loopIdx1++) {
                        }
                    } while (loopIdx0 < inputA.a[2]);
                }
                break;
            }
            case 2:
            case 3:
            {
                for (int loopIdx0 = 0;;loopIdx0++,                outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true)) {
                    if (testBit(uvec4(0x598bd779, 0xdc94c4ec, 0x9bea62b5, 0xd7cae80b), gl_SubgroupInvocationID)) {
                        outputC.loc[gl_LocalInvocationIndex]++;
                        outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex].x = 0x10038;
                        outputC.loc[gl_LocalInvocationIndex]++,outputB.b[(outLoc++)*invocationStride + gl_LocalInvocationIndex] = subgroupBallot(true);
                    }
                    if (subgroupElect()) {
                    }
                    if (subgroupElect()) {
                        break;
                    }
                    break;
                }
                break;
            }
        }
    }



}
