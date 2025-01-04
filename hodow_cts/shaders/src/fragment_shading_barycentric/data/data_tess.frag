#version 450
#extension GL_EXT_fragment_shader_barycentric : require

${dataStruct}

${dynamicIndexing}
${fragInterpIn}${fragFlatIn}layout(location = 0) out uvec4 out_color;

struct InDataStruct {uint idx; ${typePrefix} data${typeSuffix};};
layout(location = 0) pervertexEXT in InDataStruct inParam[];
void getData(uint i, out ${typePrefix} ds${typeSuffix})
{
    for(uint k = 0; k < 3; k++)
    {
        if (inParam[k].idx == i)
            ds = ${tessDataExpr};
    }
}
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = ${primitiveId};
    const bool even = (p%2 == 0);

    ${typePrefix} eA${typeSuffix}; { const int n = 1 + ${vertexFormula0}; eA = ${value}; }
    ${typePrefix} eB${typeSuffix}; { const int n = 1 + ${vertexFormula1}; eB = ${value}; }
    ${typePrefix} eC${typeSuffix}; { const int n = 1 + ${vertexFormula2}; eC = ${value}; }

    ${scalarName} e[${componentCount}] = { ${expected} };
${fragExpectedInterp}${fragExpectedFlat}
    ${typePrefix} vA${typeSuffix}; { getData(${i0}, vA); }
    ${typePrefix} vB${typeSuffix}; { getData(${i1}, vB); }
    ${typePrefix} vC${typeSuffix}; { getData(${i2}, vC); }

    ${scalarName} v[${componentCount}] = { ${arrived} };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<${componentCount}; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
${fragCheckInterp}${fragCheckFlat}    out_color = mask;
}
