RWStructuredBuffer <float> tessCoord : register(b1);
globallycoherent RWStructuredBuffer <int> numInvocations : register(b2);

void main(float2 tessCoords : SV_DOMAINLOCATION)
{
    int index;
    InterlockedAdd(numInvocations[0], 1, index);
    tessCoord[index] = tessCoords.x;
}
