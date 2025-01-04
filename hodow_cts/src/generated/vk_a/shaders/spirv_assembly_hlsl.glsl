cbuffer cbIn
{
  int foo[2] : packoffset(c0);
  int bar    : packoffset(c1.y);
};
RWStructuredBuffer<int> result : register(u1);
[numthreads(1, 1, 1)]
void main(uint3 dispatchThreadID : SV_DispatchThreadID)
{
  result[0] = bar;
}
