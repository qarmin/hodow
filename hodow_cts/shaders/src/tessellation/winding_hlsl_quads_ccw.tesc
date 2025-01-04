struct HS_CONSTANT_OUT
{
    float tessLevelsOuter[4] : SV_TessFactor;
    float tessLevelsInner[2] : SV_InsideTessFactor;
};

[domain("quad")]
[partitioning("integer")]
[outputtopology("triangle_ccw")]
[outputcontrolpoints(1)]
[patchconstantfunc("PCF")]
void main()
{
}

HS_CONSTANT_OUT PCF()
{
    HS_CONSTANT_OUT output;
    output.tessLevelsInner[0] = 5.0;
    output.tessLevelsInner[1] = 5.0;
    output.tessLevelsOuter[0] = 5.0;
    output.tessLevelsOuter[1] = 5.0;
    output.tessLevelsOuter[2] = 5.0;
    output.tessLevelsOuter[3] = 5.0;
    return output;
}
