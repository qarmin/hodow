struct VSOut
{
    float4 Position : SV_POSITION;
};
[maxvertexcount(10)]
void main(triangle VSOut input[3], inout TriangleStream<VSOut> TriStream)
{
    VSOut output;
    output.Position = input[0].Position;
    TriStream.Append(output);
    output.Position = input[1].Position;
    TriStream.Append(output);
    output.Position = input[2].Position;
    TriStream.Append(output);
}
