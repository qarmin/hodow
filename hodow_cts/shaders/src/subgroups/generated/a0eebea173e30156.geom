#version 450
#extension GL_ARB_shader_ballot: enable
#extension GL_KHR_shader_subgroup_basic: enable
#extension GL_ARB_gpu_shader_int64: enable
layout(lines) in;
layout(points, max_vertices = 1) out;
layout(set = 0, binding = 3, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  uint data[];
};

bool subgroupBallotBitExtract(uint64_t value, uint index)
{
    if (index > 63)
        return false;
    uint64_t mask = 1ul << index;
    if (bool((value & mask)) == true)
        return true;
    return false;
}
void main (void)
{
  uint tempRes;
  uint64_t mask;
mask = ballotARB(true);
  uint sgSize = gl_SubGroupSizeARB;
  uint sgInvocation = gl_SubGroupInvocationARB;
  tempRes = 0x3;
  uint ops[64];
  uint d = data[sgInvocation];
  ops[0] = readInvocationARB(d, 0u);
  ops[1] = readInvocationARB(d, 1u);
  ops[2] = readInvocationARB(d, 2u);
  ops[3] = readInvocationARB(d, 3u);
  ops[4] = readInvocationARB(d, 4u);
  ops[5] = readInvocationARB(d, 5u);
  ops[6] = readInvocationARB(d, 6u);
  ops[7] = readInvocationARB(d, 7u);
  ops[8] = readInvocationARB(d, 8u);
  ops[9] = readInvocationARB(d, 9u);
  ops[10] = readInvocationARB(d, 10u);
  ops[11] = readInvocationARB(d, 11u);
  ops[12] = readInvocationARB(d, 12u);
  ops[13] = readInvocationARB(d, 13u);
  ops[14] = readInvocationARB(d, 14u);
  ops[15] = readInvocationARB(d, 15u);
  ops[16] = readInvocationARB(d, 16u);
  ops[17] = readInvocationARB(d, 17u);
  ops[18] = readInvocationARB(d, 18u);
  ops[19] = readInvocationARB(d, 19u);
  ops[20] = readInvocationARB(d, 20u);
  ops[21] = readInvocationARB(d, 21u);
  ops[22] = readInvocationARB(d, 22u);
  ops[23] = readInvocationARB(d, 23u);
  ops[24] = readInvocationARB(d, 24u);
  ops[25] = readInvocationARB(d, 25u);
  ops[26] = readInvocationARB(d, 26u);
  ops[27] = readInvocationARB(d, 27u);
  ops[28] = readInvocationARB(d, 28u);
  ops[29] = readInvocationARB(d, 29u);
  ops[30] = readInvocationARB(d, 30u);
  ops[31] = readInvocationARB(d, 31u);
  ops[32] = readInvocationARB(d, 32u);
  ops[33] = readInvocationARB(d, 33u);
  ops[34] = readInvocationARB(d, 34u);
  ops[35] = readInvocationARB(d, 35u);
  ops[36] = readInvocationARB(d, 36u);
  ops[37] = readInvocationARB(d, 37u);
  ops[38] = readInvocationARB(d, 38u);
  ops[39] = readInvocationARB(d, 39u);
  ops[40] = readInvocationARB(d, 40u);
  ops[41] = readInvocationARB(d, 41u);
  ops[42] = readInvocationARB(d, 42u);
  ops[43] = readInvocationARB(d, 43u);
  ops[44] = readInvocationARB(d, 44u);
  ops[45] = readInvocationARB(d, 45u);
  ops[46] = readInvocationARB(d, 46u);
  ops[47] = readInvocationARB(d, 47u);
  ops[48] = readInvocationARB(d, 48u);
  ops[49] = readInvocationARB(d, 49u);
  ops[50] = readInvocationARB(d, 50u);
  ops[51] = readInvocationARB(d, 51u);
  ops[52] = readInvocationARB(d, 52u);
  ops[53] = readInvocationARB(d, 53u);
  ops[54] = readInvocationARB(d, 54u);
  ops[55] = readInvocationARB(d, 55u);
  ops[56] = readInvocationARB(d, 56u);
  ops[57] = readInvocationARB(d, 57u);
  ops[58] = readInvocationARB(d, 58u);
  ops[59] = readInvocationARB(d, 59u);
  ops[60] = readInvocationARB(d, 60u);
  ops[61] = readInvocationARB(d, 61u);
  ops[62] = readInvocationARB(d, 62u);
  ops[63] = readInvocationARB(d, 63u);
  for(int id = 0; id < sgSize; id++)
  {
    if (subgroupBallotBitExtract(mask, id) && ops[id] != data[id])
    {
      tempRes = 0;
    }
  };
  result[gl_PrimitiveIDIn] = tempRes;
  gl_Position = gl_in[0].gl_Position;
  EmitVertex();
  EndPrimitive();
}
