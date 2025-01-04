#version 450
#extension GL_EXT_fragment_shader_barycentric : require

${dataStruct}

${dynamicIndexing}
${fragInterpIn}${fragFlatIn}layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in ${typePrefix} data[]${typeSuffix};
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = ${primitiveId};
    const bool even = (p%2 == 0);

    ${typePrefix} eA${typeSuffix}; { const int n = 1 + ${forcedVertexFormula0}; eA = ${value}; }
    ${typePrefix} eB${typeSuffix}; { const int n = 1 + ${forcedVertexFormula1}; eB = ${value}; }
    ${typePrefix} eC${typeSuffix}; { const int n = 1 + ${forcedVertexFormula2}; eC = ${value}; }

    ${scalarName} e[${componentCount}] = { ${expected} };
${fragExpectedInterp}${fragExpectedFlat}
    ${typePrefix} vA${typeSuffix}; { vA = ${dataAt0}; }
    ${typePrefix} vB${typeSuffix}; { vB = ${dataAt1}; }
    ${typePrefix} vC${typeSuffix}; { vC = ${dataAt2}; }
${fragArrivedInterp}${fragArrivedFlat}
    ${scalarName} v[${componentCount}] = { ${arrived} };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<${componentCount}; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
${fragCheckInterp}${fragCheckFlat}    out_color = mask;
}
