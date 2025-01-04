struct HS_CONSTANT_OUT
{
    float tessLevelsOuter[2] : SV_TessFactor;
};

tbuffer TessLevels : register(b0)
{
    float outer1;
}

[domain("isoline")]
[partitioning("fractional_odd")]
[outputtopology("point")]
[outputcontrolpoints(1)]
[patchconstantfunc("PCF")]
void main()
{
}

HS_CONSTANT_OUT PCF()
{
    HS_CONSTANT_OUT output;
    output.tessLevelsOuter[0] = 1.0;
    output.tessLevelsOuter[1] = outer1;
    return output;
}
