float4 main(float2 tessCoords : SV_DOMAINLOCATION) : SV_POSITION
{
    return float4(tessCoords.xy*2.0 - 1, 0.0, 1.0);
}
