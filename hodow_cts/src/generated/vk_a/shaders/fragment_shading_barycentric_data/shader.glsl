#version 450
#extension GL_EXT_fragment_shader_barycentric : require



layout(location = 0) in  vec4 in_position;
layout(location = 0) out float data;

out gl_PerVertex
{
    vec4  gl_Position;
    float gl_PointSize;
};

void main()
{
    const int n  = gl_VertexIndex + 1;
    data         = float(n);
    gl_PointSize = 1.0;
    gl_Position  = in_position;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require




layout(location = 0) out uvec4 out_color;

struct InDataStruct {uint idx; float data;};
layout(location = 0) pervertexEXT in InDataStruct inParam[];
void getData(uint i, out float ds)
{
    for(uint k = 0; k < 3; k++)
    {
        if (inParam[k].idx == i)
            ds = inParam[k].data;
    }
}
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = (x < y) ? 0 : 1;
    const bool even = (p%2 == 0);

    float eA; { const int n = 1 + (3*p); eA = float(n); }
    float eB; { const int n = 1 + (3*p+1); eB = float(n); }
    float eC; { const int n = 1 + (3*p+2); eC = float(n); }

    float e[3] = { eA,eB,eC };

    float vA; { getData(0, vA); }
    float vB; { getData(1, vB); }
    float vC; { getData(2, vC); }

    float v[3] = { vA,vB,vC };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<3; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_tessellation_shader : require
layout (vertices=6) out;
in gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
} gl_in[];
out gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
} gl_out[];



layout (location=0) in float inData[];
layout (location=0) out float outData[];

void main (void)
{
    if (gl_InvocationID == 0)
    {
        gl_TessLevelInner[0] = 1.0;
        gl_TessLevelInner[1] = 1.0;
        gl_TessLevelOuter[0] = 1.0;
        gl_TessLevelOuter[1] = 1.0;
        gl_TessLevelOuter[2] = 1.0;
        gl_TessLevelOuter[3] = 1.0;
    }
    outData[gl_InvocationID] = inData[gl_InvocationID];
    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
}
#version 450
#extension GL_EXT_tessellation_shader : require
layout (triangles) in;
in gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
} gl_in[];
out gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
};



layout (location=0) in float inData[];
struct OutDataStruct {uint idx; float data;};
layout (location=0) flat out OutDataStruct outParam;

void main (void)
{
    gl_Position = (gl_TessCoord.x * gl_in[0].gl_Position) +
                  (gl_TessCoord.y * gl_in[1].gl_Position) +
                  (gl_TessCoord.z * gl_in[2].gl_Position);
    if (gl_TessCoord.xyz == vec3(0.0,1.0,0.0)) {outParam.idx = 2; outParam.data = inData[2]; }
    else if (gl_TessCoord.xyz == vec3(1.0,0.0,0.0)) {outParam.idx = 0; outParam.data = inData[0]; }
    else if (gl_TessCoord.xyz == vec3(0.0,0.0,1.0)) {outParam.idx = 1; outParam.data = inData[1]; }
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require



layout(location = 0) in  vec4 in_position;
layout(location = 0) out vec2 data;

out gl_PerVertex
{
    vec4  gl_Position;
    float gl_PointSize;
};

void main()
{
    const int n  = gl_VertexIndex + 1;
    data         = vec2(float(n), float(2*n));
    gl_PointSize = 1.0;
    gl_Position  = in_position;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require




layout(location = 0) out uvec4 out_color;

struct InDataStruct {uint idx; vec2 data;};
layout(location = 0) pervertexEXT in InDataStruct inParam[];
void getData(uint i, out vec2 ds)
{
    for(uint k = 0; k < 3; k++)
    {
        if (inParam[k].idx == i)
            ds = inParam[k].data;
    }
}
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = (x < y) ? 0 : 1;
    const bool even = (p%2 == 0);

    vec2 eA; { const int n = 1 + (3*p); eA = vec2(float(n), float(2*n)); }
    vec2 eB; { const int n = 1 + (3*p+1); eB = vec2(float(n), float(2*n)); }
    vec2 eC; { const int n = 1 + (3*p+2); eC = vec2(float(n), float(2*n)); }

    float e[6] = { eA.x,eA.y,eB.x,eB.y,eC.x,eC.y };

    vec2 vA; { getData(0, vA); }
    vec2 vB; { getData(1, vB); }
    vec2 vC; { getData(2, vC); }

    float v[6] = { vA.x,vA.y,vB.x,vB.y,vC.x,vC.y };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<6; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_tessellation_shader : require
layout (vertices=6) out;
in gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
} gl_in[];
out gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
} gl_out[];



layout (location=0) in vec2 inData[];
layout (location=0) out vec2 outData[];

void main (void)
{
    if (gl_InvocationID == 0)
    {
        gl_TessLevelInner[0] = 1.0;
        gl_TessLevelInner[1] = 1.0;
        gl_TessLevelOuter[0] = 1.0;
        gl_TessLevelOuter[1] = 1.0;
        gl_TessLevelOuter[2] = 1.0;
        gl_TessLevelOuter[3] = 1.0;
    }
    outData[gl_InvocationID] = inData[gl_InvocationID];
    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
}
#version 450
#extension GL_EXT_tessellation_shader : require
layout (triangles) in;
in gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
} gl_in[];
out gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
};



layout (location=0) in vec2 inData[];
struct OutDataStruct {uint idx; vec2 data;};
layout (location=0) flat out OutDataStruct outParam;

void main (void)
{
    gl_Position = (gl_TessCoord.x * gl_in[0].gl_Position) +
                  (gl_TessCoord.y * gl_in[1].gl_Position) +
                  (gl_TessCoord.z * gl_in[2].gl_Position);
    if (gl_TessCoord.xyz == vec3(0.0,1.0,0.0)) {outParam.idx = 2; outParam.data = inData[2]; }
    else if (gl_TessCoord.xyz == vec3(1.0,0.0,0.0)) {outParam.idx = 0; outParam.data = inData[0]; }
    else if (gl_TessCoord.xyz == vec3(0.0,0.0,1.0)) {outParam.idx = 1; outParam.data = inData[1]; }
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require



layout(location = 0) in  vec4 in_position;
layout(location = 0) out vec3 data;

out gl_PerVertex
{
    vec4  gl_Position;
    float gl_PointSize;
};

void main()
{
    const int n  = gl_VertexIndex + 1;
    data         = vec3(float(n), float(2*n), float(4*n));
    gl_PointSize = 1.0;
    gl_Position  = in_position;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require




layout(location = 0) out uvec4 out_color;

struct InDataStruct {uint idx; vec3 data;};
layout(location = 0) pervertexEXT in InDataStruct inParam[];
void getData(uint i, out vec3 ds)
{
    for(uint k = 0; k < 3; k++)
    {
        if (inParam[k].idx == i)
            ds = inParam[k].data;
    }
}
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = (x < y) ? 0 : 1;
    const bool even = (p%2 == 0);

    vec3 eA; { const int n = 1 + (3*p); eA = vec3(float(n), float(2*n), float(4*n)); }
    vec3 eB; { const int n = 1 + (3*p+1); eB = vec3(float(n), float(2*n), float(4*n)); }
    vec3 eC; { const int n = 1 + (3*p+2); eC = vec3(float(n), float(2*n), float(4*n)); }

    float e[9] = { eA.x,eA.y,eA.z,eB.x,eB.y,eB.z,eC.x,eC.y,eC.z };

    vec3 vA; { getData(0, vA); }
    vec3 vB; { getData(1, vB); }
    vec3 vC; { getData(2, vC); }

    float v[9] = { vA.x,vA.y,vA.z,vB.x,vB.y,vB.z,vC.x,vC.y,vC.z };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<9; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_tessellation_shader : require
layout (vertices=6) out;
in gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
} gl_in[];
out gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
} gl_out[];



layout (location=0) in vec3 inData[];
layout (location=0) out vec3 outData[];

void main (void)
{
    if (gl_InvocationID == 0)
    {
        gl_TessLevelInner[0] = 1.0;
        gl_TessLevelInner[1] = 1.0;
        gl_TessLevelOuter[0] = 1.0;
        gl_TessLevelOuter[1] = 1.0;
        gl_TessLevelOuter[2] = 1.0;
        gl_TessLevelOuter[3] = 1.0;
    }
    outData[gl_InvocationID] = inData[gl_InvocationID];
    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
}
#version 450
#extension GL_EXT_tessellation_shader : require
layout (triangles) in;
in gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
} gl_in[];
out gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
};



layout (location=0) in vec3 inData[];
struct OutDataStruct {uint idx; vec3 data;};
layout (location=0) flat out OutDataStruct outParam;

void main (void)
{
    gl_Position = (gl_TessCoord.x * gl_in[0].gl_Position) +
                  (gl_TessCoord.y * gl_in[1].gl_Position) +
                  (gl_TessCoord.z * gl_in[2].gl_Position);
    if (gl_TessCoord.xyz == vec3(0.0,1.0,0.0)) {outParam.idx = 2; outParam.data = inData[2]; }
    else if (gl_TessCoord.xyz == vec3(1.0,0.0,0.0)) {outParam.idx = 0; outParam.data = inData[0]; }
    else if (gl_TessCoord.xyz == vec3(0.0,0.0,1.0)) {outParam.idx = 1; outParam.data = inData[1]; }
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require



layout(location = 0) in  vec4 in_position;
layout(location = 0) out vec4 data;

out gl_PerVertex
{
    vec4  gl_Position;
    float gl_PointSize;
};

void main()
{
    const int n  = gl_VertexIndex + 1;
    data         = vec4(float(n), float(2*n), float(4*n), float(8*n));
    gl_PointSize = 1.0;
    gl_Position  = in_position;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require




layout(location = 0) out uvec4 out_color;

struct InDataStruct {uint idx; vec4 data;};
layout(location = 0) pervertexEXT in InDataStruct inParam[];
void getData(uint i, out vec4 ds)
{
    for(uint k = 0; k < 3; k++)
    {
        if (inParam[k].idx == i)
            ds = inParam[k].data;
    }
}
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = (x < y) ? 0 : 1;
    const bool even = (p%2 == 0);

    vec4 eA; { const int n = 1 + (3*p); eA = vec4(float(n), float(2*n), float(4*n), float(8*n)); }
    vec4 eB; { const int n = 1 + (3*p+1); eB = vec4(float(n), float(2*n), float(4*n), float(8*n)); }
    vec4 eC; { const int n = 1 + (3*p+2); eC = vec4(float(n), float(2*n), float(4*n), float(8*n)); }

    float e[12] = { eA.x,eA.y,eA.z,eA.w,eB.x,eB.y,eB.z,eB.w,eC.x,eC.y,eC.z,eC.w };

    vec4 vA; { getData(0, vA); }
    vec4 vB; { getData(1, vB); }
    vec4 vC; { getData(2, vC); }

    float v[12] = { vA.x,vA.y,vA.z,vA.w,vB.x,vB.y,vB.z,vB.w,vC.x,vC.y,vC.z,vC.w };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<12; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_tessellation_shader : require
layout (vertices=6) out;
in gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
} gl_in[];
out gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
} gl_out[];



layout (location=0) in vec4 inData[];
layout (location=0) out vec4 outData[];

void main (void)
{
    if (gl_InvocationID == 0)
    {
        gl_TessLevelInner[0] = 1.0;
        gl_TessLevelInner[1] = 1.0;
        gl_TessLevelOuter[0] = 1.0;
        gl_TessLevelOuter[1] = 1.0;
        gl_TessLevelOuter[2] = 1.0;
        gl_TessLevelOuter[3] = 1.0;
    }
    outData[gl_InvocationID] = inData[gl_InvocationID];
    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
}
#version 450
#extension GL_EXT_tessellation_shader : require
layout (triangles) in;
in gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
} gl_in[];
out gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
};



layout (location=0) in vec4 inData[];
struct OutDataStruct {uint idx; vec4 data;};
layout (location=0) flat out OutDataStruct outParam;

void main (void)
{
    gl_Position = (gl_TessCoord.x * gl_in[0].gl_Position) +
                  (gl_TessCoord.y * gl_in[1].gl_Position) +
                  (gl_TessCoord.z * gl_in[2].gl_Position);
    if (gl_TessCoord.xyz == vec3(0.0,1.0,0.0)) {outParam.idx = 2; outParam.data = inData[2]; }
    else if (gl_TessCoord.xyz == vec3(1.0,0.0,0.0)) {outParam.idx = 0; outParam.data = inData[0]; }
    else if (gl_TessCoord.xyz == vec3(0.0,0.0,1.0)) {outParam.idx = 1; outParam.data = inData[1]; }
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require



layout(location = 0) in  vec4 in_position;
layout(location = 0) out double data;

out gl_PerVertex
{
    vec4  gl_Position;
    float gl_PointSize;
};

void main()
{
    const int n  = gl_VertexIndex + 1;
    data         = double(n);
    gl_PointSize = 1.0;
    gl_Position  = in_position;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require




layout(location = 0) out uvec4 out_color;

struct InDataStruct {uint idx; double data;};
layout(location = 0) pervertexEXT in InDataStruct inParam[];
void getData(uint i, out double ds)
{
    for(uint k = 0; k < 3; k++)
    {
        if (inParam[k].idx == i)
            ds = inParam[k].data;
    }
}
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = (x < y) ? 0 : 1;
    const bool even = (p%2 == 0);

    double eA; { const int n = 1 + (3*p); eA = double(n); }
    double eB; { const int n = 1 + (3*p+1); eB = double(n); }
    double eC; { const int n = 1 + (3*p+2); eC = double(n); }

    double e[3] = { eA,eB,eC };

    double vA; { getData(0, vA); }
    double vB; { getData(1, vB); }
    double vC; { getData(2, vC); }

    double v[3] = { vA,vB,vC };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<3; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_tessellation_shader : require
layout (vertices=6) out;
in gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
} gl_in[];
out gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
} gl_out[];



layout (location=0) in double inData[];
layout (location=0) out double outData[];

void main (void)
{
    if (gl_InvocationID == 0)
    {
        gl_TessLevelInner[0] = 1.0;
        gl_TessLevelInner[1] = 1.0;
        gl_TessLevelOuter[0] = 1.0;
        gl_TessLevelOuter[1] = 1.0;
        gl_TessLevelOuter[2] = 1.0;
        gl_TessLevelOuter[3] = 1.0;
    }
    outData[gl_InvocationID] = inData[gl_InvocationID];
    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
}
#version 450
#extension GL_EXT_tessellation_shader : require
layout (triangles) in;
in gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
} gl_in[];
out gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
};



layout (location=0) in double inData[];
struct OutDataStruct {uint idx; double data;};
layout (location=0) flat out OutDataStruct outParam;

void main (void)
{
    gl_Position = (gl_TessCoord.x * gl_in[0].gl_Position) +
                  (gl_TessCoord.y * gl_in[1].gl_Position) +
                  (gl_TessCoord.z * gl_in[2].gl_Position);
    if (gl_TessCoord.xyz == vec3(0.0,1.0,0.0)) {outParam.idx = 2; outParam.data = inData[2]; }
    else if (gl_TessCoord.xyz == vec3(1.0,0.0,0.0)) {outParam.idx = 0; outParam.data = inData[0]; }
    else if (gl_TessCoord.xyz == vec3(0.0,0.0,1.0)) {outParam.idx = 1; outParam.data = inData[1]; }
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require



layout(location = 0) in  vec4 in_position;
layout(location = 0) out dvec2 data;

out gl_PerVertex
{
    vec4  gl_Position;
    float gl_PointSize;
};

void main()
{
    const int n  = gl_VertexIndex + 1;
    data         = dvec2(double(n), double(2*n));
    gl_PointSize = 1.0;
    gl_Position  = in_position;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require




layout(location = 0) out uvec4 out_color;

struct InDataStruct {uint idx; dvec2 data;};
layout(location = 0) pervertexEXT in InDataStruct inParam[];
void getData(uint i, out dvec2 ds)
{
    for(uint k = 0; k < 3; k++)
    {
        if (inParam[k].idx == i)
            ds = inParam[k].data;
    }
}
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = (x < y) ? 0 : 1;
    const bool even = (p%2 == 0);

    dvec2 eA; { const int n = 1 + (3*p); eA = dvec2(double(n), double(2*n)); }
    dvec2 eB; { const int n = 1 + (3*p+1); eB = dvec2(double(n), double(2*n)); }
    dvec2 eC; { const int n = 1 + (3*p+2); eC = dvec2(double(n), double(2*n)); }

    double e[6] = { eA.x,eA.y,eB.x,eB.y,eC.x,eC.y };

    dvec2 vA; { getData(0, vA); }
    dvec2 vB; { getData(1, vB); }
    dvec2 vC; { getData(2, vC); }

    double v[6] = { vA.x,vA.y,vB.x,vB.y,vC.x,vC.y };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<6; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_tessellation_shader : require
layout (vertices=6) out;
in gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
} gl_in[];
out gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
} gl_out[];



layout (location=0) in dvec2 inData[];
layout (location=0) out dvec2 outData[];

void main (void)
{
    if (gl_InvocationID == 0)
    {
        gl_TessLevelInner[0] = 1.0;
        gl_TessLevelInner[1] = 1.0;
        gl_TessLevelOuter[0] = 1.0;
        gl_TessLevelOuter[1] = 1.0;
        gl_TessLevelOuter[2] = 1.0;
        gl_TessLevelOuter[3] = 1.0;
    }
    outData[gl_InvocationID] = inData[gl_InvocationID];
    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
}
#version 450
#extension GL_EXT_tessellation_shader : require
layout (triangles) in;
in gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
} gl_in[];
out gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
};



layout (location=0) in dvec2 inData[];
struct OutDataStruct {uint idx; dvec2 data;};
layout (location=0) flat out OutDataStruct outParam;

void main (void)
{
    gl_Position = (gl_TessCoord.x * gl_in[0].gl_Position) +
                  (gl_TessCoord.y * gl_in[1].gl_Position) +
                  (gl_TessCoord.z * gl_in[2].gl_Position);
    if (gl_TessCoord.xyz == vec3(0.0,1.0,0.0)) {outParam.idx = 2; outParam.data = inData[2]; }
    else if (gl_TessCoord.xyz == vec3(1.0,0.0,0.0)) {outParam.idx = 0; outParam.data = inData[0]; }
    else if (gl_TessCoord.xyz == vec3(0.0,0.0,1.0)) {outParam.idx = 1; outParam.data = inData[1]; }
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require



layout(location = 0) in  vec4 in_position;
layout(location = 0) out dvec3 data;

out gl_PerVertex
{
    vec4  gl_Position;
    float gl_PointSize;
};

void main()
{
    const int n  = gl_VertexIndex + 1;
    data         = dvec3(double(n), double(2*n), double(4*n));
    gl_PointSize = 1.0;
    gl_Position  = in_position;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require




layout(location = 0) out uvec4 out_color;

struct InDataStruct {uint idx; dvec3 data;};
layout(location = 0) pervertexEXT in InDataStruct inParam[];
void getData(uint i, out dvec3 ds)
{
    for(uint k = 0; k < 3; k++)
    {
        if (inParam[k].idx == i)
            ds = inParam[k].data;
    }
}
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = (x < y) ? 0 : 1;
    const bool even = (p%2 == 0);

    dvec3 eA; { const int n = 1 + (3*p); eA = dvec3(double(n), double(2*n), double(4*n)); }
    dvec3 eB; { const int n = 1 + (3*p+1); eB = dvec3(double(n), double(2*n), double(4*n)); }
    dvec3 eC; { const int n = 1 + (3*p+2); eC = dvec3(double(n), double(2*n), double(4*n)); }

    double e[9] = { eA.x,eA.y,eA.z,eB.x,eB.y,eB.z,eC.x,eC.y,eC.z };

    dvec3 vA; { getData(0, vA); }
    dvec3 vB; { getData(1, vB); }
    dvec3 vC; { getData(2, vC); }

    double v[9] = { vA.x,vA.y,vA.z,vB.x,vB.y,vB.z,vC.x,vC.y,vC.z };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<9; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_tessellation_shader : require
layout (vertices=6) out;
in gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
} gl_in[];
out gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
} gl_out[];



layout (location=0) in dvec3 inData[];
layout (location=0) out dvec3 outData[];

void main (void)
{
    if (gl_InvocationID == 0)
    {
        gl_TessLevelInner[0] = 1.0;
        gl_TessLevelInner[1] = 1.0;
        gl_TessLevelOuter[0] = 1.0;
        gl_TessLevelOuter[1] = 1.0;
        gl_TessLevelOuter[2] = 1.0;
        gl_TessLevelOuter[3] = 1.0;
    }
    outData[gl_InvocationID] = inData[gl_InvocationID];
    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
}
#version 450
#extension GL_EXT_tessellation_shader : require
layout (triangles) in;
in gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
} gl_in[];
out gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
};



layout (location=0) in dvec3 inData[];
struct OutDataStruct {uint idx; dvec3 data;};
layout (location=0) flat out OutDataStruct outParam;

void main (void)
{
    gl_Position = (gl_TessCoord.x * gl_in[0].gl_Position) +
                  (gl_TessCoord.y * gl_in[1].gl_Position) +
                  (gl_TessCoord.z * gl_in[2].gl_Position);
    if (gl_TessCoord.xyz == vec3(0.0,1.0,0.0)) {outParam.idx = 2; outParam.data = inData[2]; }
    else if (gl_TessCoord.xyz == vec3(1.0,0.0,0.0)) {outParam.idx = 0; outParam.data = inData[0]; }
    else if (gl_TessCoord.xyz == vec3(0.0,0.0,1.0)) {outParam.idx = 1; outParam.data = inData[1]; }
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require



layout(location = 0) in  vec4 in_position;
layout(location = 0) out dvec4 data;

out gl_PerVertex
{
    vec4  gl_Position;
    float gl_PointSize;
};

void main()
{
    const int n  = gl_VertexIndex + 1;
    data         = dvec4(double(n), double(2*n), double(4*n), double(8*n));
    gl_PointSize = 1.0;
    gl_Position  = in_position;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require




layout(location = 0) out uvec4 out_color;

struct InDataStruct {uint idx; dvec4 data;};
layout(location = 0) pervertexEXT in InDataStruct inParam[];
void getData(uint i, out dvec4 ds)
{
    for(uint k = 0; k < 3; k++)
    {
        if (inParam[k].idx == i)
            ds = inParam[k].data;
    }
}
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = (x < y) ? 0 : 1;
    const bool even = (p%2 == 0);

    dvec4 eA; { const int n = 1 + (3*p); eA = dvec4(double(n), double(2*n), double(4*n), double(8*n)); }
    dvec4 eB; { const int n = 1 + (3*p+1); eB = dvec4(double(n), double(2*n), double(4*n), double(8*n)); }
    dvec4 eC; { const int n = 1 + (3*p+2); eC = dvec4(double(n), double(2*n), double(4*n), double(8*n)); }

    double e[12] = { eA.x,eA.y,eA.z,eA.w,eB.x,eB.y,eB.z,eB.w,eC.x,eC.y,eC.z,eC.w };

    dvec4 vA; { getData(0, vA); }
    dvec4 vB; { getData(1, vB); }
    dvec4 vC; { getData(2, vC); }

    double v[12] = { vA.x,vA.y,vA.z,vA.w,vB.x,vB.y,vB.z,vB.w,vC.x,vC.y,vC.z,vC.w };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<12; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_tessellation_shader : require
layout (vertices=6) out;
in gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
} gl_in[];
out gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
} gl_out[];



layout (location=0) in dvec4 inData[];
layout (location=0) out dvec4 outData[];

void main (void)
{
    if (gl_InvocationID == 0)
    {
        gl_TessLevelInner[0] = 1.0;
        gl_TessLevelInner[1] = 1.0;
        gl_TessLevelOuter[0] = 1.0;
        gl_TessLevelOuter[1] = 1.0;
        gl_TessLevelOuter[2] = 1.0;
        gl_TessLevelOuter[3] = 1.0;
    }
    outData[gl_InvocationID] = inData[gl_InvocationID];
    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
}
#version 450
#extension GL_EXT_tessellation_shader : require
layout (triangles) in;
in gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
} gl_in[];
out gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
};



layout (location=0) in dvec4 inData[];
struct OutDataStruct {uint idx; dvec4 data;};
layout (location=0) flat out OutDataStruct outParam;

void main (void)
{
    gl_Position = (gl_TessCoord.x * gl_in[0].gl_Position) +
                  (gl_TessCoord.y * gl_in[1].gl_Position) +
                  (gl_TessCoord.z * gl_in[2].gl_Position);
    if (gl_TessCoord.xyz == vec3(0.0,1.0,0.0)) {outParam.idx = 2; outParam.data = inData[2]; }
    else if (gl_TessCoord.xyz == vec3(1.0,0.0,0.0)) {outParam.idx = 0; outParam.data = inData[0]; }
    else if (gl_TessCoord.xyz == vec3(0.0,0.0,1.0)) {outParam.idx = 1; outParam.data = inData[1]; }
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require



layout(location = 0) in  vec4 in_position;
layout(location = 0) out int data;

out gl_PerVertex
{
    vec4  gl_Position;
    float gl_PointSize;
};

void main()
{
    const int n  = gl_VertexIndex + 1;
    data         = int(n);
    gl_PointSize = 1.0;
    gl_Position  = in_position;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require




layout(location = 0) out uvec4 out_color;

struct InDataStruct {uint idx; int data;};
layout(location = 0) pervertexEXT in InDataStruct inParam[];
void getData(uint i, out int ds)
{
    for(uint k = 0; k < 3; k++)
    {
        if (inParam[k].idx == i)
            ds = inParam[k].data;
    }
}
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = (x < y) ? 0 : 1;
    const bool even = (p%2 == 0);

    int eA; { const int n = 1 + (3*p); eA = int(n); }
    int eB; { const int n = 1 + (3*p+1); eB = int(n); }
    int eC; { const int n = 1 + (3*p+2); eC = int(n); }

    int e[3] = { eA,eB,eC };

    int vA; { getData(0, vA); }
    int vB; { getData(1, vB); }
    int vC; { getData(2, vC); }

    int v[3] = { vA,vB,vC };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<3; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_tessellation_shader : require
layout (vertices=6) out;
in gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
} gl_in[];
out gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
} gl_out[];



layout (location=0) in int inData[];
layout (location=0) out int outData[];

void main (void)
{
    if (gl_InvocationID == 0)
    {
        gl_TessLevelInner[0] = 1.0;
        gl_TessLevelInner[1] = 1.0;
        gl_TessLevelOuter[0] = 1.0;
        gl_TessLevelOuter[1] = 1.0;
        gl_TessLevelOuter[2] = 1.0;
        gl_TessLevelOuter[3] = 1.0;
    }
    outData[gl_InvocationID] = inData[gl_InvocationID];
    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
}
#version 450
#extension GL_EXT_tessellation_shader : require
layout (triangles) in;
in gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
} gl_in[];
out gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
};



layout (location=0) in int inData[];
struct OutDataStruct {uint idx; int data;};
layout (location=0) flat out OutDataStruct outParam;

void main (void)
{
    gl_Position = (gl_TessCoord.x * gl_in[0].gl_Position) +
                  (gl_TessCoord.y * gl_in[1].gl_Position) +
                  (gl_TessCoord.z * gl_in[2].gl_Position);
    if (gl_TessCoord.xyz == vec3(0.0,1.0,0.0)) {outParam.idx = 2; outParam.data = inData[2]; }
    else if (gl_TessCoord.xyz == vec3(1.0,0.0,0.0)) {outParam.idx = 0; outParam.data = inData[0]; }
    else if (gl_TessCoord.xyz == vec3(0.0,0.0,1.0)) {outParam.idx = 1; outParam.data = inData[1]; }
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require



layout(location = 0) in  vec4 in_position;
layout(location = 0) out ivec2 data;

out gl_PerVertex
{
    vec4  gl_Position;
    float gl_PointSize;
};

void main()
{
    const int n  = gl_VertexIndex + 1;
    data         = ivec2(int(n), int(2*n));
    gl_PointSize = 1.0;
    gl_Position  = in_position;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require




layout(location = 0) out uvec4 out_color;

struct InDataStruct {uint idx; ivec2 data;};
layout(location = 0) pervertexEXT in InDataStruct inParam[];
void getData(uint i, out ivec2 ds)
{
    for(uint k = 0; k < 3; k++)
    {
        if (inParam[k].idx == i)
            ds = inParam[k].data;
    }
}
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = (x < y) ? 0 : 1;
    const bool even = (p%2 == 0);

    ivec2 eA; { const int n = 1 + (3*p); eA = ivec2(int(n), int(2*n)); }
    ivec2 eB; { const int n = 1 + (3*p+1); eB = ivec2(int(n), int(2*n)); }
    ivec2 eC; { const int n = 1 + (3*p+2); eC = ivec2(int(n), int(2*n)); }

    int e[6] = { eA.x,eA.y,eB.x,eB.y,eC.x,eC.y };

    ivec2 vA; { getData(0, vA); }
    ivec2 vB; { getData(1, vB); }
    ivec2 vC; { getData(2, vC); }

    int v[6] = { vA.x,vA.y,vB.x,vB.y,vC.x,vC.y };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<6; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_tessellation_shader : require
layout (vertices=6) out;
in gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
} gl_in[];
out gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
} gl_out[];



layout (location=0) in ivec2 inData[];
layout (location=0) out ivec2 outData[];

void main (void)
{
    if (gl_InvocationID == 0)
    {
        gl_TessLevelInner[0] = 1.0;
        gl_TessLevelInner[1] = 1.0;
        gl_TessLevelOuter[0] = 1.0;
        gl_TessLevelOuter[1] = 1.0;
        gl_TessLevelOuter[2] = 1.0;
        gl_TessLevelOuter[3] = 1.0;
    }
    outData[gl_InvocationID] = inData[gl_InvocationID];
    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
}
#version 450
#extension GL_EXT_tessellation_shader : require
layout (triangles) in;
in gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
} gl_in[];
out gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
};



layout (location=0) in ivec2 inData[];
struct OutDataStruct {uint idx; ivec2 data;};
layout (location=0) flat out OutDataStruct outParam;

void main (void)
{
    gl_Position = (gl_TessCoord.x * gl_in[0].gl_Position) +
                  (gl_TessCoord.y * gl_in[1].gl_Position) +
                  (gl_TessCoord.z * gl_in[2].gl_Position);
    if (gl_TessCoord.xyz == vec3(0.0,1.0,0.0)) {outParam.idx = 2; outParam.data = inData[2]; }
    else if (gl_TessCoord.xyz == vec3(1.0,0.0,0.0)) {outParam.idx = 0; outParam.data = inData[0]; }
    else if (gl_TessCoord.xyz == vec3(0.0,0.0,1.0)) {outParam.idx = 1; outParam.data = inData[1]; }
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require



layout(location = 0) in  vec4 in_position;
layout(location = 0) out ivec3 data;

out gl_PerVertex
{
    vec4  gl_Position;
    float gl_PointSize;
};

void main()
{
    const int n  = gl_VertexIndex + 1;
    data         = ivec3(int(n), int(2*n), int(4*n));
    gl_PointSize = 1.0;
    gl_Position  = in_position;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require




layout(location = 0) out uvec4 out_color;

struct InDataStruct {uint idx; ivec3 data;};
layout(location = 0) pervertexEXT in InDataStruct inParam[];
void getData(uint i, out ivec3 ds)
{
    for(uint k = 0; k < 3; k++)
    {
        if (inParam[k].idx == i)
            ds = inParam[k].data;
    }
}
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = (x < y) ? 0 : 1;
    const bool even = (p%2 == 0);

    ivec3 eA; { const int n = 1 + (3*p); eA = ivec3(int(n), int(2*n), int(4*n)); }
    ivec3 eB; { const int n = 1 + (3*p+1); eB = ivec3(int(n), int(2*n), int(4*n)); }
    ivec3 eC; { const int n = 1 + (3*p+2); eC = ivec3(int(n), int(2*n), int(4*n)); }

    int e[9] = { eA.x,eA.y,eA.z,eB.x,eB.y,eB.z,eC.x,eC.y,eC.z };

    ivec3 vA; { getData(0, vA); }
    ivec3 vB; { getData(1, vB); }
    ivec3 vC; { getData(2, vC); }

    int v[9] = { vA.x,vA.y,vA.z,vB.x,vB.y,vB.z,vC.x,vC.y,vC.z };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<9; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_tessellation_shader : require
layout (vertices=6) out;
in gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
} gl_in[];
out gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
} gl_out[];



layout (location=0) in ivec3 inData[];
layout (location=0) out ivec3 outData[];

void main (void)
{
    if (gl_InvocationID == 0)
    {
        gl_TessLevelInner[0] = 1.0;
        gl_TessLevelInner[1] = 1.0;
        gl_TessLevelOuter[0] = 1.0;
        gl_TessLevelOuter[1] = 1.0;
        gl_TessLevelOuter[2] = 1.0;
        gl_TessLevelOuter[3] = 1.0;
    }
    outData[gl_InvocationID] = inData[gl_InvocationID];
    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
}
#version 450
#extension GL_EXT_tessellation_shader : require
layout (triangles) in;
in gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
} gl_in[];
out gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
};



layout (location=0) in ivec3 inData[];
struct OutDataStruct {uint idx; ivec3 data;};
layout (location=0) flat out OutDataStruct outParam;

void main (void)
{
    gl_Position = (gl_TessCoord.x * gl_in[0].gl_Position) +
                  (gl_TessCoord.y * gl_in[1].gl_Position) +
                  (gl_TessCoord.z * gl_in[2].gl_Position);
    if (gl_TessCoord.xyz == vec3(0.0,1.0,0.0)) {outParam.idx = 2; outParam.data = inData[2]; }
    else if (gl_TessCoord.xyz == vec3(1.0,0.0,0.0)) {outParam.idx = 0; outParam.data = inData[0]; }
    else if (gl_TessCoord.xyz == vec3(0.0,0.0,1.0)) {outParam.idx = 1; outParam.data = inData[1]; }
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require



layout(location = 0) in  vec4 in_position;
layout(location = 0) out ivec4 data;

out gl_PerVertex
{
    vec4  gl_Position;
    float gl_PointSize;
};

void main()
{
    const int n  = gl_VertexIndex + 1;
    data         = ivec4(int(n), int(2*n), int(4*n), int(8*n));
    gl_PointSize = 1.0;
    gl_Position  = in_position;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require




layout(location = 0) out uvec4 out_color;

struct InDataStruct {uint idx; ivec4 data;};
layout(location = 0) pervertexEXT in InDataStruct inParam[];
void getData(uint i, out ivec4 ds)
{
    for(uint k = 0; k < 3; k++)
    {
        if (inParam[k].idx == i)
            ds = inParam[k].data;
    }
}
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = (x < y) ? 0 : 1;
    const bool even = (p%2 == 0);

    ivec4 eA; { const int n = 1 + (3*p); eA = ivec4(int(n), int(2*n), int(4*n), int(8*n)); }
    ivec4 eB; { const int n = 1 + (3*p+1); eB = ivec4(int(n), int(2*n), int(4*n), int(8*n)); }
    ivec4 eC; { const int n = 1 + (3*p+2); eC = ivec4(int(n), int(2*n), int(4*n), int(8*n)); }

    int e[12] = { eA.x,eA.y,eA.z,eA.w,eB.x,eB.y,eB.z,eB.w,eC.x,eC.y,eC.z,eC.w };

    ivec4 vA; { getData(0, vA); }
    ivec4 vB; { getData(1, vB); }
    ivec4 vC; { getData(2, vC); }

    int v[12] = { vA.x,vA.y,vA.z,vA.w,vB.x,vB.y,vB.z,vB.w,vC.x,vC.y,vC.z,vC.w };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<12; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_tessellation_shader : require
layout (vertices=6) out;
in gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
} gl_in[];
out gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
} gl_out[];



layout (location=0) in ivec4 inData[];
layout (location=0) out ivec4 outData[];

void main (void)
{
    if (gl_InvocationID == 0)
    {
        gl_TessLevelInner[0] = 1.0;
        gl_TessLevelInner[1] = 1.0;
        gl_TessLevelOuter[0] = 1.0;
        gl_TessLevelOuter[1] = 1.0;
        gl_TessLevelOuter[2] = 1.0;
        gl_TessLevelOuter[3] = 1.0;
    }
    outData[gl_InvocationID] = inData[gl_InvocationID];
    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
}
#version 450
#extension GL_EXT_tessellation_shader : require
layout (triangles) in;
in gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
} gl_in[];
out gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
};



layout (location=0) in ivec4 inData[];
struct OutDataStruct {uint idx; ivec4 data;};
layout (location=0) flat out OutDataStruct outParam;

void main (void)
{
    gl_Position = (gl_TessCoord.x * gl_in[0].gl_Position) +
                  (gl_TessCoord.y * gl_in[1].gl_Position) +
                  (gl_TessCoord.z * gl_in[2].gl_Position);
    if (gl_TessCoord.xyz == vec3(0.0,1.0,0.0)) {outParam.idx = 2; outParam.data = inData[2]; }
    else if (gl_TessCoord.xyz == vec3(1.0,0.0,0.0)) {outParam.idx = 0; outParam.data = inData[0]; }
    else if (gl_TessCoord.xyz == vec3(0.0,0.0,1.0)) {outParam.idx = 1; outParam.data = inData[1]; }
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require



layout(location = 0) in  vec4 in_position;
layout(location = 0) out uint data;

out gl_PerVertex
{
    vec4  gl_Position;
    float gl_PointSize;
};

void main()
{
    const int n  = gl_VertexIndex + 1;
    data         = uint(n);
    gl_PointSize = 1.0;
    gl_Position  = in_position;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require




layout(location = 0) out uvec4 out_color;

struct InDataStruct {uint idx; uint data;};
layout(location = 0) pervertexEXT in InDataStruct inParam[];
void getData(uint i, out uint ds)
{
    for(uint k = 0; k < 3; k++)
    {
        if (inParam[k].idx == i)
            ds = inParam[k].data;
    }
}
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = (x < y) ? 0 : 1;
    const bool even = (p%2 == 0);

    uint eA; { const int n = 1 + (3*p); eA = uint(n); }
    uint eB; { const int n = 1 + (3*p+1); eB = uint(n); }
    uint eC; { const int n = 1 + (3*p+2); eC = uint(n); }

    uint e[3] = { eA,eB,eC };

    uint vA; { getData(0, vA); }
    uint vB; { getData(1, vB); }
    uint vC; { getData(2, vC); }

    uint v[3] = { vA,vB,vC };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<3; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_tessellation_shader : require
layout (vertices=6) out;
in gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
} gl_in[];
out gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
} gl_out[];



layout (location=0) in uint inData[];
layout (location=0) out uint outData[];

void main (void)
{
    if (gl_InvocationID == 0)
    {
        gl_TessLevelInner[0] = 1.0;
        gl_TessLevelInner[1] = 1.0;
        gl_TessLevelOuter[0] = 1.0;
        gl_TessLevelOuter[1] = 1.0;
        gl_TessLevelOuter[2] = 1.0;
        gl_TessLevelOuter[3] = 1.0;
    }
    outData[gl_InvocationID] = inData[gl_InvocationID];
    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
}
#version 450
#extension GL_EXT_tessellation_shader : require
layout (triangles) in;
in gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
} gl_in[];
out gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
};



layout (location=0) in uint inData[];
struct OutDataStruct {uint idx; uint data;};
layout (location=0) flat out OutDataStruct outParam;

void main (void)
{
    gl_Position = (gl_TessCoord.x * gl_in[0].gl_Position) +
                  (gl_TessCoord.y * gl_in[1].gl_Position) +
                  (gl_TessCoord.z * gl_in[2].gl_Position);
    if (gl_TessCoord.xyz == vec3(0.0,1.0,0.0)) {outParam.idx = 2; outParam.data = inData[2]; }
    else if (gl_TessCoord.xyz == vec3(1.0,0.0,0.0)) {outParam.idx = 0; outParam.data = inData[0]; }
    else if (gl_TessCoord.xyz == vec3(0.0,0.0,1.0)) {outParam.idx = 1; outParam.data = inData[1]; }
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require



layout(location = 0) in  vec4 in_position;
layout(location = 0) out uvec2 data;

out gl_PerVertex
{
    vec4  gl_Position;
    float gl_PointSize;
};

void main()
{
    const int n  = gl_VertexIndex + 1;
    data         = uvec2(uint(n), uint(2*n));
    gl_PointSize = 1.0;
    gl_Position  = in_position;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require




layout(location = 0) out uvec4 out_color;

struct InDataStruct {uint idx; uvec2 data;};
layout(location = 0) pervertexEXT in InDataStruct inParam[];
void getData(uint i, out uvec2 ds)
{
    for(uint k = 0; k < 3; k++)
    {
        if (inParam[k].idx == i)
            ds = inParam[k].data;
    }
}
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = (x < y) ? 0 : 1;
    const bool even = (p%2 == 0);

    uvec2 eA; { const int n = 1 + (3*p); eA = uvec2(uint(n), uint(2*n)); }
    uvec2 eB; { const int n = 1 + (3*p+1); eB = uvec2(uint(n), uint(2*n)); }
    uvec2 eC; { const int n = 1 + (3*p+2); eC = uvec2(uint(n), uint(2*n)); }

    uint e[6] = { eA.x,eA.y,eB.x,eB.y,eC.x,eC.y };

    uvec2 vA; { getData(0, vA); }
    uvec2 vB; { getData(1, vB); }
    uvec2 vC; { getData(2, vC); }

    uint v[6] = { vA.x,vA.y,vB.x,vB.y,vC.x,vC.y };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<6; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_tessellation_shader : require
layout (vertices=6) out;
in gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
} gl_in[];
out gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
} gl_out[];



layout (location=0) in uvec2 inData[];
layout (location=0) out uvec2 outData[];

void main (void)
{
    if (gl_InvocationID == 0)
    {
        gl_TessLevelInner[0] = 1.0;
        gl_TessLevelInner[1] = 1.0;
        gl_TessLevelOuter[0] = 1.0;
        gl_TessLevelOuter[1] = 1.0;
        gl_TessLevelOuter[2] = 1.0;
        gl_TessLevelOuter[3] = 1.0;
    }
    outData[gl_InvocationID] = inData[gl_InvocationID];
    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
}
#version 450
#extension GL_EXT_tessellation_shader : require
layout (triangles) in;
in gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
} gl_in[];
out gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
};



layout (location=0) in uvec2 inData[];
struct OutDataStruct {uint idx; uvec2 data;};
layout (location=0) flat out OutDataStruct outParam;

void main (void)
{
    gl_Position = (gl_TessCoord.x * gl_in[0].gl_Position) +
                  (gl_TessCoord.y * gl_in[1].gl_Position) +
                  (gl_TessCoord.z * gl_in[2].gl_Position);
    if (gl_TessCoord.xyz == vec3(0.0,1.0,0.0)) {outParam.idx = 2; outParam.data = inData[2]; }
    else if (gl_TessCoord.xyz == vec3(1.0,0.0,0.0)) {outParam.idx = 0; outParam.data = inData[0]; }
    else if (gl_TessCoord.xyz == vec3(0.0,0.0,1.0)) {outParam.idx = 1; outParam.data = inData[1]; }
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require



layout(location = 0) in  vec4 in_position;
layout(location = 0) out uvec3 data;

out gl_PerVertex
{
    vec4  gl_Position;
    float gl_PointSize;
};

void main()
{
    const int n  = gl_VertexIndex + 1;
    data         = uvec3(uint(n), uint(2*n), uint(4*n));
    gl_PointSize = 1.0;
    gl_Position  = in_position;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require




layout(location = 0) out uvec4 out_color;

struct InDataStruct {uint idx; uvec3 data;};
layout(location = 0) pervertexEXT in InDataStruct inParam[];
void getData(uint i, out uvec3 ds)
{
    for(uint k = 0; k < 3; k++)
    {
        if (inParam[k].idx == i)
            ds = inParam[k].data;
    }
}
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = (x < y) ? 0 : 1;
    const bool even = (p%2 == 0);

    uvec3 eA; { const int n = 1 + (3*p); eA = uvec3(uint(n), uint(2*n), uint(4*n)); }
    uvec3 eB; { const int n = 1 + (3*p+1); eB = uvec3(uint(n), uint(2*n), uint(4*n)); }
    uvec3 eC; { const int n = 1 + (3*p+2); eC = uvec3(uint(n), uint(2*n), uint(4*n)); }

    uint e[9] = { eA.x,eA.y,eA.z,eB.x,eB.y,eB.z,eC.x,eC.y,eC.z };

    uvec3 vA; { getData(0, vA); }
    uvec3 vB; { getData(1, vB); }
    uvec3 vC; { getData(2, vC); }

    uint v[9] = { vA.x,vA.y,vA.z,vB.x,vB.y,vB.z,vC.x,vC.y,vC.z };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<9; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_tessellation_shader : require
layout (vertices=6) out;
in gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
} gl_in[];
out gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
} gl_out[];



layout (location=0) in uvec3 inData[];
layout (location=0) out uvec3 outData[];

void main (void)
{
    if (gl_InvocationID == 0)
    {
        gl_TessLevelInner[0] = 1.0;
        gl_TessLevelInner[1] = 1.0;
        gl_TessLevelOuter[0] = 1.0;
        gl_TessLevelOuter[1] = 1.0;
        gl_TessLevelOuter[2] = 1.0;
        gl_TessLevelOuter[3] = 1.0;
    }
    outData[gl_InvocationID] = inData[gl_InvocationID];
    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
}
#version 450
#extension GL_EXT_tessellation_shader : require
layout (triangles) in;
in gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
} gl_in[];
out gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
};



layout (location=0) in uvec3 inData[];
struct OutDataStruct {uint idx; uvec3 data;};
layout (location=0) flat out OutDataStruct outParam;

void main (void)
{
    gl_Position = (gl_TessCoord.x * gl_in[0].gl_Position) +
                  (gl_TessCoord.y * gl_in[1].gl_Position) +
                  (gl_TessCoord.z * gl_in[2].gl_Position);
    if (gl_TessCoord.xyz == vec3(0.0,1.0,0.0)) {outParam.idx = 2; outParam.data = inData[2]; }
    else if (gl_TessCoord.xyz == vec3(1.0,0.0,0.0)) {outParam.idx = 0; outParam.data = inData[0]; }
    else if (gl_TessCoord.xyz == vec3(0.0,0.0,1.0)) {outParam.idx = 1; outParam.data = inData[1]; }
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require



layout(location = 0) in  vec4 in_position;
layout(location = 0) out uvec4 data;

out gl_PerVertex
{
    vec4  gl_Position;
    float gl_PointSize;
};

void main()
{
    const int n  = gl_VertexIndex + 1;
    data         = uvec4(uint(n), uint(2*n), uint(4*n), uint(8*n));
    gl_PointSize = 1.0;
    gl_Position  = in_position;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require




layout(location = 0) out uvec4 out_color;

struct InDataStruct {uint idx; uvec4 data;};
layout(location = 0) pervertexEXT in InDataStruct inParam[];
void getData(uint i, out uvec4 ds)
{
    for(uint k = 0; k < 3; k++)
    {
        if (inParam[k].idx == i)
            ds = inParam[k].data;
    }
}
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = (x < y) ? 0 : 1;
    const bool even = (p%2 == 0);

    uvec4 eA; { const int n = 1 + (3*p); eA = uvec4(uint(n), uint(2*n), uint(4*n), uint(8*n)); }
    uvec4 eB; { const int n = 1 + (3*p+1); eB = uvec4(uint(n), uint(2*n), uint(4*n), uint(8*n)); }
    uvec4 eC; { const int n = 1 + (3*p+2); eC = uvec4(uint(n), uint(2*n), uint(4*n), uint(8*n)); }

    uint e[12] = { eA.x,eA.y,eA.z,eA.w,eB.x,eB.y,eB.z,eB.w,eC.x,eC.y,eC.z,eC.w };

    uvec4 vA; { getData(0, vA); }
    uvec4 vB; { getData(1, vB); }
    uvec4 vC; { getData(2, vC); }

    uint v[12] = { vA.x,vA.y,vA.z,vA.w,vB.x,vB.y,vB.z,vB.w,vC.x,vC.y,vC.z,vC.w };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<12; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_tessellation_shader : require
layout (vertices=6) out;
in gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
} gl_in[];
out gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
} gl_out[];



layout (location=0) in uvec4 inData[];
layout (location=0) out uvec4 outData[];

void main (void)
{
    if (gl_InvocationID == 0)
    {
        gl_TessLevelInner[0] = 1.0;
        gl_TessLevelInner[1] = 1.0;
        gl_TessLevelOuter[0] = 1.0;
        gl_TessLevelOuter[1] = 1.0;
        gl_TessLevelOuter[2] = 1.0;
        gl_TessLevelOuter[3] = 1.0;
    }
    outData[gl_InvocationID] = inData[gl_InvocationID];
    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
}
#version 450
#extension GL_EXT_tessellation_shader : require
layout (triangles) in;
in gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
} gl_in[];
out gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
};



layout (location=0) in uvec4 inData[];
struct OutDataStruct {uint idx; uvec4 data;};
layout (location=0) flat out OutDataStruct outParam;

void main (void)
{
    gl_Position = (gl_TessCoord.x * gl_in[0].gl_Position) +
                  (gl_TessCoord.y * gl_in[1].gl_Position) +
                  (gl_TessCoord.z * gl_in[2].gl_Position);
    if (gl_TessCoord.xyz == vec3(0.0,1.0,0.0)) {outParam.idx = 2; outParam.data = inData[2]; }
    else if (gl_TessCoord.xyz == vec3(1.0,0.0,0.0)) {outParam.idx = 0; outParam.data = inData[0]; }
    else if (gl_TessCoord.xyz == vec3(0.0,0.0,1.0)) {outParam.idx = 1; outParam.data = inData[1]; }
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require

struct DataStruct {float q;};

layout(location = 0) in  vec4 in_position;
layout(location = 0) out DataStruct data;

out gl_PerVertex
{
    vec4  gl_Position;
    float gl_PointSize;
};

void main()
{
    const int n  = gl_VertexIndex + 1;
    data         = DataStruct(float(n));
    gl_PointSize = 1.0;
    gl_Position  = in_position;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require

struct DataStruct {float q;};


layout(location = 0) out uvec4 out_color;

struct InDataStruct {uint idx; DataStruct data;};
layout(location = 0) pervertexEXT in InDataStruct inParam[];
void getData(uint i, out DataStruct ds)
{
    for(uint k = 0; k < 3; k++)
    {
        if (inParam[k].idx == i)
            ds = inParam[k].data;
    }
}
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = (x < y) ? 0 : 1;
    const bool even = (p%2 == 0);

    DataStruct eA; { const int n = 1 + (3*p); eA = DataStruct(float(n)); }
    DataStruct eB; { const int n = 1 + (3*p+1); eB = DataStruct(float(n)); }
    DataStruct eC; { const int n = 1 + (3*p+2); eC = DataStruct(float(n)); }

    float e[3] = { eA.q,eB.q,eC.q };

    DataStruct vA; { getData(0, vA); }
    DataStruct vB; { getData(1, vB); }
    DataStruct vC; { getData(2, vC); }

    float v[3] = { vA.q,vB.q,vC.q };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<3; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_tessellation_shader : require
layout (vertices=6) out;
in gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
} gl_in[];
out gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
} gl_out[];

struct DataStruct {float q;};

layout (location=0) in DataStruct inData[];
layout (location=0) out DataStruct outData[];

void main (void)
{
    if (gl_InvocationID == 0)
    {
        gl_TessLevelInner[0] = 1.0;
        gl_TessLevelInner[1] = 1.0;
        gl_TessLevelOuter[0] = 1.0;
        gl_TessLevelOuter[1] = 1.0;
        gl_TessLevelOuter[2] = 1.0;
        gl_TessLevelOuter[3] = 1.0;
    }
    outData[gl_InvocationID] = inData[gl_InvocationID];
    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
}
#version 450
#extension GL_EXT_tessellation_shader : require
layout (triangles) in;
in gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
} gl_in[];
out gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
};

struct DataStruct {float q;};

layout (location=0) in DataStruct inData[];
struct OutDataStruct {uint idx; DataStruct data;};
layout (location=0) flat out OutDataStruct outParam;

void main (void)
{
    gl_Position = (gl_TessCoord.x * gl_in[0].gl_Position) +
                  (gl_TessCoord.y * gl_in[1].gl_Position) +
                  (gl_TessCoord.z * gl_in[2].gl_Position);
    if (gl_TessCoord.xyz == vec3(0.0,1.0,0.0)) {outParam.idx = 2; outParam.data = inData[2]; }
    else if (gl_TessCoord.xyz == vec3(1.0,0.0,0.0)) {outParam.idx = 0; outParam.data = inData[0]; }
    else if (gl_TessCoord.xyz == vec3(0.0,0.0,1.0)) {outParam.idx = 1; outParam.data = inData[1]; }
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require

struct DataStruct {vec2 q;};

layout(location = 0) in  vec4 in_position;
layout(location = 0) out DataStruct data;

out gl_PerVertex
{
    vec4  gl_Position;
    float gl_PointSize;
};

void main()
{
    const int n  = gl_VertexIndex + 1;
    data         = DataStruct(vec2(float(n), float(2*n)));
    gl_PointSize = 1.0;
    gl_Position  = in_position;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require

struct DataStruct {vec2 q;};


layout(location = 0) out uvec4 out_color;

struct InDataStruct {uint idx; DataStruct data;};
layout(location = 0) pervertexEXT in InDataStruct inParam[];
void getData(uint i, out DataStruct ds)
{
    for(uint k = 0; k < 3; k++)
    {
        if (inParam[k].idx == i)
            ds = inParam[k].data;
    }
}
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = (x < y) ? 0 : 1;
    const bool even = (p%2 == 0);

    DataStruct eA; { const int n = 1 + (3*p); eA = DataStruct(vec2(float(n), float(2*n))); }
    DataStruct eB; { const int n = 1 + (3*p+1); eB = DataStruct(vec2(float(n), float(2*n))); }
    DataStruct eC; { const int n = 1 + (3*p+2); eC = DataStruct(vec2(float(n), float(2*n))); }

    float e[6] = { eA.q.x,eA.q.y,eB.q.x,eB.q.y,eC.q.x,eC.q.y };

    DataStruct vA; { getData(0, vA); }
    DataStruct vB; { getData(1, vB); }
    DataStruct vC; { getData(2, vC); }

    float v[6] = { vA.q.x,vA.q.y,vB.q.x,vB.q.y,vC.q.x,vC.q.y };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<6; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_tessellation_shader : require
layout (vertices=6) out;
in gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
} gl_in[];
out gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
} gl_out[];

struct DataStruct {vec2 q;};

layout (location=0) in DataStruct inData[];
layout (location=0) out DataStruct outData[];

void main (void)
{
    if (gl_InvocationID == 0)
    {
        gl_TessLevelInner[0] = 1.0;
        gl_TessLevelInner[1] = 1.0;
        gl_TessLevelOuter[0] = 1.0;
        gl_TessLevelOuter[1] = 1.0;
        gl_TessLevelOuter[2] = 1.0;
        gl_TessLevelOuter[3] = 1.0;
    }
    outData[gl_InvocationID] = inData[gl_InvocationID];
    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
}
#version 450
#extension GL_EXT_tessellation_shader : require
layout (triangles) in;
in gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
} gl_in[];
out gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
};

struct DataStruct {vec2 q;};

layout (location=0) in DataStruct inData[];
struct OutDataStruct {uint idx; DataStruct data;};
layout (location=0) flat out OutDataStruct outParam;

void main (void)
{
    gl_Position = (gl_TessCoord.x * gl_in[0].gl_Position) +
                  (gl_TessCoord.y * gl_in[1].gl_Position) +
                  (gl_TessCoord.z * gl_in[2].gl_Position);
    if (gl_TessCoord.xyz == vec3(0.0,1.0,0.0)) {outParam.idx = 2; outParam.data = inData[2]; }
    else if (gl_TessCoord.xyz == vec3(1.0,0.0,0.0)) {outParam.idx = 0; outParam.data = inData[0]; }
    else if (gl_TessCoord.xyz == vec3(0.0,0.0,1.0)) {outParam.idx = 1; outParam.data = inData[1]; }
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require

struct DataStruct {vec3 q;};

layout(location = 0) in  vec4 in_position;
layout(location = 0) out DataStruct data;

out gl_PerVertex
{
    vec4  gl_Position;
    float gl_PointSize;
};

void main()
{
    const int n  = gl_VertexIndex + 1;
    data         = DataStruct(vec3(float(n), float(2*n), float(4*n)));
    gl_PointSize = 1.0;
    gl_Position  = in_position;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require

struct DataStruct {vec3 q;};


layout(location = 0) out uvec4 out_color;

struct InDataStruct {uint idx; DataStruct data;};
layout(location = 0) pervertexEXT in InDataStruct inParam[];
void getData(uint i, out DataStruct ds)
{
    for(uint k = 0; k < 3; k++)
    {
        if (inParam[k].idx == i)
            ds = inParam[k].data;
    }
}
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = (x < y) ? 0 : 1;
    const bool even = (p%2 == 0);

    DataStruct eA; { const int n = 1 + (3*p); eA = DataStruct(vec3(float(n), float(2*n), float(4*n))); }
    DataStruct eB; { const int n = 1 + (3*p+1); eB = DataStruct(vec3(float(n), float(2*n), float(4*n))); }
    DataStruct eC; { const int n = 1 + (3*p+2); eC = DataStruct(vec3(float(n), float(2*n), float(4*n))); }

    float e[9] = { eA.q.x,eA.q.y,eA.q.z,eB.q.x,eB.q.y,eB.q.z,eC.q.x,eC.q.y,eC.q.z };

    DataStruct vA; { getData(0, vA); }
    DataStruct vB; { getData(1, vB); }
    DataStruct vC; { getData(2, vC); }

    float v[9] = { vA.q.x,vA.q.y,vA.q.z,vB.q.x,vB.q.y,vB.q.z,vC.q.x,vC.q.y,vC.q.z };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<9; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_tessellation_shader : require
layout (vertices=6) out;
in gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
} gl_in[];
out gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
} gl_out[];

struct DataStruct {vec3 q;};

layout (location=0) in DataStruct inData[];
layout (location=0) out DataStruct outData[];

void main (void)
{
    if (gl_InvocationID == 0)
    {
        gl_TessLevelInner[0] = 1.0;
        gl_TessLevelInner[1] = 1.0;
        gl_TessLevelOuter[0] = 1.0;
        gl_TessLevelOuter[1] = 1.0;
        gl_TessLevelOuter[2] = 1.0;
        gl_TessLevelOuter[3] = 1.0;
    }
    outData[gl_InvocationID] = inData[gl_InvocationID];
    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
}
#version 450
#extension GL_EXT_tessellation_shader : require
layout (triangles) in;
in gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
} gl_in[];
out gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
};

struct DataStruct {vec3 q;};

layout (location=0) in DataStruct inData[];
struct OutDataStruct {uint idx; DataStruct data;};
layout (location=0) flat out OutDataStruct outParam;

void main (void)
{
    gl_Position = (gl_TessCoord.x * gl_in[0].gl_Position) +
                  (gl_TessCoord.y * gl_in[1].gl_Position) +
                  (gl_TessCoord.z * gl_in[2].gl_Position);
    if (gl_TessCoord.xyz == vec3(0.0,1.0,0.0)) {outParam.idx = 2; outParam.data = inData[2]; }
    else if (gl_TessCoord.xyz == vec3(1.0,0.0,0.0)) {outParam.idx = 0; outParam.data = inData[0]; }
    else if (gl_TessCoord.xyz == vec3(0.0,0.0,1.0)) {outParam.idx = 1; outParam.data = inData[1]; }
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require

struct DataStruct {vec4 q;};

layout(location = 0) in  vec4 in_position;
layout(location = 0) out DataStruct data;

out gl_PerVertex
{
    vec4  gl_Position;
    float gl_PointSize;
};

void main()
{
    const int n  = gl_VertexIndex + 1;
    data         = DataStruct(vec4(float(n), float(2*n), float(4*n), float(8*n)));
    gl_PointSize = 1.0;
    gl_Position  = in_position;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require

struct DataStruct {vec4 q;};


layout(location = 0) out uvec4 out_color;

struct InDataStruct {uint idx; DataStruct data;};
layout(location = 0) pervertexEXT in InDataStruct inParam[];
void getData(uint i, out DataStruct ds)
{
    for(uint k = 0; k < 3; k++)
    {
        if (inParam[k].idx == i)
            ds = inParam[k].data;
    }
}
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = (x < y) ? 0 : 1;
    const bool even = (p%2 == 0);

    DataStruct eA; { const int n = 1 + (3*p); eA = DataStruct(vec4(float(n), float(2*n), float(4*n), float(8*n))); }
    DataStruct eB; { const int n = 1 + (3*p+1); eB = DataStruct(vec4(float(n), float(2*n), float(4*n), float(8*n))); }
    DataStruct eC; { const int n = 1 + (3*p+2); eC = DataStruct(vec4(float(n), float(2*n), float(4*n), float(8*n))); }

    float e[12] = { eA.q.x,eA.q.y,eA.q.z,eA.q.w,eB.q.x,eB.q.y,eB.q.z,eB.q.w,eC.q.x,eC.q.y,eC.q.z,eC.q.w };

    DataStruct vA; { getData(0, vA); }
    DataStruct vB; { getData(1, vB); }
    DataStruct vC; { getData(2, vC); }

    float v[12] = { vA.q.x,vA.q.y,vA.q.z,vA.q.w,vB.q.x,vB.q.y,vB.q.z,vB.q.w,vC.q.x,vC.q.y,vC.q.z,vC.q.w };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<12; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_tessellation_shader : require
layout (vertices=6) out;
in gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
} gl_in[];
out gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
} gl_out[];

struct DataStruct {vec4 q;};

layout (location=0) in DataStruct inData[];
layout (location=0) out DataStruct outData[];

void main (void)
{
    if (gl_InvocationID == 0)
    {
        gl_TessLevelInner[0] = 1.0;
        gl_TessLevelInner[1] = 1.0;
        gl_TessLevelOuter[0] = 1.0;
        gl_TessLevelOuter[1] = 1.0;
        gl_TessLevelOuter[2] = 1.0;
        gl_TessLevelOuter[3] = 1.0;
    }
    outData[gl_InvocationID] = inData[gl_InvocationID];
    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
}
#version 450
#extension GL_EXT_tessellation_shader : require
layout (triangles) in;
in gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
} gl_in[];
out gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
};

struct DataStruct {vec4 q;};

layout (location=0) in DataStruct inData[];
struct OutDataStruct {uint idx; DataStruct data;};
layout (location=0) flat out OutDataStruct outParam;

void main (void)
{
    gl_Position = (gl_TessCoord.x * gl_in[0].gl_Position) +
                  (gl_TessCoord.y * gl_in[1].gl_Position) +
                  (gl_TessCoord.z * gl_in[2].gl_Position);
    if (gl_TessCoord.xyz == vec3(0.0,1.0,0.0)) {outParam.idx = 2; outParam.data = inData[2]; }
    else if (gl_TessCoord.xyz == vec3(1.0,0.0,0.0)) {outParam.idx = 0; outParam.data = inData[0]; }
    else if (gl_TessCoord.xyz == vec3(0.0,0.0,1.0)) {outParam.idx = 1; outParam.data = inData[1]; }
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require

struct DataStruct {double q;};

layout(location = 0) in  vec4 in_position;
layout(location = 0) out DataStruct data;

out gl_PerVertex
{
    vec4  gl_Position;
    float gl_PointSize;
};

void main()
{
    const int n  = gl_VertexIndex + 1;
    data         = DataStruct(double(n));
    gl_PointSize = 1.0;
    gl_Position  = in_position;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require

struct DataStruct {double q;};


layout(location = 0) out uvec4 out_color;

struct InDataStruct {uint idx; DataStruct data;};
layout(location = 0) pervertexEXT in InDataStruct inParam[];
void getData(uint i, out DataStruct ds)
{
    for(uint k = 0; k < 3; k++)
    {
        if (inParam[k].idx == i)
            ds = inParam[k].data;
    }
}
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = (x < y) ? 0 : 1;
    const bool even = (p%2 == 0);

    DataStruct eA; { const int n = 1 + (3*p); eA = DataStruct(double(n)); }
    DataStruct eB; { const int n = 1 + (3*p+1); eB = DataStruct(double(n)); }
    DataStruct eC; { const int n = 1 + (3*p+2); eC = DataStruct(double(n)); }

    double e[3] = { eA.q,eB.q,eC.q };

    DataStruct vA; { getData(0, vA); }
    DataStruct vB; { getData(1, vB); }
    DataStruct vC; { getData(2, vC); }

    double v[3] = { vA.q,vB.q,vC.q };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<3; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_tessellation_shader : require
layout (vertices=6) out;
in gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
} gl_in[];
out gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
} gl_out[];

struct DataStruct {double q;};

layout (location=0) in DataStruct inData[];
layout (location=0) out DataStruct outData[];

void main (void)
{
    if (gl_InvocationID == 0)
    {
        gl_TessLevelInner[0] = 1.0;
        gl_TessLevelInner[1] = 1.0;
        gl_TessLevelOuter[0] = 1.0;
        gl_TessLevelOuter[1] = 1.0;
        gl_TessLevelOuter[2] = 1.0;
        gl_TessLevelOuter[3] = 1.0;
    }
    outData[gl_InvocationID] = inData[gl_InvocationID];
    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
}
#version 450
#extension GL_EXT_tessellation_shader : require
layout (triangles) in;
in gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
} gl_in[];
out gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
};

struct DataStruct {double q;};

layout (location=0) in DataStruct inData[];
struct OutDataStruct {uint idx; DataStruct data;};
layout (location=0) flat out OutDataStruct outParam;

void main (void)
{
    gl_Position = (gl_TessCoord.x * gl_in[0].gl_Position) +
                  (gl_TessCoord.y * gl_in[1].gl_Position) +
                  (gl_TessCoord.z * gl_in[2].gl_Position);
    if (gl_TessCoord.xyz == vec3(0.0,1.0,0.0)) {outParam.idx = 2; outParam.data = inData[2]; }
    else if (gl_TessCoord.xyz == vec3(1.0,0.0,0.0)) {outParam.idx = 0; outParam.data = inData[0]; }
    else if (gl_TessCoord.xyz == vec3(0.0,0.0,1.0)) {outParam.idx = 1; outParam.data = inData[1]; }
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require

struct DataStruct {dvec2 q;};

layout(location = 0) in  vec4 in_position;
layout(location = 0) out DataStruct data;

out gl_PerVertex
{
    vec4  gl_Position;
    float gl_PointSize;
};

void main()
{
    const int n  = gl_VertexIndex + 1;
    data         = DataStruct(dvec2(double(n), double(2*n)));
    gl_PointSize = 1.0;
    gl_Position  = in_position;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require

struct DataStruct {dvec2 q;};


layout(location = 0) out uvec4 out_color;

struct InDataStruct {uint idx; DataStruct data;};
layout(location = 0) pervertexEXT in InDataStruct inParam[];
void getData(uint i, out DataStruct ds)
{
    for(uint k = 0; k < 3; k++)
    {
        if (inParam[k].idx == i)
            ds = inParam[k].data;
    }
}
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = (x < y) ? 0 : 1;
    const bool even = (p%2 == 0);

    DataStruct eA; { const int n = 1 + (3*p); eA = DataStruct(dvec2(double(n), double(2*n))); }
    DataStruct eB; { const int n = 1 + (3*p+1); eB = DataStruct(dvec2(double(n), double(2*n))); }
    DataStruct eC; { const int n = 1 + (3*p+2); eC = DataStruct(dvec2(double(n), double(2*n))); }

    double e[6] = { eA.q.x,eA.q.y,eB.q.x,eB.q.y,eC.q.x,eC.q.y };

    DataStruct vA; { getData(0, vA); }
    DataStruct vB; { getData(1, vB); }
    DataStruct vC; { getData(2, vC); }

    double v[6] = { vA.q.x,vA.q.y,vB.q.x,vB.q.y,vC.q.x,vC.q.y };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<6; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_tessellation_shader : require
layout (vertices=6) out;
in gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
} gl_in[];
out gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
} gl_out[];

struct DataStruct {dvec2 q;};

layout (location=0) in DataStruct inData[];
layout (location=0) out DataStruct outData[];

void main (void)
{
    if (gl_InvocationID == 0)
    {
        gl_TessLevelInner[0] = 1.0;
        gl_TessLevelInner[1] = 1.0;
        gl_TessLevelOuter[0] = 1.0;
        gl_TessLevelOuter[1] = 1.0;
        gl_TessLevelOuter[2] = 1.0;
        gl_TessLevelOuter[3] = 1.0;
    }
    outData[gl_InvocationID] = inData[gl_InvocationID];
    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
}
#version 450
#extension GL_EXT_tessellation_shader : require
layout (triangles) in;
in gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
} gl_in[];
out gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
};

struct DataStruct {dvec2 q;};

layout (location=0) in DataStruct inData[];
struct OutDataStruct {uint idx; DataStruct data;};
layout (location=0) flat out OutDataStruct outParam;

void main (void)
{
    gl_Position = (gl_TessCoord.x * gl_in[0].gl_Position) +
                  (gl_TessCoord.y * gl_in[1].gl_Position) +
                  (gl_TessCoord.z * gl_in[2].gl_Position);
    if (gl_TessCoord.xyz == vec3(0.0,1.0,0.0)) {outParam.idx = 2; outParam.data = inData[2]; }
    else if (gl_TessCoord.xyz == vec3(1.0,0.0,0.0)) {outParam.idx = 0; outParam.data = inData[0]; }
    else if (gl_TessCoord.xyz == vec3(0.0,0.0,1.0)) {outParam.idx = 1; outParam.data = inData[1]; }
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require

struct DataStruct {dvec3 q;};

layout(location = 0) in  vec4 in_position;
layout(location = 0) out DataStruct data;

out gl_PerVertex
{
    vec4  gl_Position;
    float gl_PointSize;
};

void main()
{
    const int n  = gl_VertexIndex + 1;
    data         = DataStruct(dvec3(double(n), double(2*n), double(4*n)));
    gl_PointSize = 1.0;
    gl_Position  = in_position;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require

struct DataStruct {dvec3 q;};


layout(location = 0) out uvec4 out_color;

struct InDataStruct {uint idx; DataStruct data;};
layout(location = 0) pervertexEXT in InDataStruct inParam[];
void getData(uint i, out DataStruct ds)
{
    for(uint k = 0; k < 3; k++)
    {
        if (inParam[k].idx == i)
            ds = inParam[k].data;
    }
}
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = (x < y) ? 0 : 1;
    const bool even = (p%2 == 0);

    DataStruct eA; { const int n = 1 + (3*p); eA = DataStruct(dvec3(double(n), double(2*n), double(4*n))); }
    DataStruct eB; { const int n = 1 + (3*p+1); eB = DataStruct(dvec3(double(n), double(2*n), double(4*n))); }
    DataStruct eC; { const int n = 1 + (3*p+2); eC = DataStruct(dvec3(double(n), double(2*n), double(4*n))); }

    double e[9] = { eA.q.x,eA.q.y,eA.q.z,eB.q.x,eB.q.y,eB.q.z,eC.q.x,eC.q.y,eC.q.z };

    DataStruct vA; { getData(0, vA); }
    DataStruct vB; { getData(1, vB); }
    DataStruct vC; { getData(2, vC); }

    double v[9] = { vA.q.x,vA.q.y,vA.q.z,vB.q.x,vB.q.y,vB.q.z,vC.q.x,vC.q.y,vC.q.z };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<9; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_tessellation_shader : require
layout (vertices=6) out;
in gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
} gl_in[];
out gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
} gl_out[];

struct DataStruct {dvec3 q;};

layout (location=0) in DataStruct inData[];
layout (location=0) out DataStruct outData[];

void main (void)
{
    if (gl_InvocationID == 0)
    {
        gl_TessLevelInner[0] = 1.0;
        gl_TessLevelInner[1] = 1.0;
        gl_TessLevelOuter[0] = 1.0;
        gl_TessLevelOuter[1] = 1.0;
        gl_TessLevelOuter[2] = 1.0;
        gl_TessLevelOuter[3] = 1.0;
    }
    outData[gl_InvocationID] = inData[gl_InvocationID];
    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
}
#version 450
#extension GL_EXT_tessellation_shader : require
layout (triangles) in;
in gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
} gl_in[];
out gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
};

struct DataStruct {dvec3 q;};

layout (location=0) in DataStruct inData[];
struct OutDataStruct {uint idx; DataStruct data;};
layout (location=0) flat out OutDataStruct outParam;

void main (void)
{
    gl_Position = (gl_TessCoord.x * gl_in[0].gl_Position) +
                  (gl_TessCoord.y * gl_in[1].gl_Position) +
                  (gl_TessCoord.z * gl_in[2].gl_Position);
    if (gl_TessCoord.xyz == vec3(0.0,1.0,0.0)) {outParam.idx = 2; outParam.data = inData[2]; }
    else if (gl_TessCoord.xyz == vec3(1.0,0.0,0.0)) {outParam.idx = 0; outParam.data = inData[0]; }
    else if (gl_TessCoord.xyz == vec3(0.0,0.0,1.0)) {outParam.idx = 1; outParam.data = inData[1]; }
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require

struct DataStruct {dvec4 q;};

layout(location = 0) in  vec4 in_position;
layout(location = 0) out DataStruct data;

out gl_PerVertex
{
    vec4  gl_Position;
    float gl_PointSize;
};

void main()
{
    const int n  = gl_VertexIndex + 1;
    data         = DataStruct(dvec4(double(n), double(2*n), double(4*n), double(8*n)));
    gl_PointSize = 1.0;
    gl_Position  = in_position;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require

struct DataStruct {dvec4 q;};


layout(location = 0) out uvec4 out_color;

struct InDataStruct {uint idx; DataStruct data;};
layout(location = 0) pervertexEXT in InDataStruct inParam[];
void getData(uint i, out DataStruct ds)
{
    for(uint k = 0; k < 3; k++)
    {
        if (inParam[k].idx == i)
            ds = inParam[k].data;
    }
}
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = (x < y) ? 0 : 1;
    const bool even = (p%2 == 0);

    DataStruct eA; { const int n = 1 + (3*p); eA = DataStruct(dvec4(double(n), double(2*n), double(4*n), double(8*n))); }
    DataStruct eB; { const int n = 1 + (3*p+1); eB = DataStruct(dvec4(double(n), double(2*n), double(4*n), double(8*n))); }
    DataStruct eC; { const int n = 1 + (3*p+2); eC = DataStruct(dvec4(double(n), double(2*n), double(4*n), double(8*n))); }

    double e[12] = { eA.q.x,eA.q.y,eA.q.z,eA.q.w,eB.q.x,eB.q.y,eB.q.z,eB.q.w,eC.q.x,eC.q.y,eC.q.z,eC.q.w };

    DataStruct vA; { getData(0, vA); }
    DataStruct vB; { getData(1, vB); }
    DataStruct vC; { getData(2, vC); }

    double v[12] = { vA.q.x,vA.q.y,vA.q.z,vA.q.w,vB.q.x,vB.q.y,vB.q.z,vB.q.w,vC.q.x,vC.q.y,vC.q.z,vC.q.w };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<12; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_tessellation_shader : require
layout (vertices=6) out;
in gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
} gl_in[];
out gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
} gl_out[];

struct DataStruct {dvec4 q;};

layout (location=0) in DataStruct inData[];
layout (location=0) out DataStruct outData[];

void main (void)
{
    if (gl_InvocationID == 0)
    {
        gl_TessLevelInner[0] = 1.0;
        gl_TessLevelInner[1] = 1.0;
        gl_TessLevelOuter[0] = 1.0;
        gl_TessLevelOuter[1] = 1.0;
        gl_TessLevelOuter[2] = 1.0;
        gl_TessLevelOuter[3] = 1.0;
    }
    outData[gl_InvocationID] = inData[gl_InvocationID];
    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
}
#version 450
#extension GL_EXT_tessellation_shader : require
layout (triangles) in;
in gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
} gl_in[];
out gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
};

struct DataStruct {dvec4 q;};

layout (location=0) in DataStruct inData[];
struct OutDataStruct {uint idx; DataStruct data;};
layout (location=0) flat out OutDataStruct outParam;

void main (void)
{
    gl_Position = (gl_TessCoord.x * gl_in[0].gl_Position) +
                  (gl_TessCoord.y * gl_in[1].gl_Position) +
                  (gl_TessCoord.z * gl_in[2].gl_Position);
    if (gl_TessCoord.xyz == vec3(0.0,1.0,0.0)) {outParam.idx = 2; outParam.data = inData[2]; }
    else if (gl_TessCoord.xyz == vec3(1.0,0.0,0.0)) {outParam.idx = 0; outParam.data = inData[0]; }
    else if (gl_TessCoord.xyz == vec3(0.0,0.0,1.0)) {outParam.idx = 1; outParam.data = inData[1]; }
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require

struct DataStruct {int q;};

layout(location = 0) in  vec4 in_position;
layout(location = 0) out DataStruct data;

out gl_PerVertex
{
    vec4  gl_Position;
    float gl_PointSize;
};

void main()
{
    const int n  = gl_VertexIndex + 1;
    data         = DataStruct(int(n));
    gl_PointSize = 1.0;
    gl_Position  = in_position;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require

struct DataStruct {int q;};


layout(location = 0) out uvec4 out_color;

struct InDataStruct {uint idx; DataStruct data;};
layout(location = 0) pervertexEXT in InDataStruct inParam[];
void getData(uint i, out DataStruct ds)
{
    for(uint k = 0; k < 3; k++)
    {
        if (inParam[k].idx == i)
            ds = inParam[k].data;
    }
}
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = (x < y) ? 0 : 1;
    const bool even = (p%2 == 0);

    DataStruct eA; { const int n = 1 + (3*p); eA = DataStruct(int(n)); }
    DataStruct eB; { const int n = 1 + (3*p+1); eB = DataStruct(int(n)); }
    DataStruct eC; { const int n = 1 + (3*p+2); eC = DataStruct(int(n)); }

    int e[3] = { eA.q,eB.q,eC.q };

    DataStruct vA; { getData(0, vA); }
    DataStruct vB; { getData(1, vB); }
    DataStruct vC; { getData(2, vC); }

    int v[3] = { vA.q,vB.q,vC.q };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<3; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_tessellation_shader : require
layout (vertices=6) out;
in gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
} gl_in[];
out gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
} gl_out[];

struct DataStruct {int q;};

layout (location=0) in DataStruct inData[];
layout (location=0) out DataStruct outData[];

void main (void)
{
    if (gl_InvocationID == 0)
    {
        gl_TessLevelInner[0] = 1.0;
        gl_TessLevelInner[1] = 1.0;
        gl_TessLevelOuter[0] = 1.0;
        gl_TessLevelOuter[1] = 1.0;
        gl_TessLevelOuter[2] = 1.0;
        gl_TessLevelOuter[3] = 1.0;
    }
    outData[gl_InvocationID] = inData[gl_InvocationID];
    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
}
#version 450
#extension GL_EXT_tessellation_shader : require
layout (triangles) in;
in gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
} gl_in[];
out gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
};

struct DataStruct {int q;};

layout (location=0) in DataStruct inData[];
struct OutDataStruct {uint idx; DataStruct data;};
layout (location=0) flat out OutDataStruct outParam;

void main (void)
{
    gl_Position = (gl_TessCoord.x * gl_in[0].gl_Position) +
                  (gl_TessCoord.y * gl_in[1].gl_Position) +
                  (gl_TessCoord.z * gl_in[2].gl_Position);
    if (gl_TessCoord.xyz == vec3(0.0,1.0,0.0)) {outParam.idx = 2; outParam.data = inData[2]; }
    else if (gl_TessCoord.xyz == vec3(1.0,0.0,0.0)) {outParam.idx = 0; outParam.data = inData[0]; }
    else if (gl_TessCoord.xyz == vec3(0.0,0.0,1.0)) {outParam.idx = 1; outParam.data = inData[1]; }
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require

struct DataStruct {ivec2 q;};

layout(location = 0) in  vec4 in_position;
layout(location = 0) out DataStruct data;

out gl_PerVertex
{
    vec4  gl_Position;
    float gl_PointSize;
};

void main()
{
    const int n  = gl_VertexIndex + 1;
    data         = DataStruct(ivec2(int(n), int(2*n)));
    gl_PointSize = 1.0;
    gl_Position  = in_position;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require

struct DataStruct {ivec2 q;};


layout(location = 0) out uvec4 out_color;

struct InDataStruct {uint idx; DataStruct data;};
layout(location = 0) pervertexEXT in InDataStruct inParam[];
void getData(uint i, out DataStruct ds)
{
    for(uint k = 0; k < 3; k++)
    {
        if (inParam[k].idx == i)
            ds = inParam[k].data;
    }
}
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = (x < y) ? 0 : 1;
    const bool even = (p%2 == 0);

    DataStruct eA; { const int n = 1 + (3*p); eA = DataStruct(ivec2(int(n), int(2*n))); }
    DataStruct eB; { const int n = 1 + (3*p+1); eB = DataStruct(ivec2(int(n), int(2*n))); }
    DataStruct eC; { const int n = 1 + (3*p+2); eC = DataStruct(ivec2(int(n), int(2*n))); }

    int e[6] = { eA.q.x,eA.q.y,eB.q.x,eB.q.y,eC.q.x,eC.q.y };

    DataStruct vA; { getData(0, vA); }
    DataStruct vB; { getData(1, vB); }
    DataStruct vC; { getData(2, vC); }

    int v[6] = { vA.q.x,vA.q.y,vB.q.x,vB.q.y,vC.q.x,vC.q.y };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<6; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_tessellation_shader : require
layout (vertices=6) out;
in gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
} gl_in[];
out gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
} gl_out[];

struct DataStruct {ivec2 q;};

layout (location=0) in DataStruct inData[];
layout (location=0) out DataStruct outData[];

void main (void)
{
    if (gl_InvocationID == 0)
    {
        gl_TessLevelInner[0] = 1.0;
        gl_TessLevelInner[1] = 1.0;
        gl_TessLevelOuter[0] = 1.0;
        gl_TessLevelOuter[1] = 1.0;
        gl_TessLevelOuter[2] = 1.0;
        gl_TessLevelOuter[3] = 1.0;
    }
    outData[gl_InvocationID] = inData[gl_InvocationID];
    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
}
#version 450
#extension GL_EXT_tessellation_shader : require
layout (triangles) in;
in gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
} gl_in[];
out gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
};

struct DataStruct {ivec2 q;};

layout (location=0) in DataStruct inData[];
struct OutDataStruct {uint idx; DataStruct data;};
layout (location=0) flat out OutDataStruct outParam;

void main (void)
{
    gl_Position = (gl_TessCoord.x * gl_in[0].gl_Position) +
                  (gl_TessCoord.y * gl_in[1].gl_Position) +
                  (gl_TessCoord.z * gl_in[2].gl_Position);
    if (gl_TessCoord.xyz == vec3(0.0,1.0,0.0)) {outParam.idx = 2; outParam.data = inData[2]; }
    else if (gl_TessCoord.xyz == vec3(1.0,0.0,0.0)) {outParam.idx = 0; outParam.data = inData[0]; }
    else if (gl_TessCoord.xyz == vec3(0.0,0.0,1.0)) {outParam.idx = 1; outParam.data = inData[1]; }
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require

struct DataStruct {ivec3 q;};

layout(location = 0) in  vec4 in_position;
layout(location = 0) out DataStruct data;

out gl_PerVertex
{
    vec4  gl_Position;
    float gl_PointSize;
};

void main()
{
    const int n  = gl_VertexIndex + 1;
    data         = DataStruct(ivec3(int(n), int(2*n), int(4*n)));
    gl_PointSize = 1.0;
    gl_Position  = in_position;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require

struct DataStruct {ivec3 q;};


layout(location = 0) out uvec4 out_color;

struct InDataStruct {uint idx; DataStruct data;};
layout(location = 0) pervertexEXT in InDataStruct inParam[];
void getData(uint i, out DataStruct ds)
{
    for(uint k = 0; k < 3; k++)
    {
        if (inParam[k].idx == i)
            ds = inParam[k].data;
    }
}
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = (x < y) ? 0 : 1;
    const bool even = (p%2 == 0);

    DataStruct eA; { const int n = 1 + (3*p); eA = DataStruct(ivec3(int(n), int(2*n), int(4*n))); }
    DataStruct eB; { const int n = 1 + (3*p+1); eB = DataStruct(ivec3(int(n), int(2*n), int(4*n))); }
    DataStruct eC; { const int n = 1 + (3*p+2); eC = DataStruct(ivec3(int(n), int(2*n), int(4*n))); }

    int e[9] = { eA.q.x,eA.q.y,eA.q.z,eB.q.x,eB.q.y,eB.q.z,eC.q.x,eC.q.y,eC.q.z };

    DataStruct vA; { getData(0, vA); }
    DataStruct vB; { getData(1, vB); }
    DataStruct vC; { getData(2, vC); }

    int v[9] = { vA.q.x,vA.q.y,vA.q.z,vB.q.x,vB.q.y,vB.q.z,vC.q.x,vC.q.y,vC.q.z };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<9; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_tessellation_shader : require
layout (vertices=6) out;
in gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
} gl_in[];
out gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
} gl_out[];

struct DataStruct {ivec3 q;};

layout (location=0) in DataStruct inData[];
layout (location=0) out DataStruct outData[];

void main (void)
{
    if (gl_InvocationID == 0)
    {
        gl_TessLevelInner[0] = 1.0;
        gl_TessLevelInner[1] = 1.0;
        gl_TessLevelOuter[0] = 1.0;
        gl_TessLevelOuter[1] = 1.0;
        gl_TessLevelOuter[2] = 1.0;
        gl_TessLevelOuter[3] = 1.0;
    }
    outData[gl_InvocationID] = inData[gl_InvocationID];
    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
}
#version 450
#extension GL_EXT_tessellation_shader : require
layout (triangles) in;
in gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
} gl_in[];
out gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
};

struct DataStruct {ivec3 q;};

layout (location=0) in DataStruct inData[];
struct OutDataStruct {uint idx; DataStruct data;};
layout (location=0) flat out OutDataStruct outParam;

void main (void)
{
    gl_Position = (gl_TessCoord.x * gl_in[0].gl_Position) +
                  (gl_TessCoord.y * gl_in[1].gl_Position) +
                  (gl_TessCoord.z * gl_in[2].gl_Position);
    if (gl_TessCoord.xyz == vec3(0.0,1.0,0.0)) {outParam.idx = 2; outParam.data = inData[2]; }
    else if (gl_TessCoord.xyz == vec3(1.0,0.0,0.0)) {outParam.idx = 0; outParam.data = inData[0]; }
    else if (gl_TessCoord.xyz == vec3(0.0,0.0,1.0)) {outParam.idx = 1; outParam.data = inData[1]; }
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require

struct DataStruct {ivec4 q;};

layout(location = 0) in  vec4 in_position;
layout(location = 0) out DataStruct data;

out gl_PerVertex
{
    vec4  gl_Position;
    float gl_PointSize;
};

void main()
{
    const int n  = gl_VertexIndex + 1;
    data         = DataStruct(ivec4(int(n), int(2*n), int(4*n), int(8*n)));
    gl_PointSize = 1.0;
    gl_Position  = in_position;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require

struct DataStruct {ivec4 q;};


layout(location = 0) out uvec4 out_color;

struct InDataStruct {uint idx; DataStruct data;};
layout(location = 0) pervertexEXT in InDataStruct inParam[];
void getData(uint i, out DataStruct ds)
{
    for(uint k = 0; k < 3; k++)
    {
        if (inParam[k].idx == i)
            ds = inParam[k].data;
    }
}
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = (x < y) ? 0 : 1;
    const bool even = (p%2 == 0);

    DataStruct eA; { const int n = 1 + (3*p); eA = DataStruct(ivec4(int(n), int(2*n), int(4*n), int(8*n))); }
    DataStruct eB; { const int n = 1 + (3*p+1); eB = DataStruct(ivec4(int(n), int(2*n), int(4*n), int(8*n))); }
    DataStruct eC; { const int n = 1 + (3*p+2); eC = DataStruct(ivec4(int(n), int(2*n), int(4*n), int(8*n))); }

    int e[12] = { eA.q.x,eA.q.y,eA.q.z,eA.q.w,eB.q.x,eB.q.y,eB.q.z,eB.q.w,eC.q.x,eC.q.y,eC.q.z,eC.q.w };

    DataStruct vA; { getData(0, vA); }
    DataStruct vB; { getData(1, vB); }
    DataStruct vC; { getData(2, vC); }

    int v[12] = { vA.q.x,vA.q.y,vA.q.z,vA.q.w,vB.q.x,vB.q.y,vB.q.z,vB.q.w,vC.q.x,vC.q.y,vC.q.z,vC.q.w };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<12; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_tessellation_shader : require
layout (vertices=6) out;
in gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
} gl_in[];
out gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
} gl_out[];

struct DataStruct {ivec4 q;};

layout (location=0) in DataStruct inData[];
layout (location=0) out DataStruct outData[];

void main (void)
{
    if (gl_InvocationID == 0)
    {
        gl_TessLevelInner[0] = 1.0;
        gl_TessLevelInner[1] = 1.0;
        gl_TessLevelOuter[0] = 1.0;
        gl_TessLevelOuter[1] = 1.0;
        gl_TessLevelOuter[2] = 1.0;
        gl_TessLevelOuter[3] = 1.0;
    }
    outData[gl_InvocationID] = inData[gl_InvocationID];
    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
}
#version 450
#extension GL_EXT_tessellation_shader : require
layout (triangles) in;
in gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
} gl_in[];
out gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
};

struct DataStruct {ivec4 q;};

layout (location=0) in DataStruct inData[];
struct OutDataStruct {uint idx; DataStruct data;};
layout (location=0) flat out OutDataStruct outParam;

void main (void)
{
    gl_Position = (gl_TessCoord.x * gl_in[0].gl_Position) +
                  (gl_TessCoord.y * gl_in[1].gl_Position) +
                  (gl_TessCoord.z * gl_in[2].gl_Position);
    if (gl_TessCoord.xyz == vec3(0.0,1.0,0.0)) {outParam.idx = 2; outParam.data = inData[2]; }
    else if (gl_TessCoord.xyz == vec3(1.0,0.0,0.0)) {outParam.idx = 0; outParam.data = inData[0]; }
    else if (gl_TessCoord.xyz == vec3(0.0,0.0,1.0)) {outParam.idx = 1; outParam.data = inData[1]; }
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require

struct DataStruct {uint q;};

layout(location = 0) in  vec4 in_position;
layout(location = 0) out DataStruct data;

out gl_PerVertex
{
    vec4  gl_Position;
    float gl_PointSize;
};

void main()
{
    const int n  = gl_VertexIndex + 1;
    data         = DataStruct(uint(n));
    gl_PointSize = 1.0;
    gl_Position  = in_position;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require

struct DataStruct {uint q;};


layout(location = 0) out uvec4 out_color;

struct InDataStruct {uint idx; DataStruct data;};
layout(location = 0) pervertexEXT in InDataStruct inParam[];
void getData(uint i, out DataStruct ds)
{
    for(uint k = 0; k < 3; k++)
    {
        if (inParam[k].idx == i)
            ds = inParam[k].data;
    }
}
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = (x < y) ? 0 : 1;
    const bool even = (p%2 == 0);

    DataStruct eA; { const int n = 1 + (3*p); eA = DataStruct(uint(n)); }
    DataStruct eB; { const int n = 1 + (3*p+1); eB = DataStruct(uint(n)); }
    DataStruct eC; { const int n = 1 + (3*p+2); eC = DataStruct(uint(n)); }

    uint e[3] = { eA.q,eB.q,eC.q };

    DataStruct vA; { getData(0, vA); }
    DataStruct vB; { getData(1, vB); }
    DataStruct vC; { getData(2, vC); }

    uint v[3] = { vA.q,vB.q,vC.q };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<3; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_tessellation_shader : require
layout (vertices=6) out;
in gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
} gl_in[];
out gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
} gl_out[];

struct DataStruct {uint q;};

layout (location=0) in DataStruct inData[];
layout (location=0) out DataStruct outData[];

void main (void)
{
    if (gl_InvocationID == 0)
    {
        gl_TessLevelInner[0] = 1.0;
        gl_TessLevelInner[1] = 1.0;
        gl_TessLevelOuter[0] = 1.0;
        gl_TessLevelOuter[1] = 1.0;
        gl_TessLevelOuter[2] = 1.0;
        gl_TessLevelOuter[3] = 1.0;
    }
    outData[gl_InvocationID] = inData[gl_InvocationID];
    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
}
#version 450
#extension GL_EXT_tessellation_shader : require
layout (triangles) in;
in gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
} gl_in[];
out gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
};

struct DataStruct {uint q;};

layout (location=0) in DataStruct inData[];
struct OutDataStruct {uint idx; DataStruct data;};
layout (location=0) flat out OutDataStruct outParam;

void main (void)
{
    gl_Position = (gl_TessCoord.x * gl_in[0].gl_Position) +
                  (gl_TessCoord.y * gl_in[1].gl_Position) +
                  (gl_TessCoord.z * gl_in[2].gl_Position);
    if (gl_TessCoord.xyz == vec3(0.0,1.0,0.0)) {outParam.idx = 2; outParam.data = inData[2]; }
    else if (gl_TessCoord.xyz == vec3(1.0,0.0,0.0)) {outParam.idx = 0; outParam.data = inData[0]; }
    else if (gl_TessCoord.xyz == vec3(0.0,0.0,1.0)) {outParam.idx = 1; outParam.data = inData[1]; }
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require

struct DataStruct {uvec2 q;};

layout(location = 0) in  vec4 in_position;
layout(location = 0) out DataStruct data;

out gl_PerVertex
{
    vec4  gl_Position;
    float gl_PointSize;
};

void main()
{
    const int n  = gl_VertexIndex + 1;
    data         = DataStruct(uvec2(uint(n), uint(2*n)));
    gl_PointSize = 1.0;
    gl_Position  = in_position;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require

struct DataStruct {uvec2 q;};


layout(location = 0) out uvec4 out_color;

struct InDataStruct {uint idx; DataStruct data;};
layout(location = 0) pervertexEXT in InDataStruct inParam[];
void getData(uint i, out DataStruct ds)
{
    for(uint k = 0; k < 3; k++)
    {
        if (inParam[k].idx == i)
            ds = inParam[k].data;
    }
}
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = (x < y) ? 0 : 1;
    const bool even = (p%2 == 0);

    DataStruct eA; { const int n = 1 + (3*p); eA = DataStruct(uvec2(uint(n), uint(2*n))); }
    DataStruct eB; { const int n = 1 + (3*p+1); eB = DataStruct(uvec2(uint(n), uint(2*n))); }
    DataStruct eC; { const int n = 1 + (3*p+2); eC = DataStruct(uvec2(uint(n), uint(2*n))); }

    uint e[6] = { eA.q.x,eA.q.y,eB.q.x,eB.q.y,eC.q.x,eC.q.y };

    DataStruct vA; { getData(0, vA); }
    DataStruct vB; { getData(1, vB); }
    DataStruct vC; { getData(2, vC); }

    uint v[6] = { vA.q.x,vA.q.y,vB.q.x,vB.q.y,vC.q.x,vC.q.y };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<6; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_tessellation_shader : require
layout (vertices=6) out;
in gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
} gl_in[];
out gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
} gl_out[];

struct DataStruct {uvec2 q;};

layout (location=0) in DataStruct inData[];
layout (location=0) out DataStruct outData[];

void main (void)
{
    if (gl_InvocationID == 0)
    {
        gl_TessLevelInner[0] = 1.0;
        gl_TessLevelInner[1] = 1.0;
        gl_TessLevelOuter[0] = 1.0;
        gl_TessLevelOuter[1] = 1.0;
        gl_TessLevelOuter[2] = 1.0;
        gl_TessLevelOuter[3] = 1.0;
    }
    outData[gl_InvocationID] = inData[gl_InvocationID];
    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
}
#version 450
#extension GL_EXT_tessellation_shader : require
layout (triangles) in;
in gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
} gl_in[];
out gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
};

struct DataStruct {uvec2 q;};

layout (location=0) in DataStruct inData[];
struct OutDataStruct {uint idx; DataStruct data;};
layout (location=0) flat out OutDataStruct outParam;

void main (void)
{
    gl_Position = (gl_TessCoord.x * gl_in[0].gl_Position) +
                  (gl_TessCoord.y * gl_in[1].gl_Position) +
                  (gl_TessCoord.z * gl_in[2].gl_Position);
    if (gl_TessCoord.xyz == vec3(0.0,1.0,0.0)) {outParam.idx = 2; outParam.data = inData[2]; }
    else if (gl_TessCoord.xyz == vec3(1.0,0.0,0.0)) {outParam.idx = 0; outParam.data = inData[0]; }
    else if (gl_TessCoord.xyz == vec3(0.0,0.0,1.0)) {outParam.idx = 1; outParam.data = inData[1]; }
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require

struct DataStruct {uvec3 q;};

layout(location = 0) in  vec4 in_position;
layout(location = 0) out DataStruct data;

out gl_PerVertex
{
    vec4  gl_Position;
    float gl_PointSize;
};

void main()
{
    const int n  = gl_VertexIndex + 1;
    data         = DataStruct(uvec3(uint(n), uint(2*n), uint(4*n)));
    gl_PointSize = 1.0;
    gl_Position  = in_position;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require

struct DataStruct {uvec3 q;};


layout(location = 0) out uvec4 out_color;

struct InDataStruct {uint idx; DataStruct data;};
layout(location = 0) pervertexEXT in InDataStruct inParam[];
void getData(uint i, out DataStruct ds)
{
    for(uint k = 0; k < 3; k++)
    {
        if (inParam[k].idx == i)
            ds = inParam[k].data;
    }
}
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = (x < y) ? 0 : 1;
    const bool even = (p%2 == 0);

    DataStruct eA; { const int n = 1 + (3*p); eA = DataStruct(uvec3(uint(n), uint(2*n), uint(4*n))); }
    DataStruct eB; { const int n = 1 + (3*p+1); eB = DataStruct(uvec3(uint(n), uint(2*n), uint(4*n))); }
    DataStruct eC; { const int n = 1 + (3*p+2); eC = DataStruct(uvec3(uint(n), uint(2*n), uint(4*n))); }

    uint e[9] = { eA.q.x,eA.q.y,eA.q.z,eB.q.x,eB.q.y,eB.q.z,eC.q.x,eC.q.y,eC.q.z };

    DataStruct vA; { getData(0, vA); }
    DataStruct vB; { getData(1, vB); }
    DataStruct vC; { getData(2, vC); }

    uint v[9] = { vA.q.x,vA.q.y,vA.q.z,vB.q.x,vB.q.y,vB.q.z,vC.q.x,vC.q.y,vC.q.z };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<9; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_tessellation_shader : require
layout (vertices=6) out;
in gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
} gl_in[];
out gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
} gl_out[];

struct DataStruct {uvec3 q;};

layout (location=0) in DataStruct inData[];
layout (location=0) out DataStruct outData[];

void main (void)
{
    if (gl_InvocationID == 0)
    {
        gl_TessLevelInner[0] = 1.0;
        gl_TessLevelInner[1] = 1.0;
        gl_TessLevelOuter[0] = 1.0;
        gl_TessLevelOuter[1] = 1.0;
        gl_TessLevelOuter[2] = 1.0;
        gl_TessLevelOuter[3] = 1.0;
    }
    outData[gl_InvocationID] = inData[gl_InvocationID];
    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
}
#version 450
#extension GL_EXT_tessellation_shader : require
layout (triangles) in;
in gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
} gl_in[];
out gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
};

struct DataStruct {uvec3 q;};

layout (location=0) in DataStruct inData[];
struct OutDataStruct {uint idx; DataStruct data;};
layout (location=0) flat out OutDataStruct outParam;

void main (void)
{
    gl_Position = (gl_TessCoord.x * gl_in[0].gl_Position) +
                  (gl_TessCoord.y * gl_in[1].gl_Position) +
                  (gl_TessCoord.z * gl_in[2].gl_Position);
    if (gl_TessCoord.xyz == vec3(0.0,1.0,0.0)) {outParam.idx = 2; outParam.data = inData[2]; }
    else if (gl_TessCoord.xyz == vec3(1.0,0.0,0.0)) {outParam.idx = 0; outParam.data = inData[0]; }
    else if (gl_TessCoord.xyz == vec3(0.0,0.0,1.0)) {outParam.idx = 1; outParam.data = inData[1]; }
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require

struct DataStruct {uvec4 q;};

layout(location = 0) in  vec4 in_position;
layout(location = 0) out DataStruct data;

out gl_PerVertex
{
    vec4  gl_Position;
    float gl_PointSize;
};

void main()
{
    const int n  = gl_VertexIndex + 1;
    data         = DataStruct(uvec4(uint(n), uint(2*n), uint(4*n), uint(8*n)));
    gl_PointSize = 1.0;
    gl_Position  = in_position;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require

struct DataStruct {uvec4 q;};


layout(location = 0) out uvec4 out_color;

struct InDataStruct {uint idx; DataStruct data;};
layout(location = 0) pervertexEXT in InDataStruct inParam[];
void getData(uint i, out DataStruct ds)
{
    for(uint k = 0; k < 3; k++)
    {
        if (inParam[k].idx == i)
            ds = inParam[k].data;
    }
}
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = (x < y) ? 0 : 1;
    const bool even = (p%2 == 0);

    DataStruct eA; { const int n = 1 + (3*p); eA = DataStruct(uvec4(uint(n), uint(2*n), uint(4*n), uint(8*n))); }
    DataStruct eB; { const int n = 1 + (3*p+1); eB = DataStruct(uvec4(uint(n), uint(2*n), uint(4*n), uint(8*n))); }
    DataStruct eC; { const int n = 1 + (3*p+2); eC = DataStruct(uvec4(uint(n), uint(2*n), uint(4*n), uint(8*n))); }

    uint e[12] = { eA.q.x,eA.q.y,eA.q.z,eA.q.w,eB.q.x,eB.q.y,eB.q.z,eB.q.w,eC.q.x,eC.q.y,eC.q.z,eC.q.w };

    DataStruct vA; { getData(0, vA); }
    DataStruct vB; { getData(1, vB); }
    DataStruct vC; { getData(2, vC); }

    uint v[12] = { vA.q.x,vA.q.y,vA.q.z,vA.q.w,vB.q.x,vB.q.y,vB.q.z,vB.q.w,vC.q.x,vC.q.y,vC.q.z,vC.q.w };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<12; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_tessellation_shader : require
layout (vertices=6) out;
in gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
} gl_in[];
out gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
} gl_out[];

struct DataStruct {uvec4 q;};

layout (location=0) in DataStruct inData[];
layout (location=0) out DataStruct outData[];

void main (void)
{
    if (gl_InvocationID == 0)
    {
        gl_TessLevelInner[0] = 1.0;
        gl_TessLevelInner[1] = 1.0;
        gl_TessLevelOuter[0] = 1.0;
        gl_TessLevelOuter[1] = 1.0;
        gl_TessLevelOuter[2] = 1.0;
        gl_TessLevelOuter[3] = 1.0;
    }
    outData[gl_InvocationID] = inData[gl_InvocationID];
    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
}
#version 450
#extension GL_EXT_tessellation_shader : require
layout (triangles) in;
in gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
} gl_in[];
out gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
};

struct DataStruct {uvec4 q;};

layout (location=0) in DataStruct inData[];
struct OutDataStruct {uint idx; DataStruct data;};
layout (location=0) flat out OutDataStruct outParam;

void main (void)
{
    gl_Position = (gl_TessCoord.x * gl_in[0].gl_Position) +
                  (gl_TessCoord.y * gl_in[1].gl_Position) +
                  (gl_TessCoord.z * gl_in[2].gl_Position);
    if (gl_TessCoord.xyz == vec3(0.0,1.0,0.0)) {outParam.idx = 2; outParam.data = inData[2]; }
    else if (gl_TessCoord.xyz == vec3(1.0,0.0,0.0)) {outParam.idx = 0; outParam.data = inData[0]; }
    else if (gl_TessCoord.xyz == vec3(0.0,0.0,1.0)) {outParam.idx = 1; outParam.data = inData[1]; }
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require



layout(location = 0) in  vec4 in_position;
layout(location = 0) out float data[2];

out gl_PerVertex
{
    vec4  gl_Position;
    float gl_PointSize;
};

void main()
{
    const int n  = gl_VertexIndex + 1;
    data         = float[2](float(n), float(3)*float(n));
    gl_PointSize = 1.0;
    gl_Position  = in_position;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require




layout(location = 0) out uvec4 out_color;

struct InDataStruct {uint idx; float data[2];};
layout(location = 0) pervertexEXT in InDataStruct inParam[];
void getData(uint i, out float ds[2])
{
    for(uint k = 0; k < 3; k++)
    {
        if (inParam[k].idx == i)
            ds = float[2](inParam[k].data[0],inParam[k].data[1]);
    }
}
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = (x < y) ? 0 : 1;
    const bool even = (p%2 == 0);

    float eA[2]; { const int n = 1 + (3*p); eA = float[2](float(n), float(3)*float(n)); }
    float eB[2]; { const int n = 1 + (3*p+1); eB = float[2](float(n), float(3)*float(n)); }
    float eC[2]; { const int n = 1 + (3*p+2); eC = float[2](float(n), float(3)*float(n)); }

    float e[6] = { eA[0],eA[1],eB[0],eB[1],eC[0],eC[1] };

    float vA[2]; { getData(0, vA); }
    float vB[2]; { getData(1, vB); }
    float vC[2]; { getData(2, vC); }

    float v[6] = { vA[0],vA[1],vB[0],vB[1],vC[0],vC[1] };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<6; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_tessellation_shader : require
layout (vertices=6) out;
in gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
} gl_in[];
out gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
} gl_out[];



layout (location=0) in float inData[][2];
layout (location=0) out float outData[][2];

void main (void)
{
    if (gl_InvocationID == 0)
    {
        gl_TessLevelInner[0] = 1.0;
        gl_TessLevelInner[1] = 1.0;
        gl_TessLevelOuter[0] = 1.0;
        gl_TessLevelOuter[1] = 1.0;
        gl_TessLevelOuter[2] = 1.0;
        gl_TessLevelOuter[3] = 1.0;
    }
    outData[gl_InvocationID] = inData[gl_InvocationID];
    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
}
#version 450
#extension GL_EXT_tessellation_shader : require
layout (triangles) in;
in gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
} gl_in[];
out gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
};



layout (location=0) in float inData[][2];
struct OutDataStruct {uint idx; float data[2];};
layout (location=0) flat out OutDataStruct outParam;

void main (void)
{
    gl_Position = (gl_TessCoord.x * gl_in[0].gl_Position) +
                  (gl_TessCoord.y * gl_in[1].gl_Position) +
                  (gl_TessCoord.z * gl_in[2].gl_Position);
    if (gl_TessCoord.xyz == vec3(0.0,1.0,0.0)) {outParam.idx = 2; outParam.data = float[2](inData[2][0],inData[2][1]); }
    else if (gl_TessCoord.xyz == vec3(1.0,0.0,0.0)) {outParam.idx = 0; outParam.data = float[2](inData[0][0],inData[0][1]); }
    else if (gl_TessCoord.xyz == vec3(0.0,0.0,1.0)) {outParam.idx = 1; outParam.data = float[2](inData[1][0],inData[1][1]); }
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require



layout(location = 0) in  vec4 in_position;
layout(location = 0) out vec2 data[2];

out gl_PerVertex
{
    vec4  gl_Position;
    float gl_PointSize;
};

void main()
{
    const int n  = gl_VertexIndex + 1;
    data         = vec2[2](vec2(float(n), float(2*n)), float(3)*vec2(float(n), float(2*n)));
    gl_PointSize = 1.0;
    gl_Position  = in_position;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require




layout(location = 0) out uvec4 out_color;

struct InDataStruct {uint idx; vec2 data[2];};
layout(location = 0) pervertexEXT in InDataStruct inParam[];
void getData(uint i, out vec2 ds[2])
{
    for(uint k = 0; k < 3; k++)
    {
        if (inParam[k].idx == i)
            ds = vec2[2](inParam[k].data[0],inParam[k].data[1]);
    }
}
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = (x < y) ? 0 : 1;
    const bool even = (p%2 == 0);

    vec2 eA[2]; { const int n = 1 + (3*p); eA = vec2[2](vec2(float(n), float(2*n)), float(3)*vec2(float(n), float(2*n))); }
    vec2 eB[2]; { const int n = 1 + (3*p+1); eB = vec2[2](vec2(float(n), float(2*n)), float(3)*vec2(float(n), float(2*n))); }
    vec2 eC[2]; { const int n = 1 + (3*p+2); eC = vec2[2](vec2(float(n), float(2*n)), float(3)*vec2(float(n), float(2*n))); }

    float e[12] = { eA[0].x,eA[0].y,eA[1].x,eA[1].y,eB[0].x,eB[0].y,eB[1].x,eB[1].y,eC[0].x,eC[0].y,eC[1].x,eC[1].y };

    vec2 vA[2]; { getData(0, vA); }
    vec2 vB[2]; { getData(1, vB); }
    vec2 vC[2]; { getData(2, vC); }

    float v[12] = { vA[0].x,vA[0].y,vA[1].x,vA[1].y,vB[0].x,vB[0].y,vB[1].x,vB[1].y,vC[0].x,vC[0].y,vC[1].x,vC[1].y };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<12; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_tessellation_shader : require
layout (vertices=6) out;
in gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
} gl_in[];
out gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
} gl_out[];



layout (location=0) in vec2 inData[][2];
layout (location=0) out vec2 outData[][2];

void main (void)
{
    if (gl_InvocationID == 0)
    {
        gl_TessLevelInner[0] = 1.0;
        gl_TessLevelInner[1] = 1.0;
        gl_TessLevelOuter[0] = 1.0;
        gl_TessLevelOuter[1] = 1.0;
        gl_TessLevelOuter[2] = 1.0;
        gl_TessLevelOuter[3] = 1.0;
    }
    outData[gl_InvocationID] = inData[gl_InvocationID];
    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
}
#version 450
#extension GL_EXT_tessellation_shader : require
layout (triangles) in;
in gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
} gl_in[];
out gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
};



layout (location=0) in vec2 inData[][2];
struct OutDataStruct {uint idx; vec2 data[2];};
layout (location=0) flat out OutDataStruct outParam;

void main (void)
{
    gl_Position = (gl_TessCoord.x * gl_in[0].gl_Position) +
                  (gl_TessCoord.y * gl_in[1].gl_Position) +
                  (gl_TessCoord.z * gl_in[2].gl_Position);
    if (gl_TessCoord.xyz == vec3(0.0,1.0,0.0)) {outParam.idx = 2; outParam.data = vec2[2](inData[2][0],inData[2][1]); }
    else if (gl_TessCoord.xyz == vec3(1.0,0.0,0.0)) {outParam.idx = 0; outParam.data = vec2[2](inData[0][0],inData[0][1]); }
    else if (gl_TessCoord.xyz == vec3(0.0,0.0,1.0)) {outParam.idx = 1; outParam.data = vec2[2](inData[1][0],inData[1][1]); }
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require



layout(location = 0) in  vec4 in_position;
layout(location = 0) out vec3 data[2];

out gl_PerVertex
{
    vec4  gl_Position;
    float gl_PointSize;
};

void main()
{
    const int n  = gl_VertexIndex + 1;
    data         = vec3[2](vec3(float(n), float(2*n), float(4*n)), float(3)*vec3(float(n), float(2*n), float(4*n)));
    gl_PointSize = 1.0;
    gl_Position  = in_position;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require




layout(location = 0) out uvec4 out_color;

struct InDataStruct {uint idx; vec3 data[2];};
layout(location = 0) pervertexEXT in InDataStruct inParam[];
void getData(uint i, out vec3 ds[2])
{
    for(uint k = 0; k < 3; k++)
    {
        if (inParam[k].idx == i)
            ds = vec3[2](inParam[k].data[0],inParam[k].data[1]);
    }
}
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = (x < y) ? 0 : 1;
    const bool even = (p%2 == 0);

    vec3 eA[2]; { const int n = 1 + (3*p); eA = vec3[2](vec3(float(n), float(2*n), float(4*n)), float(3)*vec3(float(n), float(2*n), float(4*n))); }
    vec3 eB[2]; { const int n = 1 + (3*p+1); eB = vec3[2](vec3(float(n), float(2*n), float(4*n)), float(3)*vec3(float(n), float(2*n), float(4*n))); }
    vec3 eC[2]; { const int n = 1 + (3*p+2); eC = vec3[2](vec3(float(n), float(2*n), float(4*n)), float(3)*vec3(float(n), float(2*n), float(4*n))); }

    float e[18] = { eA[0].x,eA[0].y,eA[0].z,eA[1].x,eA[1].y,eA[1].z,eB[0].x,eB[0].y,eB[0].z,eB[1].x,eB[1].y,eB[1].z,eC[0].x,eC[0].y,eC[0].z,eC[1].x,eC[1].y,eC[1].z };

    vec3 vA[2]; { getData(0, vA); }
    vec3 vB[2]; { getData(1, vB); }
    vec3 vC[2]; { getData(2, vC); }

    float v[18] = { vA[0].x,vA[0].y,vA[0].z,vA[1].x,vA[1].y,vA[1].z,vB[0].x,vB[0].y,vB[0].z,vB[1].x,vB[1].y,vB[1].z,vC[0].x,vC[0].y,vC[0].z,vC[1].x,vC[1].y,vC[1].z };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<18; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_tessellation_shader : require
layout (vertices=6) out;
in gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
} gl_in[];
out gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
} gl_out[];



layout (location=0) in vec3 inData[][2];
layout (location=0) out vec3 outData[][2];

void main (void)
{
    if (gl_InvocationID == 0)
    {
        gl_TessLevelInner[0] = 1.0;
        gl_TessLevelInner[1] = 1.0;
        gl_TessLevelOuter[0] = 1.0;
        gl_TessLevelOuter[1] = 1.0;
        gl_TessLevelOuter[2] = 1.0;
        gl_TessLevelOuter[3] = 1.0;
    }
    outData[gl_InvocationID] = inData[gl_InvocationID];
    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
}
#version 450
#extension GL_EXT_tessellation_shader : require
layout (triangles) in;
in gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
} gl_in[];
out gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
};



layout (location=0) in vec3 inData[][2];
struct OutDataStruct {uint idx; vec3 data[2];};
layout (location=0) flat out OutDataStruct outParam;

void main (void)
{
    gl_Position = (gl_TessCoord.x * gl_in[0].gl_Position) +
                  (gl_TessCoord.y * gl_in[1].gl_Position) +
                  (gl_TessCoord.z * gl_in[2].gl_Position);
    if (gl_TessCoord.xyz == vec3(0.0,1.0,0.0)) {outParam.idx = 2; outParam.data = vec3[2](inData[2][0],inData[2][1]); }
    else if (gl_TessCoord.xyz == vec3(1.0,0.0,0.0)) {outParam.idx = 0; outParam.data = vec3[2](inData[0][0],inData[0][1]); }
    else if (gl_TessCoord.xyz == vec3(0.0,0.0,1.0)) {outParam.idx = 1; outParam.data = vec3[2](inData[1][0],inData[1][1]); }
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require



layout(location = 0) in  vec4 in_position;
layout(location = 0) out vec4 data[2];

out gl_PerVertex
{
    vec4  gl_Position;
    float gl_PointSize;
};

void main()
{
    const int n  = gl_VertexIndex + 1;
    data         = vec4[2](vec4(float(n), float(2*n), float(4*n), float(8*n)), float(3)*vec4(float(n), float(2*n), float(4*n), float(8*n)));
    gl_PointSize = 1.0;
    gl_Position  = in_position;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require




layout(location = 0) out uvec4 out_color;

struct InDataStruct {uint idx; vec4 data[2];};
layout(location = 0) pervertexEXT in InDataStruct inParam[];
void getData(uint i, out vec4 ds[2])
{
    for(uint k = 0; k < 3; k++)
    {
        if (inParam[k].idx == i)
            ds = vec4[2](inParam[k].data[0],inParam[k].data[1]);
    }
}
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = (x < y) ? 0 : 1;
    const bool even = (p%2 == 0);

    vec4 eA[2]; { const int n = 1 + (3*p); eA = vec4[2](vec4(float(n), float(2*n), float(4*n), float(8*n)), float(3)*vec4(float(n), float(2*n), float(4*n), float(8*n))); }
    vec4 eB[2]; { const int n = 1 + (3*p+1); eB = vec4[2](vec4(float(n), float(2*n), float(4*n), float(8*n)), float(3)*vec4(float(n), float(2*n), float(4*n), float(8*n))); }
    vec4 eC[2]; { const int n = 1 + (3*p+2); eC = vec4[2](vec4(float(n), float(2*n), float(4*n), float(8*n)), float(3)*vec4(float(n), float(2*n), float(4*n), float(8*n))); }

    float e[24] = { eA[0].x,eA[0].y,eA[0].z,eA[0].w,eA[1].x,eA[1].y,eA[1].z,eA[1].w,eB[0].x,eB[0].y,eB[0].z,eB[0].w,eB[1].x,eB[1].y,eB[1].z,eB[1].w,eC[0].x,eC[0].y,eC[0].z,eC[0].w,eC[1].x,eC[1].y,eC[1].z,eC[1].w };

    vec4 vA[2]; { getData(0, vA); }
    vec4 vB[2]; { getData(1, vB); }
    vec4 vC[2]; { getData(2, vC); }

    float v[24] = { vA[0].x,vA[0].y,vA[0].z,vA[0].w,vA[1].x,vA[1].y,vA[1].z,vA[1].w,vB[0].x,vB[0].y,vB[0].z,vB[0].w,vB[1].x,vB[1].y,vB[1].z,vB[1].w,vC[0].x,vC[0].y,vC[0].z,vC[0].w,vC[1].x,vC[1].y,vC[1].z,vC[1].w };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<24; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_tessellation_shader : require
layout (vertices=6) out;
in gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
} gl_in[];
out gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
} gl_out[];



layout (location=0) in vec4 inData[][2];
layout (location=0) out vec4 outData[][2];

void main (void)
{
    if (gl_InvocationID == 0)
    {
        gl_TessLevelInner[0] = 1.0;
        gl_TessLevelInner[1] = 1.0;
        gl_TessLevelOuter[0] = 1.0;
        gl_TessLevelOuter[1] = 1.0;
        gl_TessLevelOuter[2] = 1.0;
        gl_TessLevelOuter[3] = 1.0;
    }
    outData[gl_InvocationID] = inData[gl_InvocationID];
    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
}
#version 450
#extension GL_EXT_tessellation_shader : require
layout (triangles) in;
in gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
} gl_in[];
out gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
};



layout (location=0) in vec4 inData[][2];
struct OutDataStruct {uint idx; vec4 data[2];};
layout (location=0) flat out OutDataStruct outParam;

void main (void)
{
    gl_Position = (gl_TessCoord.x * gl_in[0].gl_Position) +
                  (gl_TessCoord.y * gl_in[1].gl_Position) +
                  (gl_TessCoord.z * gl_in[2].gl_Position);
    if (gl_TessCoord.xyz == vec3(0.0,1.0,0.0)) {outParam.idx = 2; outParam.data = vec4[2](inData[2][0],inData[2][1]); }
    else if (gl_TessCoord.xyz == vec3(1.0,0.0,0.0)) {outParam.idx = 0; outParam.data = vec4[2](inData[0][0],inData[0][1]); }
    else if (gl_TessCoord.xyz == vec3(0.0,0.0,1.0)) {outParam.idx = 1; outParam.data = vec4[2](inData[1][0],inData[1][1]); }
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require



layout(location = 0) in  vec4 in_position;
layout(location = 0) out double data[2];

out gl_PerVertex
{
    vec4  gl_Position;
    float gl_PointSize;
};

void main()
{
    const int n  = gl_VertexIndex + 1;
    data         = double[2](double(n), double(3)*double(n));
    gl_PointSize = 1.0;
    gl_Position  = in_position;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require




layout(location = 0) out uvec4 out_color;

struct InDataStruct {uint idx; double data[2];};
layout(location = 0) pervertexEXT in InDataStruct inParam[];
void getData(uint i, out double ds[2])
{
    for(uint k = 0; k < 3; k++)
    {
        if (inParam[k].idx == i)
            ds = double[2](inParam[k].data[0],inParam[k].data[1]);
    }
}
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = (x < y) ? 0 : 1;
    const bool even = (p%2 == 0);

    double eA[2]; { const int n = 1 + (3*p); eA = double[2](double(n), double(3)*double(n)); }
    double eB[2]; { const int n = 1 + (3*p+1); eB = double[2](double(n), double(3)*double(n)); }
    double eC[2]; { const int n = 1 + (3*p+2); eC = double[2](double(n), double(3)*double(n)); }

    double e[6] = { eA[0],eA[1],eB[0],eB[1],eC[0],eC[1] };

    double vA[2]; { getData(0, vA); }
    double vB[2]; { getData(1, vB); }
    double vC[2]; { getData(2, vC); }

    double v[6] = { vA[0],vA[1],vB[0],vB[1],vC[0],vC[1] };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<6; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_tessellation_shader : require
layout (vertices=6) out;
in gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
} gl_in[];
out gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
} gl_out[];



layout (location=0) in double inData[][2];
layout (location=0) out double outData[][2];

void main (void)
{
    if (gl_InvocationID == 0)
    {
        gl_TessLevelInner[0] = 1.0;
        gl_TessLevelInner[1] = 1.0;
        gl_TessLevelOuter[0] = 1.0;
        gl_TessLevelOuter[1] = 1.0;
        gl_TessLevelOuter[2] = 1.0;
        gl_TessLevelOuter[3] = 1.0;
    }
    outData[gl_InvocationID] = inData[gl_InvocationID];
    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
}
#version 450
#extension GL_EXT_tessellation_shader : require
layout (triangles) in;
in gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
} gl_in[];
out gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
};



layout (location=0) in double inData[][2];
struct OutDataStruct {uint idx; double data[2];};
layout (location=0) flat out OutDataStruct outParam;

void main (void)
{
    gl_Position = (gl_TessCoord.x * gl_in[0].gl_Position) +
                  (gl_TessCoord.y * gl_in[1].gl_Position) +
                  (gl_TessCoord.z * gl_in[2].gl_Position);
    if (gl_TessCoord.xyz == vec3(0.0,1.0,0.0)) {outParam.idx = 2; outParam.data = double[2](inData[2][0],inData[2][1]); }
    else if (gl_TessCoord.xyz == vec3(1.0,0.0,0.0)) {outParam.idx = 0; outParam.data = double[2](inData[0][0],inData[0][1]); }
    else if (gl_TessCoord.xyz == vec3(0.0,0.0,1.0)) {outParam.idx = 1; outParam.data = double[2](inData[1][0],inData[1][1]); }
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require



layout(location = 0) in  vec4 in_position;
layout(location = 0) out dvec2 data[2];

out gl_PerVertex
{
    vec4  gl_Position;
    float gl_PointSize;
};

void main()
{
    const int n  = gl_VertexIndex + 1;
    data         = dvec2[2](dvec2(double(n), double(2*n)), double(3)*dvec2(double(n), double(2*n)));
    gl_PointSize = 1.0;
    gl_Position  = in_position;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require




layout(location = 0) out uvec4 out_color;

struct InDataStruct {uint idx; dvec2 data[2];};
layout(location = 0) pervertexEXT in InDataStruct inParam[];
void getData(uint i, out dvec2 ds[2])
{
    for(uint k = 0; k < 3; k++)
    {
        if (inParam[k].idx == i)
            ds = dvec2[2](inParam[k].data[0],inParam[k].data[1]);
    }
}
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = (x < y) ? 0 : 1;
    const bool even = (p%2 == 0);

    dvec2 eA[2]; { const int n = 1 + (3*p); eA = dvec2[2](dvec2(double(n), double(2*n)), double(3)*dvec2(double(n), double(2*n))); }
    dvec2 eB[2]; { const int n = 1 + (3*p+1); eB = dvec2[2](dvec2(double(n), double(2*n)), double(3)*dvec2(double(n), double(2*n))); }
    dvec2 eC[2]; { const int n = 1 + (3*p+2); eC = dvec2[2](dvec2(double(n), double(2*n)), double(3)*dvec2(double(n), double(2*n))); }

    double e[12] = { eA[0].x,eA[0].y,eA[1].x,eA[1].y,eB[0].x,eB[0].y,eB[1].x,eB[1].y,eC[0].x,eC[0].y,eC[1].x,eC[1].y };

    dvec2 vA[2]; { getData(0, vA); }
    dvec2 vB[2]; { getData(1, vB); }
    dvec2 vC[2]; { getData(2, vC); }

    double v[12] = { vA[0].x,vA[0].y,vA[1].x,vA[1].y,vB[0].x,vB[0].y,vB[1].x,vB[1].y,vC[0].x,vC[0].y,vC[1].x,vC[1].y };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<12; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_tessellation_shader : require
layout (vertices=6) out;
in gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
} gl_in[];
out gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
} gl_out[];



layout (location=0) in dvec2 inData[][2];
layout (location=0) out dvec2 outData[][2];

void main (void)
{
    if (gl_InvocationID == 0)
    {
        gl_TessLevelInner[0] = 1.0;
        gl_TessLevelInner[1] = 1.0;
        gl_TessLevelOuter[0] = 1.0;
        gl_TessLevelOuter[1] = 1.0;
        gl_TessLevelOuter[2] = 1.0;
        gl_TessLevelOuter[3] = 1.0;
    }
    outData[gl_InvocationID] = inData[gl_InvocationID];
    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
}
#version 450
#extension GL_EXT_tessellation_shader : require
layout (triangles) in;
in gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
} gl_in[];
out gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
};



layout (location=0) in dvec2 inData[][2];
struct OutDataStruct {uint idx; dvec2 data[2];};
layout (location=0) flat out OutDataStruct outParam;

void main (void)
{
    gl_Position = (gl_TessCoord.x * gl_in[0].gl_Position) +
                  (gl_TessCoord.y * gl_in[1].gl_Position) +
                  (gl_TessCoord.z * gl_in[2].gl_Position);
    if (gl_TessCoord.xyz == vec3(0.0,1.0,0.0)) {outParam.idx = 2; outParam.data = dvec2[2](inData[2][0],inData[2][1]); }
    else if (gl_TessCoord.xyz == vec3(1.0,0.0,0.0)) {outParam.idx = 0; outParam.data = dvec2[2](inData[0][0],inData[0][1]); }
    else if (gl_TessCoord.xyz == vec3(0.0,0.0,1.0)) {outParam.idx = 1; outParam.data = dvec2[2](inData[1][0],inData[1][1]); }
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require



layout(location = 0) in  vec4 in_position;
layout(location = 0) out dvec3 data[2];

out gl_PerVertex
{
    vec4  gl_Position;
    float gl_PointSize;
};

void main()
{
    const int n  = gl_VertexIndex + 1;
    data         = dvec3[2](dvec3(double(n), double(2*n), double(4*n)), double(3)*dvec3(double(n), double(2*n), double(4*n)));
    gl_PointSize = 1.0;
    gl_Position  = in_position;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require




layout(location = 0) out uvec4 out_color;

struct InDataStruct {uint idx; dvec3 data[2];};
layout(location = 0) pervertexEXT in InDataStruct inParam[];
void getData(uint i, out dvec3 ds[2])
{
    for(uint k = 0; k < 3; k++)
    {
        if (inParam[k].idx == i)
            ds = dvec3[2](inParam[k].data[0],inParam[k].data[1]);
    }
}
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = (x < y) ? 0 : 1;
    const bool even = (p%2 == 0);

    dvec3 eA[2]; { const int n = 1 + (3*p); eA = dvec3[2](dvec3(double(n), double(2*n), double(4*n)), double(3)*dvec3(double(n), double(2*n), double(4*n))); }
    dvec3 eB[2]; { const int n = 1 + (3*p+1); eB = dvec3[2](dvec3(double(n), double(2*n), double(4*n)), double(3)*dvec3(double(n), double(2*n), double(4*n))); }
    dvec3 eC[2]; { const int n = 1 + (3*p+2); eC = dvec3[2](dvec3(double(n), double(2*n), double(4*n)), double(3)*dvec3(double(n), double(2*n), double(4*n))); }

    double e[18] = { eA[0].x,eA[0].y,eA[0].z,eA[1].x,eA[1].y,eA[1].z,eB[0].x,eB[0].y,eB[0].z,eB[1].x,eB[1].y,eB[1].z,eC[0].x,eC[0].y,eC[0].z,eC[1].x,eC[1].y,eC[1].z };

    dvec3 vA[2]; { getData(0, vA); }
    dvec3 vB[2]; { getData(1, vB); }
    dvec3 vC[2]; { getData(2, vC); }

    double v[18] = { vA[0].x,vA[0].y,vA[0].z,vA[1].x,vA[1].y,vA[1].z,vB[0].x,vB[0].y,vB[0].z,vB[1].x,vB[1].y,vB[1].z,vC[0].x,vC[0].y,vC[0].z,vC[1].x,vC[1].y,vC[1].z };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<18; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_tessellation_shader : require
layout (vertices=6) out;
in gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
} gl_in[];
out gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
} gl_out[];



layout (location=0) in dvec3 inData[][2];
layout (location=0) out dvec3 outData[][2];

void main (void)
{
    if (gl_InvocationID == 0)
    {
        gl_TessLevelInner[0] = 1.0;
        gl_TessLevelInner[1] = 1.0;
        gl_TessLevelOuter[0] = 1.0;
        gl_TessLevelOuter[1] = 1.0;
        gl_TessLevelOuter[2] = 1.0;
        gl_TessLevelOuter[3] = 1.0;
    }
    outData[gl_InvocationID] = inData[gl_InvocationID];
    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
}
#version 450
#extension GL_EXT_tessellation_shader : require
layout (triangles) in;
in gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
} gl_in[];
out gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
};



layout (location=0) in dvec3 inData[][2];
struct OutDataStruct {uint idx; dvec3 data[2];};
layout (location=0) flat out OutDataStruct outParam;

void main (void)
{
    gl_Position = (gl_TessCoord.x * gl_in[0].gl_Position) +
                  (gl_TessCoord.y * gl_in[1].gl_Position) +
                  (gl_TessCoord.z * gl_in[2].gl_Position);
    if (gl_TessCoord.xyz == vec3(0.0,1.0,0.0)) {outParam.idx = 2; outParam.data = dvec3[2](inData[2][0],inData[2][1]); }
    else if (gl_TessCoord.xyz == vec3(1.0,0.0,0.0)) {outParam.idx = 0; outParam.data = dvec3[2](inData[0][0],inData[0][1]); }
    else if (gl_TessCoord.xyz == vec3(0.0,0.0,1.0)) {outParam.idx = 1; outParam.data = dvec3[2](inData[1][0],inData[1][1]); }
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require



layout(location = 0) in  vec4 in_position;
layout(location = 0) out dvec4 data[2];

out gl_PerVertex
{
    vec4  gl_Position;
    float gl_PointSize;
};

void main()
{
    const int n  = gl_VertexIndex + 1;
    data         = dvec4[2](dvec4(double(n), double(2*n), double(4*n), double(8*n)), double(3)*dvec4(double(n), double(2*n), double(4*n), double(8*n)));
    gl_PointSize = 1.0;
    gl_Position  = in_position;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require




layout(location = 0) out uvec4 out_color;

struct InDataStruct {uint idx; dvec4 data[2];};
layout(location = 0) pervertexEXT in InDataStruct inParam[];
void getData(uint i, out dvec4 ds[2])
{
    for(uint k = 0; k < 3; k++)
    {
        if (inParam[k].idx == i)
            ds = dvec4[2](inParam[k].data[0],inParam[k].data[1]);
    }
}
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = (x < y) ? 0 : 1;
    const bool even = (p%2 == 0);

    dvec4 eA[2]; { const int n = 1 + (3*p); eA = dvec4[2](dvec4(double(n), double(2*n), double(4*n), double(8*n)), double(3)*dvec4(double(n), double(2*n), double(4*n), double(8*n))); }
    dvec4 eB[2]; { const int n = 1 + (3*p+1); eB = dvec4[2](dvec4(double(n), double(2*n), double(4*n), double(8*n)), double(3)*dvec4(double(n), double(2*n), double(4*n), double(8*n))); }
    dvec4 eC[2]; { const int n = 1 + (3*p+2); eC = dvec4[2](dvec4(double(n), double(2*n), double(4*n), double(8*n)), double(3)*dvec4(double(n), double(2*n), double(4*n), double(8*n))); }

    double e[24] = { eA[0].x,eA[0].y,eA[0].z,eA[0].w,eA[1].x,eA[1].y,eA[1].z,eA[1].w,eB[0].x,eB[0].y,eB[0].z,eB[0].w,eB[1].x,eB[1].y,eB[1].z,eB[1].w,eC[0].x,eC[0].y,eC[0].z,eC[0].w,eC[1].x,eC[1].y,eC[1].z,eC[1].w };

    dvec4 vA[2]; { getData(0, vA); }
    dvec4 vB[2]; { getData(1, vB); }
    dvec4 vC[2]; { getData(2, vC); }

    double v[24] = { vA[0].x,vA[0].y,vA[0].z,vA[0].w,vA[1].x,vA[1].y,vA[1].z,vA[1].w,vB[0].x,vB[0].y,vB[0].z,vB[0].w,vB[1].x,vB[1].y,vB[1].z,vB[1].w,vC[0].x,vC[0].y,vC[0].z,vC[0].w,vC[1].x,vC[1].y,vC[1].z,vC[1].w };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<24; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_tessellation_shader : require
layout (vertices=6) out;
in gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
} gl_in[];
out gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
} gl_out[];



layout (location=0) in dvec4 inData[][2];
layout (location=0) out dvec4 outData[][2];

void main (void)
{
    if (gl_InvocationID == 0)
    {
        gl_TessLevelInner[0] = 1.0;
        gl_TessLevelInner[1] = 1.0;
        gl_TessLevelOuter[0] = 1.0;
        gl_TessLevelOuter[1] = 1.0;
        gl_TessLevelOuter[2] = 1.0;
        gl_TessLevelOuter[3] = 1.0;
    }
    outData[gl_InvocationID] = inData[gl_InvocationID];
    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
}
#version 450
#extension GL_EXT_tessellation_shader : require
layout (triangles) in;
in gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
} gl_in[];
out gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
};



layout (location=0) in dvec4 inData[][2];
struct OutDataStruct {uint idx; dvec4 data[2];};
layout (location=0) flat out OutDataStruct outParam;

void main (void)
{
    gl_Position = (gl_TessCoord.x * gl_in[0].gl_Position) +
                  (gl_TessCoord.y * gl_in[1].gl_Position) +
                  (gl_TessCoord.z * gl_in[2].gl_Position);
    if (gl_TessCoord.xyz == vec3(0.0,1.0,0.0)) {outParam.idx = 2; outParam.data = dvec4[2](inData[2][0],inData[2][1]); }
    else if (gl_TessCoord.xyz == vec3(1.0,0.0,0.0)) {outParam.idx = 0; outParam.data = dvec4[2](inData[0][0],inData[0][1]); }
    else if (gl_TessCoord.xyz == vec3(0.0,0.0,1.0)) {outParam.idx = 1; outParam.data = dvec4[2](inData[1][0],inData[1][1]); }
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require



layout(location = 0) in  vec4 in_position;
layout(location = 0) out int data[2];

out gl_PerVertex
{
    vec4  gl_Position;
    float gl_PointSize;
};

void main()
{
    const int n  = gl_VertexIndex + 1;
    data         = int[2](int(n), int(3)*int(n));
    gl_PointSize = 1.0;
    gl_Position  = in_position;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require




layout(location = 0) out uvec4 out_color;

struct InDataStruct {uint idx; int data[2];};
layout(location = 0) pervertexEXT in InDataStruct inParam[];
void getData(uint i, out int ds[2])
{
    for(uint k = 0; k < 3; k++)
    {
        if (inParam[k].idx == i)
            ds = int[2](inParam[k].data[0],inParam[k].data[1]);
    }
}
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = (x < y) ? 0 : 1;
    const bool even = (p%2 == 0);

    int eA[2]; { const int n = 1 + (3*p); eA = int[2](int(n), int(3)*int(n)); }
    int eB[2]; { const int n = 1 + (3*p+1); eB = int[2](int(n), int(3)*int(n)); }
    int eC[2]; { const int n = 1 + (3*p+2); eC = int[2](int(n), int(3)*int(n)); }

    int e[6] = { eA[0],eA[1],eB[0],eB[1],eC[0],eC[1] };

    int vA[2]; { getData(0, vA); }
    int vB[2]; { getData(1, vB); }
    int vC[2]; { getData(2, vC); }

    int v[6] = { vA[0],vA[1],vB[0],vB[1],vC[0],vC[1] };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<6; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_tessellation_shader : require
layout (vertices=6) out;
in gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
} gl_in[];
out gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
} gl_out[];



layout (location=0) in int inData[][2];
layout (location=0) out int outData[][2];

void main (void)
{
    if (gl_InvocationID == 0)
    {
        gl_TessLevelInner[0] = 1.0;
        gl_TessLevelInner[1] = 1.0;
        gl_TessLevelOuter[0] = 1.0;
        gl_TessLevelOuter[1] = 1.0;
        gl_TessLevelOuter[2] = 1.0;
        gl_TessLevelOuter[3] = 1.0;
    }
    outData[gl_InvocationID] = inData[gl_InvocationID];
    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
}
#version 450
#extension GL_EXT_tessellation_shader : require
layout (triangles) in;
in gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
} gl_in[];
out gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
};



layout (location=0) in int inData[][2];
struct OutDataStruct {uint idx; int data[2];};
layout (location=0) flat out OutDataStruct outParam;

void main (void)
{
    gl_Position = (gl_TessCoord.x * gl_in[0].gl_Position) +
                  (gl_TessCoord.y * gl_in[1].gl_Position) +
                  (gl_TessCoord.z * gl_in[2].gl_Position);
    if (gl_TessCoord.xyz == vec3(0.0,1.0,0.0)) {outParam.idx = 2; outParam.data = int[2](inData[2][0],inData[2][1]); }
    else if (gl_TessCoord.xyz == vec3(1.0,0.0,0.0)) {outParam.idx = 0; outParam.data = int[2](inData[0][0],inData[0][1]); }
    else if (gl_TessCoord.xyz == vec3(0.0,0.0,1.0)) {outParam.idx = 1; outParam.data = int[2](inData[1][0],inData[1][1]); }
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require



layout(location = 0) in  vec4 in_position;
layout(location = 0) out ivec2 data[2];

out gl_PerVertex
{
    vec4  gl_Position;
    float gl_PointSize;
};

void main()
{
    const int n  = gl_VertexIndex + 1;
    data         = ivec2[2](ivec2(int(n), int(2*n)), int(3)*ivec2(int(n), int(2*n)));
    gl_PointSize = 1.0;
    gl_Position  = in_position;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require




layout(location = 0) out uvec4 out_color;

struct InDataStruct {uint idx; ivec2 data[2];};
layout(location = 0) pervertexEXT in InDataStruct inParam[];
void getData(uint i, out ivec2 ds[2])
{
    for(uint k = 0; k < 3; k++)
    {
        if (inParam[k].idx == i)
            ds = ivec2[2](inParam[k].data[0],inParam[k].data[1]);
    }
}
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = (x < y) ? 0 : 1;
    const bool even = (p%2 == 0);

    ivec2 eA[2]; { const int n = 1 + (3*p); eA = ivec2[2](ivec2(int(n), int(2*n)), int(3)*ivec2(int(n), int(2*n))); }
    ivec2 eB[2]; { const int n = 1 + (3*p+1); eB = ivec2[2](ivec2(int(n), int(2*n)), int(3)*ivec2(int(n), int(2*n))); }
    ivec2 eC[2]; { const int n = 1 + (3*p+2); eC = ivec2[2](ivec2(int(n), int(2*n)), int(3)*ivec2(int(n), int(2*n))); }

    int e[12] = { eA[0].x,eA[0].y,eA[1].x,eA[1].y,eB[0].x,eB[0].y,eB[1].x,eB[1].y,eC[0].x,eC[0].y,eC[1].x,eC[1].y };

    ivec2 vA[2]; { getData(0, vA); }
    ivec2 vB[2]; { getData(1, vB); }
    ivec2 vC[2]; { getData(2, vC); }

    int v[12] = { vA[0].x,vA[0].y,vA[1].x,vA[1].y,vB[0].x,vB[0].y,vB[1].x,vB[1].y,vC[0].x,vC[0].y,vC[1].x,vC[1].y };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<12; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_tessellation_shader : require
layout (vertices=6) out;
in gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
} gl_in[];
out gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
} gl_out[];



layout (location=0) in ivec2 inData[][2];
layout (location=0) out ivec2 outData[][2];

void main (void)
{
    if (gl_InvocationID == 0)
    {
        gl_TessLevelInner[0] = 1.0;
        gl_TessLevelInner[1] = 1.0;
        gl_TessLevelOuter[0] = 1.0;
        gl_TessLevelOuter[1] = 1.0;
        gl_TessLevelOuter[2] = 1.0;
        gl_TessLevelOuter[3] = 1.0;
    }
    outData[gl_InvocationID] = inData[gl_InvocationID];
    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
}
#version 450
#extension GL_EXT_tessellation_shader : require
layout (triangles) in;
in gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
} gl_in[];
out gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
};



layout (location=0) in ivec2 inData[][2];
struct OutDataStruct {uint idx; ivec2 data[2];};
layout (location=0) flat out OutDataStruct outParam;

void main (void)
{
    gl_Position = (gl_TessCoord.x * gl_in[0].gl_Position) +
                  (gl_TessCoord.y * gl_in[1].gl_Position) +
                  (gl_TessCoord.z * gl_in[2].gl_Position);
    if (gl_TessCoord.xyz == vec3(0.0,1.0,0.0)) {outParam.idx = 2; outParam.data = ivec2[2](inData[2][0],inData[2][1]); }
    else if (gl_TessCoord.xyz == vec3(1.0,0.0,0.0)) {outParam.idx = 0; outParam.data = ivec2[2](inData[0][0],inData[0][1]); }
    else if (gl_TessCoord.xyz == vec3(0.0,0.0,1.0)) {outParam.idx = 1; outParam.data = ivec2[2](inData[1][0],inData[1][1]); }
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require



layout(location = 0) in  vec4 in_position;
layout(location = 0) out ivec3 data[2];

out gl_PerVertex
{
    vec4  gl_Position;
    float gl_PointSize;
};

void main()
{
    const int n  = gl_VertexIndex + 1;
    data         = ivec3[2](ivec3(int(n), int(2*n), int(4*n)), int(3)*ivec3(int(n), int(2*n), int(4*n)));
    gl_PointSize = 1.0;
    gl_Position  = in_position;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require




layout(location = 0) out uvec4 out_color;

struct InDataStruct {uint idx; ivec3 data[2];};
layout(location = 0) pervertexEXT in InDataStruct inParam[];
void getData(uint i, out ivec3 ds[2])
{
    for(uint k = 0; k < 3; k++)
    {
        if (inParam[k].idx == i)
            ds = ivec3[2](inParam[k].data[0],inParam[k].data[1]);
    }
}
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = (x < y) ? 0 : 1;
    const bool even = (p%2 == 0);

    ivec3 eA[2]; { const int n = 1 + (3*p); eA = ivec3[2](ivec3(int(n), int(2*n), int(4*n)), int(3)*ivec3(int(n), int(2*n), int(4*n))); }
    ivec3 eB[2]; { const int n = 1 + (3*p+1); eB = ivec3[2](ivec3(int(n), int(2*n), int(4*n)), int(3)*ivec3(int(n), int(2*n), int(4*n))); }
    ivec3 eC[2]; { const int n = 1 + (3*p+2); eC = ivec3[2](ivec3(int(n), int(2*n), int(4*n)), int(3)*ivec3(int(n), int(2*n), int(4*n))); }

    int e[18] = { eA[0].x,eA[0].y,eA[0].z,eA[1].x,eA[1].y,eA[1].z,eB[0].x,eB[0].y,eB[0].z,eB[1].x,eB[1].y,eB[1].z,eC[0].x,eC[0].y,eC[0].z,eC[1].x,eC[1].y,eC[1].z };

    ivec3 vA[2]; { getData(0, vA); }
    ivec3 vB[2]; { getData(1, vB); }
    ivec3 vC[2]; { getData(2, vC); }

    int v[18] = { vA[0].x,vA[0].y,vA[0].z,vA[1].x,vA[1].y,vA[1].z,vB[0].x,vB[0].y,vB[0].z,vB[1].x,vB[1].y,vB[1].z,vC[0].x,vC[0].y,vC[0].z,vC[1].x,vC[1].y,vC[1].z };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<18; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_tessellation_shader : require
layout (vertices=6) out;
in gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
} gl_in[];
out gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
} gl_out[];



layout (location=0) in ivec3 inData[][2];
layout (location=0) out ivec3 outData[][2];

void main (void)
{
    if (gl_InvocationID == 0)
    {
        gl_TessLevelInner[0] = 1.0;
        gl_TessLevelInner[1] = 1.0;
        gl_TessLevelOuter[0] = 1.0;
        gl_TessLevelOuter[1] = 1.0;
        gl_TessLevelOuter[2] = 1.0;
        gl_TessLevelOuter[3] = 1.0;
    }
    outData[gl_InvocationID] = inData[gl_InvocationID];
    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
}
#version 450
#extension GL_EXT_tessellation_shader : require
layout (triangles) in;
in gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
} gl_in[];
out gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
};



layout (location=0) in ivec3 inData[][2];
struct OutDataStruct {uint idx; ivec3 data[2];};
layout (location=0) flat out OutDataStruct outParam;

void main (void)
{
    gl_Position = (gl_TessCoord.x * gl_in[0].gl_Position) +
                  (gl_TessCoord.y * gl_in[1].gl_Position) +
                  (gl_TessCoord.z * gl_in[2].gl_Position);
    if (gl_TessCoord.xyz == vec3(0.0,1.0,0.0)) {outParam.idx = 2; outParam.data = ivec3[2](inData[2][0],inData[2][1]); }
    else if (gl_TessCoord.xyz == vec3(1.0,0.0,0.0)) {outParam.idx = 0; outParam.data = ivec3[2](inData[0][0],inData[0][1]); }
    else if (gl_TessCoord.xyz == vec3(0.0,0.0,1.0)) {outParam.idx = 1; outParam.data = ivec3[2](inData[1][0],inData[1][1]); }
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require



layout(location = 0) in  vec4 in_position;
layout(location = 0) out ivec4 data[2];

out gl_PerVertex
{
    vec4  gl_Position;
    float gl_PointSize;
};

void main()
{
    const int n  = gl_VertexIndex + 1;
    data         = ivec4[2](ivec4(int(n), int(2*n), int(4*n), int(8*n)), int(3)*ivec4(int(n), int(2*n), int(4*n), int(8*n)));
    gl_PointSize = 1.0;
    gl_Position  = in_position;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require




layout(location = 0) out uvec4 out_color;

struct InDataStruct {uint idx; ivec4 data[2];};
layout(location = 0) pervertexEXT in InDataStruct inParam[];
void getData(uint i, out ivec4 ds[2])
{
    for(uint k = 0; k < 3; k++)
    {
        if (inParam[k].idx == i)
            ds = ivec4[2](inParam[k].data[0],inParam[k].data[1]);
    }
}
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = (x < y) ? 0 : 1;
    const bool even = (p%2 == 0);

    ivec4 eA[2]; { const int n = 1 + (3*p); eA = ivec4[2](ivec4(int(n), int(2*n), int(4*n), int(8*n)), int(3)*ivec4(int(n), int(2*n), int(4*n), int(8*n))); }
    ivec4 eB[2]; { const int n = 1 + (3*p+1); eB = ivec4[2](ivec4(int(n), int(2*n), int(4*n), int(8*n)), int(3)*ivec4(int(n), int(2*n), int(4*n), int(8*n))); }
    ivec4 eC[2]; { const int n = 1 + (3*p+2); eC = ivec4[2](ivec4(int(n), int(2*n), int(4*n), int(8*n)), int(3)*ivec4(int(n), int(2*n), int(4*n), int(8*n))); }

    int e[24] = { eA[0].x,eA[0].y,eA[0].z,eA[0].w,eA[1].x,eA[1].y,eA[1].z,eA[1].w,eB[0].x,eB[0].y,eB[0].z,eB[0].w,eB[1].x,eB[1].y,eB[1].z,eB[1].w,eC[0].x,eC[0].y,eC[0].z,eC[0].w,eC[1].x,eC[1].y,eC[1].z,eC[1].w };

    ivec4 vA[2]; { getData(0, vA); }
    ivec4 vB[2]; { getData(1, vB); }
    ivec4 vC[2]; { getData(2, vC); }

    int v[24] = { vA[0].x,vA[0].y,vA[0].z,vA[0].w,vA[1].x,vA[1].y,vA[1].z,vA[1].w,vB[0].x,vB[0].y,vB[0].z,vB[0].w,vB[1].x,vB[1].y,vB[1].z,vB[1].w,vC[0].x,vC[0].y,vC[0].z,vC[0].w,vC[1].x,vC[1].y,vC[1].z,vC[1].w };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<24; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_tessellation_shader : require
layout (vertices=6) out;
in gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
} gl_in[];
out gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
} gl_out[];



layout (location=0) in ivec4 inData[][2];
layout (location=0) out ivec4 outData[][2];

void main (void)
{
    if (gl_InvocationID == 0)
    {
        gl_TessLevelInner[0] = 1.0;
        gl_TessLevelInner[1] = 1.0;
        gl_TessLevelOuter[0] = 1.0;
        gl_TessLevelOuter[1] = 1.0;
        gl_TessLevelOuter[2] = 1.0;
        gl_TessLevelOuter[3] = 1.0;
    }
    outData[gl_InvocationID] = inData[gl_InvocationID];
    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
}
#version 450
#extension GL_EXT_tessellation_shader : require
layout (triangles) in;
in gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
} gl_in[];
out gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
};



layout (location=0) in ivec4 inData[][2];
struct OutDataStruct {uint idx; ivec4 data[2];};
layout (location=0) flat out OutDataStruct outParam;

void main (void)
{
    gl_Position = (gl_TessCoord.x * gl_in[0].gl_Position) +
                  (gl_TessCoord.y * gl_in[1].gl_Position) +
                  (gl_TessCoord.z * gl_in[2].gl_Position);
    if (gl_TessCoord.xyz == vec3(0.0,1.0,0.0)) {outParam.idx = 2; outParam.data = ivec4[2](inData[2][0],inData[2][1]); }
    else if (gl_TessCoord.xyz == vec3(1.0,0.0,0.0)) {outParam.idx = 0; outParam.data = ivec4[2](inData[0][0],inData[0][1]); }
    else if (gl_TessCoord.xyz == vec3(0.0,0.0,1.0)) {outParam.idx = 1; outParam.data = ivec4[2](inData[1][0],inData[1][1]); }
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require



layout(location = 0) in  vec4 in_position;
layout(location = 0) out uint data[2];

out gl_PerVertex
{
    vec4  gl_Position;
    float gl_PointSize;
};

void main()
{
    const int n  = gl_VertexIndex + 1;
    data         = uint[2](uint(n), uint(3)*uint(n));
    gl_PointSize = 1.0;
    gl_Position  = in_position;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require




layout(location = 0) out uvec4 out_color;

struct InDataStruct {uint idx; uint data[2];};
layout(location = 0) pervertexEXT in InDataStruct inParam[];
void getData(uint i, out uint ds[2])
{
    for(uint k = 0; k < 3; k++)
    {
        if (inParam[k].idx == i)
            ds = uint[2](inParam[k].data[0],inParam[k].data[1]);
    }
}
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = (x < y) ? 0 : 1;
    const bool even = (p%2 == 0);

    uint eA[2]; { const int n = 1 + (3*p); eA = uint[2](uint(n), uint(3)*uint(n)); }
    uint eB[2]; { const int n = 1 + (3*p+1); eB = uint[2](uint(n), uint(3)*uint(n)); }
    uint eC[2]; { const int n = 1 + (3*p+2); eC = uint[2](uint(n), uint(3)*uint(n)); }

    uint e[6] = { eA[0],eA[1],eB[0],eB[1],eC[0],eC[1] };

    uint vA[2]; { getData(0, vA); }
    uint vB[2]; { getData(1, vB); }
    uint vC[2]; { getData(2, vC); }

    uint v[6] = { vA[0],vA[1],vB[0],vB[1],vC[0],vC[1] };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<6; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_tessellation_shader : require
layout (vertices=6) out;
in gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
} gl_in[];
out gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
} gl_out[];



layout (location=0) in uint inData[][2];
layout (location=0) out uint outData[][2];

void main (void)
{
    if (gl_InvocationID == 0)
    {
        gl_TessLevelInner[0] = 1.0;
        gl_TessLevelInner[1] = 1.0;
        gl_TessLevelOuter[0] = 1.0;
        gl_TessLevelOuter[1] = 1.0;
        gl_TessLevelOuter[2] = 1.0;
        gl_TessLevelOuter[3] = 1.0;
    }
    outData[gl_InvocationID] = inData[gl_InvocationID];
    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
}
#version 450
#extension GL_EXT_tessellation_shader : require
layout (triangles) in;
in gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
} gl_in[];
out gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
};



layout (location=0) in uint inData[][2];
struct OutDataStruct {uint idx; uint data[2];};
layout (location=0) flat out OutDataStruct outParam;

void main (void)
{
    gl_Position = (gl_TessCoord.x * gl_in[0].gl_Position) +
                  (gl_TessCoord.y * gl_in[1].gl_Position) +
                  (gl_TessCoord.z * gl_in[2].gl_Position);
    if (gl_TessCoord.xyz == vec3(0.0,1.0,0.0)) {outParam.idx = 2; outParam.data = uint[2](inData[2][0],inData[2][1]); }
    else if (gl_TessCoord.xyz == vec3(1.0,0.0,0.0)) {outParam.idx = 0; outParam.data = uint[2](inData[0][0],inData[0][1]); }
    else if (gl_TessCoord.xyz == vec3(0.0,0.0,1.0)) {outParam.idx = 1; outParam.data = uint[2](inData[1][0],inData[1][1]); }
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require



layout(location = 0) in  vec4 in_position;
layout(location = 0) out uvec2 data[2];

out gl_PerVertex
{
    vec4  gl_Position;
    float gl_PointSize;
};

void main()
{
    const int n  = gl_VertexIndex + 1;
    data         = uvec2[2](uvec2(uint(n), uint(2*n)), uint(3)*uvec2(uint(n), uint(2*n)));
    gl_PointSize = 1.0;
    gl_Position  = in_position;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require




layout(location = 0) out uvec4 out_color;

struct InDataStruct {uint idx; uvec2 data[2];};
layout(location = 0) pervertexEXT in InDataStruct inParam[];
void getData(uint i, out uvec2 ds[2])
{
    for(uint k = 0; k < 3; k++)
    {
        if (inParam[k].idx == i)
            ds = uvec2[2](inParam[k].data[0],inParam[k].data[1]);
    }
}
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = (x < y) ? 0 : 1;
    const bool even = (p%2 == 0);

    uvec2 eA[2]; { const int n = 1 + (3*p); eA = uvec2[2](uvec2(uint(n), uint(2*n)), uint(3)*uvec2(uint(n), uint(2*n))); }
    uvec2 eB[2]; { const int n = 1 + (3*p+1); eB = uvec2[2](uvec2(uint(n), uint(2*n)), uint(3)*uvec2(uint(n), uint(2*n))); }
    uvec2 eC[2]; { const int n = 1 + (3*p+2); eC = uvec2[2](uvec2(uint(n), uint(2*n)), uint(3)*uvec2(uint(n), uint(2*n))); }

    uint e[12] = { eA[0].x,eA[0].y,eA[1].x,eA[1].y,eB[0].x,eB[0].y,eB[1].x,eB[1].y,eC[0].x,eC[0].y,eC[1].x,eC[1].y };

    uvec2 vA[2]; { getData(0, vA); }
    uvec2 vB[2]; { getData(1, vB); }
    uvec2 vC[2]; { getData(2, vC); }

    uint v[12] = { vA[0].x,vA[0].y,vA[1].x,vA[1].y,vB[0].x,vB[0].y,vB[1].x,vB[1].y,vC[0].x,vC[0].y,vC[1].x,vC[1].y };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<12; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_tessellation_shader : require
layout (vertices=6) out;
in gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
} gl_in[];
out gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
} gl_out[];



layout (location=0) in uvec2 inData[][2];
layout (location=0) out uvec2 outData[][2];

void main (void)
{
    if (gl_InvocationID == 0)
    {
        gl_TessLevelInner[0] = 1.0;
        gl_TessLevelInner[1] = 1.0;
        gl_TessLevelOuter[0] = 1.0;
        gl_TessLevelOuter[1] = 1.0;
        gl_TessLevelOuter[2] = 1.0;
        gl_TessLevelOuter[3] = 1.0;
    }
    outData[gl_InvocationID] = inData[gl_InvocationID];
    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
}
#version 450
#extension GL_EXT_tessellation_shader : require
layout (triangles) in;
in gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
} gl_in[];
out gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
};



layout (location=0) in uvec2 inData[][2];
struct OutDataStruct {uint idx; uvec2 data[2];};
layout (location=0) flat out OutDataStruct outParam;

void main (void)
{
    gl_Position = (gl_TessCoord.x * gl_in[0].gl_Position) +
                  (gl_TessCoord.y * gl_in[1].gl_Position) +
                  (gl_TessCoord.z * gl_in[2].gl_Position);
    if (gl_TessCoord.xyz == vec3(0.0,1.0,0.0)) {outParam.idx = 2; outParam.data = uvec2[2](inData[2][0],inData[2][1]); }
    else if (gl_TessCoord.xyz == vec3(1.0,0.0,0.0)) {outParam.idx = 0; outParam.data = uvec2[2](inData[0][0],inData[0][1]); }
    else if (gl_TessCoord.xyz == vec3(0.0,0.0,1.0)) {outParam.idx = 1; outParam.data = uvec2[2](inData[1][0],inData[1][1]); }
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require



layout(location = 0) in  vec4 in_position;
layout(location = 0) out uvec3 data[2];

out gl_PerVertex
{
    vec4  gl_Position;
    float gl_PointSize;
};

void main()
{
    const int n  = gl_VertexIndex + 1;
    data         = uvec3[2](uvec3(uint(n), uint(2*n), uint(4*n)), uint(3)*uvec3(uint(n), uint(2*n), uint(4*n)));
    gl_PointSize = 1.0;
    gl_Position  = in_position;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require




layout(location = 0) out uvec4 out_color;

struct InDataStruct {uint idx; uvec3 data[2];};
layout(location = 0) pervertexEXT in InDataStruct inParam[];
void getData(uint i, out uvec3 ds[2])
{
    for(uint k = 0; k < 3; k++)
    {
        if (inParam[k].idx == i)
            ds = uvec3[2](inParam[k].data[0],inParam[k].data[1]);
    }
}
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = (x < y) ? 0 : 1;
    const bool even = (p%2 == 0);

    uvec3 eA[2]; { const int n = 1 + (3*p); eA = uvec3[2](uvec3(uint(n), uint(2*n), uint(4*n)), uint(3)*uvec3(uint(n), uint(2*n), uint(4*n))); }
    uvec3 eB[2]; { const int n = 1 + (3*p+1); eB = uvec3[2](uvec3(uint(n), uint(2*n), uint(4*n)), uint(3)*uvec3(uint(n), uint(2*n), uint(4*n))); }
    uvec3 eC[2]; { const int n = 1 + (3*p+2); eC = uvec3[2](uvec3(uint(n), uint(2*n), uint(4*n)), uint(3)*uvec3(uint(n), uint(2*n), uint(4*n))); }

    uint e[18] = { eA[0].x,eA[0].y,eA[0].z,eA[1].x,eA[1].y,eA[1].z,eB[0].x,eB[0].y,eB[0].z,eB[1].x,eB[1].y,eB[1].z,eC[0].x,eC[0].y,eC[0].z,eC[1].x,eC[1].y,eC[1].z };

    uvec3 vA[2]; { getData(0, vA); }
    uvec3 vB[2]; { getData(1, vB); }
    uvec3 vC[2]; { getData(2, vC); }

    uint v[18] = { vA[0].x,vA[0].y,vA[0].z,vA[1].x,vA[1].y,vA[1].z,vB[0].x,vB[0].y,vB[0].z,vB[1].x,vB[1].y,vB[1].z,vC[0].x,vC[0].y,vC[0].z,vC[1].x,vC[1].y,vC[1].z };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<18; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_tessellation_shader : require
layout (vertices=6) out;
in gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
} gl_in[];
out gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
} gl_out[];



layout (location=0) in uvec3 inData[][2];
layout (location=0) out uvec3 outData[][2];

void main (void)
{
    if (gl_InvocationID == 0)
    {
        gl_TessLevelInner[0] = 1.0;
        gl_TessLevelInner[1] = 1.0;
        gl_TessLevelOuter[0] = 1.0;
        gl_TessLevelOuter[1] = 1.0;
        gl_TessLevelOuter[2] = 1.0;
        gl_TessLevelOuter[3] = 1.0;
    }
    outData[gl_InvocationID] = inData[gl_InvocationID];
    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
}
#version 450
#extension GL_EXT_tessellation_shader : require
layout (triangles) in;
in gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
} gl_in[];
out gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
};



layout (location=0) in uvec3 inData[][2];
struct OutDataStruct {uint idx; uvec3 data[2];};
layout (location=0) flat out OutDataStruct outParam;

void main (void)
{
    gl_Position = (gl_TessCoord.x * gl_in[0].gl_Position) +
                  (gl_TessCoord.y * gl_in[1].gl_Position) +
                  (gl_TessCoord.z * gl_in[2].gl_Position);
    if (gl_TessCoord.xyz == vec3(0.0,1.0,0.0)) {outParam.idx = 2; outParam.data = uvec3[2](inData[2][0],inData[2][1]); }
    else if (gl_TessCoord.xyz == vec3(1.0,0.0,0.0)) {outParam.idx = 0; outParam.data = uvec3[2](inData[0][0],inData[0][1]); }
    else if (gl_TessCoord.xyz == vec3(0.0,0.0,1.0)) {outParam.idx = 1; outParam.data = uvec3[2](inData[1][0],inData[1][1]); }
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require



layout(location = 0) in  vec4 in_position;
layout(location = 0) out uvec4 data[2];

out gl_PerVertex
{
    vec4  gl_Position;
    float gl_PointSize;
};

void main()
{
    const int n  = gl_VertexIndex + 1;
    data         = uvec4[2](uvec4(uint(n), uint(2*n), uint(4*n), uint(8*n)), uint(3)*uvec4(uint(n), uint(2*n), uint(4*n), uint(8*n)));
    gl_PointSize = 1.0;
    gl_Position  = in_position;
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require




layout(location = 0) out uvec4 out_color;

struct InDataStruct {uint idx; uvec4 data[2];};
layout(location = 0) pervertexEXT in InDataStruct inParam[];
void getData(uint i, out uvec4 ds[2])
{
    for(uint k = 0; k < 3; k++)
    {
        if (inParam[k].idx == i)
            ds = uvec4[2](inParam[k].data[0],inParam[k].data[1]);
    }
}
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = (x < y) ? 0 : 1;
    const bool even = (p%2 == 0);

    uvec4 eA[2]; { const int n = 1 + (3*p); eA = uvec4[2](uvec4(uint(n), uint(2*n), uint(4*n), uint(8*n)), uint(3)*uvec4(uint(n), uint(2*n), uint(4*n), uint(8*n))); }
    uvec4 eB[2]; { const int n = 1 + (3*p+1); eB = uvec4[2](uvec4(uint(n), uint(2*n), uint(4*n), uint(8*n)), uint(3)*uvec4(uint(n), uint(2*n), uint(4*n), uint(8*n))); }
    uvec4 eC[2]; { const int n = 1 + (3*p+2); eC = uvec4[2](uvec4(uint(n), uint(2*n), uint(4*n), uint(8*n)), uint(3)*uvec4(uint(n), uint(2*n), uint(4*n), uint(8*n))); }

    uint e[24] = { eA[0].x,eA[0].y,eA[0].z,eA[0].w,eA[1].x,eA[1].y,eA[1].z,eA[1].w,eB[0].x,eB[0].y,eB[0].z,eB[0].w,eB[1].x,eB[1].y,eB[1].z,eB[1].w,eC[0].x,eC[0].y,eC[0].z,eC[0].w,eC[1].x,eC[1].y,eC[1].z,eC[1].w };

    uvec4 vA[2]; { getData(0, vA); }
    uvec4 vB[2]; { getData(1, vB); }
    uvec4 vC[2]; { getData(2, vC); }

    uint v[24] = { vA[0].x,vA[0].y,vA[0].z,vA[0].w,vA[1].x,vA[1].y,vA[1].z,vA[1].w,vB[0].x,vB[0].y,vB[0].z,vB[0].w,vB[1].x,vB[1].y,vB[1].z,vB[1].w,vC[0].x,vC[0].y,vC[0].z,vC[0].w,vC[1].x,vC[1].y,vC[1].z,vC[1].w };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<24; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    out_color = mask;
}
#version 450
#extension GL_EXT_tessellation_shader : require
layout (vertices=6) out;
in gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
} gl_in[];
out gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
} gl_out[];



layout (location=0) in uvec4 inData[][2];
layout (location=0) out uvec4 outData[][2];

void main (void)
{
    if (gl_InvocationID == 0)
    {
        gl_TessLevelInner[0] = 1.0;
        gl_TessLevelInner[1] = 1.0;
        gl_TessLevelOuter[0] = 1.0;
        gl_TessLevelOuter[1] = 1.0;
        gl_TessLevelOuter[2] = 1.0;
        gl_TessLevelOuter[3] = 1.0;
    }
    outData[gl_InvocationID] = inData[gl_InvocationID];
    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
}
#version 450
#extension GL_EXT_tessellation_shader : require
layout (triangles) in;
in gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
} gl_in[];
out gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
};



layout (location=0) in uvec4 inData[][2];
struct OutDataStruct {uint idx; uvec4 data[2];};
layout (location=0) flat out OutDataStruct outParam;

void main (void)
{
    gl_Position = (gl_TessCoord.x * gl_in[0].gl_Position) +
                  (gl_TessCoord.y * gl_in[1].gl_Position) +
                  (gl_TessCoord.z * gl_in[2].gl_Position);
    if (gl_TessCoord.xyz == vec3(0.0,1.0,0.0)) {outParam.idx = 2; outParam.data = uvec4[2](inData[2][0],inData[2][1]); }
    else if (gl_TessCoord.xyz == vec3(1.0,0.0,0.0)) {outParam.idx = 0; outParam.data = uvec4[2](inData[0][0],inData[0][1]); }
    else if (gl_TessCoord.xyz == vec3(0.0,0.0,1.0)) {outParam.idx = 1; outParam.data = uvec4[2](inData[1][0],inData[1][1]); }
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require




layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in float data[];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = (x < y) ? 0 : 1;
    const bool even = (p%2 == 0);

    float eA; { const int n = 1 + (3*p); eA = float(n); }
    float eB; { const int n = 1 + (3*p+1); eB = float(n); }
    float eC; { const int n = 1 + (3*p+2); eC = float(n); }

    float e[3] = { eA,eB,eC };

    float vA; { vA = data[0]; }
    float vB; { vB = data[1]; }
    float vC; { vC = data[2]; }

    float v[3] = { vA,vB,vC };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<3; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    out_color = mask;
}
#version 460

layout (triangles) in;
layout (triangle_strip, max_vertices=3) out;
in gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
} gl_in[3];
out gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
};



layout (location=0) in float inData[];
layout (location=0) out float outData;

void main ()
{
    gl_Position = gl_in[0].gl_Position;
    outData = inData[0];
    EmitVertex();
    gl_Position = gl_in[1].gl_Position;
    outData = inData[1];
    EmitVertex();
    gl_Position = gl_in[2].gl_Position;
    outData = inData[2];
    EmitVertex();
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require




layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in vec2 data[];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = (x < y) ? 0 : 1;
    const bool even = (p%2 == 0);

    vec2 eA; { const int n = 1 + (3*p); eA = vec2(float(n), float(2*n)); }
    vec2 eB; { const int n = 1 + (3*p+1); eB = vec2(float(n), float(2*n)); }
    vec2 eC; { const int n = 1 + (3*p+2); eC = vec2(float(n), float(2*n)); }

    float e[6] = { eA.x,eA.y,eB.x,eB.y,eC.x,eC.y };

    vec2 vA; { vA = data[0]; }
    vec2 vB; { vB = data[1]; }
    vec2 vC; { vC = data[2]; }

    float v[6] = { vA.x,vA.y,vB.x,vB.y,vC.x,vC.y };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<6; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    out_color = mask;
}
#version 460

layout (triangles) in;
layout (triangle_strip, max_vertices=3) out;
in gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
} gl_in[3];
out gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
};



layout (location=0) in vec2 inData[];
layout (location=0) out vec2 outData;

void main ()
{
    gl_Position = gl_in[0].gl_Position;
    outData = inData[0];
    EmitVertex();
    gl_Position = gl_in[1].gl_Position;
    outData = inData[1];
    EmitVertex();
    gl_Position = gl_in[2].gl_Position;
    outData = inData[2];
    EmitVertex();
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require




layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in vec3 data[];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = (x < y) ? 0 : 1;
    const bool even = (p%2 == 0);

    vec3 eA; { const int n = 1 + (3*p); eA = vec3(float(n), float(2*n), float(4*n)); }
    vec3 eB; { const int n = 1 + (3*p+1); eB = vec3(float(n), float(2*n), float(4*n)); }
    vec3 eC; { const int n = 1 + (3*p+2); eC = vec3(float(n), float(2*n), float(4*n)); }

    float e[9] = { eA.x,eA.y,eA.z,eB.x,eB.y,eB.z,eC.x,eC.y,eC.z };

    vec3 vA; { vA = data[0]; }
    vec3 vB; { vB = data[1]; }
    vec3 vC; { vC = data[2]; }

    float v[9] = { vA.x,vA.y,vA.z,vB.x,vB.y,vB.z,vC.x,vC.y,vC.z };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<9; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    out_color = mask;
}
#version 460

layout (triangles) in;
layout (triangle_strip, max_vertices=3) out;
in gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
} gl_in[3];
out gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
};



layout (location=0) in vec3 inData[];
layout (location=0) out vec3 outData;

void main ()
{
    gl_Position = gl_in[0].gl_Position;
    outData = inData[0];
    EmitVertex();
    gl_Position = gl_in[1].gl_Position;
    outData = inData[1];
    EmitVertex();
    gl_Position = gl_in[2].gl_Position;
    outData = inData[2];
    EmitVertex();
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require




layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in vec4 data[];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = (x < y) ? 0 : 1;
    const bool even = (p%2 == 0);

    vec4 eA; { const int n = 1 + (3*p); eA = vec4(float(n), float(2*n), float(4*n), float(8*n)); }
    vec4 eB; { const int n = 1 + (3*p+1); eB = vec4(float(n), float(2*n), float(4*n), float(8*n)); }
    vec4 eC; { const int n = 1 + (3*p+2); eC = vec4(float(n), float(2*n), float(4*n), float(8*n)); }

    float e[12] = { eA.x,eA.y,eA.z,eA.w,eB.x,eB.y,eB.z,eB.w,eC.x,eC.y,eC.z,eC.w };

    vec4 vA; { vA = data[0]; }
    vec4 vB; { vB = data[1]; }
    vec4 vC; { vC = data[2]; }

    float v[12] = { vA.x,vA.y,vA.z,vA.w,vB.x,vB.y,vB.z,vB.w,vC.x,vC.y,vC.z,vC.w };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<12; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    out_color = mask;
}
#version 460

layout (triangles) in;
layout (triangle_strip, max_vertices=3) out;
in gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
} gl_in[3];
out gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
};



layout (location=0) in vec4 inData[];
layout (location=0) out vec4 outData;

void main ()
{
    gl_Position = gl_in[0].gl_Position;
    outData = inData[0];
    EmitVertex();
    gl_Position = gl_in[1].gl_Position;
    outData = inData[1];
    EmitVertex();
    gl_Position = gl_in[2].gl_Position;
    outData = inData[2];
    EmitVertex();
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require




layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in double data[];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = (x < y) ? 0 : 1;
    const bool even = (p%2 == 0);

    double eA; { const int n = 1 + (3*p); eA = double(n); }
    double eB; { const int n = 1 + (3*p+1); eB = double(n); }
    double eC; { const int n = 1 + (3*p+2); eC = double(n); }

    double e[3] = { eA,eB,eC };

    double vA; { vA = data[0]; }
    double vB; { vB = data[1]; }
    double vC; { vC = data[2]; }

    double v[3] = { vA,vB,vC };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<3; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    out_color = mask;
}
#version 460

layout (triangles) in;
layout (triangle_strip, max_vertices=3) out;
in gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
} gl_in[3];
out gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
};



layout (location=0) in double inData[];
layout (location=0) out double outData;

void main ()
{
    gl_Position = gl_in[0].gl_Position;
    outData = inData[0];
    EmitVertex();
    gl_Position = gl_in[1].gl_Position;
    outData = inData[1];
    EmitVertex();
    gl_Position = gl_in[2].gl_Position;
    outData = inData[2];
    EmitVertex();
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require




layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in dvec2 data[];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = (x < y) ? 0 : 1;
    const bool even = (p%2 == 0);

    dvec2 eA; { const int n = 1 + (3*p); eA = dvec2(double(n), double(2*n)); }
    dvec2 eB; { const int n = 1 + (3*p+1); eB = dvec2(double(n), double(2*n)); }
    dvec2 eC; { const int n = 1 + (3*p+2); eC = dvec2(double(n), double(2*n)); }

    double e[6] = { eA.x,eA.y,eB.x,eB.y,eC.x,eC.y };

    dvec2 vA; { vA = data[0]; }
    dvec2 vB; { vB = data[1]; }
    dvec2 vC; { vC = data[2]; }

    double v[6] = { vA.x,vA.y,vB.x,vB.y,vC.x,vC.y };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<6; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    out_color = mask;
}
#version 460

layout (triangles) in;
layout (triangle_strip, max_vertices=3) out;
in gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
} gl_in[3];
out gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
};



layout (location=0) in dvec2 inData[];
layout (location=0) out dvec2 outData;

void main ()
{
    gl_Position = gl_in[0].gl_Position;
    outData = inData[0];
    EmitVertex();
    gl_Position = gl_in[1].gl_Position;
    outData = inData[1];
    EmitVertex();
    gl_Position = gl_in[2].gl_Position;
    outData = inData[2];
    EmitVertex();
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require




layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in dvec3 data[];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = (x < y) ? 0 : 1;
    const bool even = (p%2 == 0);

    dvec3 eA; { const int n = 1 + (3*p); eA = dvec3(double(n), double(2*n), double(4*n)); }
    dvec3 eB; { const int n = 1 + (3*p+1); eB = dvec3(double(n), double(2*n), double(4*n)); }
    dvec3 eC; { const int n = 1 + (3*p+2); eC = dvec3(double(n), double(2*n), double(4*n)); }

    double e[9] = { eA.x,eA.y,eA.z,eB.x,eB.y,eB.z,eC.x,eC.y,eC.z };

    dvec3 vA; { vA = data[0]; }
    dvec3 vB; { vB = data[1]; }
    dvec3 vC; { vC = data[2]; }

    double v[9] = { vA.x,vA.y,vA.z,vB.x,vB.y,vB.z,vC.x,vC.y,vC.z };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<9; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    out_color = mask;
}
#version 460

layout (triangles) in;
layout (triangle_strip, max_vertices=3) out;
in gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
} gl_in[3];
out gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
};



layout (location=0) in dvec3 inData[];
layout (location=0) out dvec3 outData;

void main ()
{
    gl_Position = gl_in[0].gl_Position;
    outData = inData[0];
    EmitVertex();
    gl_Position = gl_in[1].gl_Position;
    outData = inData[1];
    EmitVertex();
    gl_Position = gl_in[2].gl_Position;
    outData = inData[2];
    EmitVertex();
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require




layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in dvec4 data[];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = (x < y) ? 0 : 1;
    const bool even = (p%2 == 0);

    dvec4 eA; { const int n = 1 + (3*p); eA = dvec4(double(n), double(2*n), double(4*n), double(8*n)); }
    dvec4 eB; { const int n = 1 + (3*p+1); eB = dvec4(double(n), double(2*n), double(4*n), double(8*n)); }
    dvec4 eC; { const int n = 1 + (3*p+2); eC = dvec4(double(n), double(2*n), double(4*n), double(8*n)); }

    double e[12] = { eA.x,eA.y,eA.z,eA.w,eB.x,eB.y,eB.z,eB.w,eC.x,eC.y,eC.z,eC.w };

    dvec4 vA; { vA = data[0]; }
    dvec4 vB; { vB = data[1]; }
    dvec4 vC; { vC = data[2]; }

    double v[12] = { vA.x,vA.y,vA.z,vA.w,vB.x,vB.y,vB.z,vB.w,vC.x,vC.y,vC.z,vC.w };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<12; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    out_color = mask;
}
#version 460

layout (triangles) in;
layout (triangle_strip, max_vertices=3) out;
in gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
} gl_in[3];
out gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
};



layout (location=0) in dvec4 inData[];
layout (location=0) out dvec4 outData;

void main ()
{
    gl_Position = gl_in[0].gl_Position;
    outData = inData[0];
    EmitVertex();
    gl_Position = gl_in[1].gl_Position;
    outData = inData[1];
    EmitVertex();
    gl_Position = gl_in[2].gl_Position;
    outData = inData[2];
    EmitVertex();
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require




layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in int data[];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = (x < y) ? 0 : 1;
    const bool even = (p%2 == 0);

    int eA; { const int n = 1 + (3*p); eA = int(n); }
    int eB; { const int n = 1 + (3*p+1); eB = int(n); }
    int eC; { const int n = 1 + (3*p+2); eC = int(n); }

    int e[3] = { eA,eB,eC };

    int vA; { vA = data[0]; }
    int vB; { vB = data[1]; }
    int vC; { vC = data[2]; }

    int v[3] = { vA,vB,vC };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<3; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    out_color = mask;
}
#version 460

layout (triangles) in;
layout (triangle_strip, max_vertices=3) out;
in gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
} gl_in[3];
out gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
};



layout (location=0) in int inData[];
layout (location=0) out int outData;

void main ()
{
    gl_Position = gl_in[0].gl_Position;
    outData = inData[0];
    EmitVertex();
    gl_Position = gl_in[1].gl_Position;
    outData = inData[1];
    EmitVertex();
    gl_Position = gl_in[2].gl_Position;
    outData = inData[2];
    EmitVertex();
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require




layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in ivec2 data[];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = (x < y) ? 0 : 1;
    const bool even = (p%2 == 0);

    ivec2 eA; { const int n = 1 + (3*p); eA = ivec2(int(n), int(2*n)); }
    ivec2 eB; { const int n = 1 + (3*p+1); eB = ivec2(int(n), int(2*n)); }
    ivec2 eC; { const int n = 1 + (3*p+2); eC = ivec2(int(n), int(2*n)); }

    int e[6] = { eA.x,eA.y,eB.x,eB.y,eC.x,eC.y };

    ivec2 vA; { vA = data[0]; }
    ivec2 vB; { vB = data[1]; }
    ivec2 vC; { vC = data[2]; }

    int v[6] = { vA.x,vA.y,vB.x,vB.y,vC.x,vC.y };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<6; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    out_color = mask;
}
#version 460

layout (triangles) in;
layout (triangle_strip, max_vertices=3) out;
in gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
} gl_in[3];
out gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
};



layout (location=0) in ivec2 inData[];
layout (location=0) out ivec2 outData;

void main ()
{
    gl_Position = gl_in[0].gl_Position;
    outData = inData[0];
    EmitVertex();
    gl_Position = gl_in[1].gl_Position;
    outData = inData[1];
    EmitVertex();
    gl_Position = gl_in[2].gl_Position;
    outData = inData[2];
    EmitVertex();
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require




layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in ivec3 data[];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = (x < y) ? 0 : 1;
    const bool even = (p%2 == 0);

    ivec3 eA; { const int n = 1 + (3*p); eA = ivec3(int(n), int(2*n), int(4*n)); }
    ivec3 eB; { const int n = 1 + (3*p+1); eB = ivec3(int(n), int(2*n), int(4*n)); }
    ivec3 eC; { const int n = 1 + (3*p+2); eC = ivec3(int(n), int(2*n), int(4*n)); }

    int e[9] = { eA.x,eA.y,eA.z,eB.x,eB.y,eB.z,eC.x,eC.y,eC.z };

    ivec3 vA; { vA = data[0]; }
    ivec3 vB; { vB = data[1]; }
    ivec3 vC; { vC = data[2]; }

    int v[9] = { vA.x,vA.y,vA.z,vB.x,vB.y,vB.z,vC.x,vC.y,vC.z };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<9; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    out_color = mask;
}
#version 460

layout (triangles) in;
layout (triangle_strip, max_vertices=3) out;
in gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
} gl_in[3];
out gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
};



layout (location=0) in ivec3 inData[];
layout (location=0) out ivec3 outData;

void main ()
{
    gl_Position = gl_in[0].gl_Position;
    outData = inData[0];
    EmitVertex();
    gl_Position = gl_in[1].gl_Position;
    outData = inData[1];
    EmitVertex();
    gl_Position = gl_in[2].gl_Position;
    outData = inData[2];
    EmitVertex();
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require




layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in ivec4 data[];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = (x < y) ? 0 : 1;
    const bool even = (p%2 == 0);

    ivec4 eA; { const int n = 1 + (3*p); eA = ivec4(int(n), int(2*n), int(4*n), int(8*n)); }
    ivec4 eB; { const int n = 1 + (3*p+1); eB = ivec4(int(n), int(2*n), int(4*n), int(8*n)); }
    ivec4 eC; { const int n = 1 + (3*p+2); eC = ivec4(int(n), int(2*n), int(4*n), int(8*n)); }

    int e[12] = { eA.x,eA.y,eA.z,eA.w,eB.x,eB.y,eB.z,eB.w,eC.x,eC.y,eC.z,eC.w };

    ivec4 vA; { vA = data[0]; }
    ivec4 vB; { vB = data[1]; }
    ivec4 vC; { vC = data[2]; }

    int v[12] = { vA.x,vA.y,vA.z,vA.w,vB.x,vB.y,vB.z,vB.w,vC.x,vC.y,vC.z,vC.w };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<12; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    out_color = mask;
}
#version 460

layout (triangles) in;
layout (triangle_strip, max_vertices=3) out;
in gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
} gl_in[3];
out gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
};



layout (location=0) in ivec4 inData[];
layout (location=0) out ivec4 outData;

void main ()
{
    gl_Position = gl_in[0].gl_Position;
    outData = inData[0];
    EmitVertex();
    gl_Position = gl_in[1].gl_Position;
    outData = inData[1];
    EmitVertex();
    gl_Position = gl_in[2].gl_Position;
    outData = inData[2];
    EmitVertex();
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require




layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in uint data[];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = (x < y) ? 0 : 1;
    const bool even = (p%2 == 0);

    uint eA; { const int n = 1 + (3*p); eA = uint(n); }
    uint eB; { const int n = 1 + (3*p+1); eB = uint(n); }
    uint eC; { const int n = 1 + (3*p+2); eC = uint(n); }

    uint e[3] = { eA,eB,eC };

    uint vA; { vA = data[0]; }
    uint vB; { vB = data[1]; }
    uint vC; { vC = data[2]; }

    uint v[3] = { vA,vB,vC };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<3; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    out_color = mask;
}
#version 460

layout (triangles) in;
layout (triangle_strip, max_vertices=3) out;
in gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
} gl_in[3];
out gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
};



layout (location=0) in uint inData[];
layout (location=0) out uint outData;

void main ()
{
    gl_Position = gl_in[0].gl_Position;
    outData = inData[0];
    EmitVertex();
    gl_Position = gl_in[1].gl_Position;
    outData = inData[1];
    EmitVertex();
    gl_Position = gl_in[2].gl_Position;
    outData = inData[2];
    EmitVertex();
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require




layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in uvec2 data[];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = (x < y) ? 0 : 1;
    const bool even = (p%2 == 0);

    uvec2 eA; { const int n = 1 + (3*p); eA = uvec2(uint(n), uint(2*n)); }
    uvec2 eB; { const int n = 1 + (3*p+1); eB = uvec2(uint(n), uint(2*n)); }
    uvec2 eC; { const int n = 1 + (3*p+2); eC = uvec2(uint(n), uint(2*n)); }

    uint e[6] = { eA.x,eA.y,eB.x,eB.y,eC.x,eC.y };

    uvec2 vA; { vA = data[0]; }
    uvec2 vB; { vB = data[1]; }
    uvec2 vC; { vC = data[2]; }

    uint v[6] = { vA.x,vA.y,vB.x,vB.y,vC.x,vC.y };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<6; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    out_color = mask;
}
#version 460

layout (triangles) in;
layout (triangle_strip, max_vertices=3) out;
in gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
} gl_in[3];
out gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
};



layout (location=0) in uvec2 inData[];
layout (location=0) out uvec2 outData;

void main ()
{
    gl_Position = gl_in[0].gl_Position;
    outData = inData[0];
    EmitVertex();
    gl_Position = gl_in[1].gl_Position;
    outData = inData[1];
    EmitVertex();
    gl_Position = gl_in[2].gl_Position;
    outData = inData[2];
    EmitVertex();
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require




layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in uvec3 data[];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = (x < y) ? 0 : 1;
    const bool even = (p%2 == 0);

    uvec3 eA; { const int n = 1 + (3*p); eA = uvec3(uint(n), uint(2*n), uint(4*n)); }
    uvec3 eB; { const int n = 1 + (3*p+1); eB = uvec3(uint(n), uint(2*n), uint(4*n)); }
    uvec3 eC; { const int n = 1 + (3*p+2); eC = uvec3(uint(n), uint(2*n), uint(4*n)); }

    uint e[9] = { eA.x,eA.y,eA.z,eB.x,eB.y,eB.z,eC.x,eC.y,eC.z };

    uvec3 vA; { vA = data[0]; }
    uvec3 vB; { vB = data[1]; }
    uvec3 vC; { vC = data[2]; }

    uint v[9] = { vA.x,vA.y,vA.z,vB.x,vB.y,vB.z,vC.x,vC.y,vC.z };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<9; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    out_color = mask;
}
#version 460

layout (triangles) in;
layout (triangle_strip, max_vertices=3) out;
in gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
} gl_in[3];
out gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
};



layout (location=0) in uvec3 inData[];
layout (location=0) out uvec3 outData;

void main ()
{
    gl_Position = gl_in[0].gl_Position;
    outData = inData[0];
    EmitVertex();
    gl_Position = gl_in[1].gl_Position;
    outData = inData[1];
    EmitVertex();
    gl_Position = gl_in[2].gl_Position;
    outData = inData[2];
    EmitVertex();
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require




layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in uvec4 data[];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = (x < y) ? 0 : 1;
    const bool even = (p%2 == 0);

    uvec4 eA; { const int n = 1 + (3*p); eA = uvec4(uint(n), uint(2*n), uint(4*n), uint(8*n)); }
    uvec4 eB; { const int n = 1 + (3*p+1); eB = uvec4(uint(n), uint(2*n), uint(4*n), uint(8*n)); }
    uvec4 eC; { const int n = 1 + (3*p+2); eC = uvec4(uint(n), uint(2*n), uint(4*n), uint(8*n)); }

    uint e[12] = { eA.x,eA.y,eA.z,eA.w,eB.x,eB.y,eB.z,eB.w,eC.x,eC.y,eC.z,eC.w };

    uvec4 vA; { vA = data[0]; }
    uvec4 vB; { vB = data[1]; }
    uvec4 vC; { vC = data[2]; }

    uint v[12] = { vA.x,vA.y,vA.z,vA.w,vB.x,vB.y,vB.z,vB.w,vC.x,vC.y,vC.z,vC.w };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<12; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    out_color = mask;
}
#version 460

layout (triangles) in;
layout (triangle_strip, max_vertices=3) out;
in gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
} gl_in[3];
out gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
};



layout (location=0) in uvec4 inData[];
layout (location=0) out uvec4 outData;

void main ()
{
    gl_Position = gl_in[0].gl_Position;
    outData = inData[0];
    EmitVertex();
    gl_Position = gl_in[1].gl_Position;
    outData = inData[1];
    EmitVertex();
    gl_Position = gl_in[2].gl_Position;
    outData = inData[2];
    EmitVertex();
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require

struct DataStruct {float q;};


layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in DataStruct data[];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = (x < y) ? 0 : 1;
    const bool even = (p%2 == 0);

    DataStruct eA; { const int n = 1 + (3*p); eA = DataStruct(float(n)); }
    DataStruct eB; { const int n = 1 + (3*p+1); eB = DataStruct(float(n)); }
    DataStruct eC; { const int n = 1 + (3*p+2); eC = DataStruct(float(n)); }

    float e[3] = { eA.q,eB.q,eC.q };

    DataStruct vA; { vA = data[0]; }
    DataStruct vB; { vB = data[1]; }
    DataStruct vC; { vC = data[2]; }

    float v[3] = { vA.q,vB.q,vC.q };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<3; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    out_color = mask;
}
#version 460

layout (triangles) in;
layout (triangle_strip, max_vertices=3) out;
in gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
} gl_in[3];
out gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
};

struct DataStruct {float q;};

layout (location=0) in DataStruct inData[];
layout (location=0) out DataStruct outData;

void main ()
{
    gl_Position = gl_in[0].gl_Position;
    outData = inData[0];
    EmitVertex();
    gl_Position = gl_in[1].gl_Position;
    outData = inData[1];
    EmitVertex();
    gl_Position = gl_in[2].gl_Position;
    outData = inData[2];
    EmitVertex();
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require

struct DataStruct {vec2 q;};


layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in DataStruct data[];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = (x < y) ? 0 : 1;
    const bool even = (p%2 == 0);

    DataStruct eA; { const int n = 1 + (3*p); eA = DataStruct(vec2(float(n), float(2*n))); }
    DataStruct eB; { const int n = 1 + (3*p+1); eB = DataStruct(vec2(float(n), float(2*n))); }
    DataStruct eC; { const int n = 1 + (3*p+2); eC = DataStruct(vec2(float(n), float(2*n))); }

    float e[6] = { eA.q.x,eA.q.y,eB.q.x,eB.q.y,eC.q.x,eC.q.y };

    DataStruct vA; { vA = data[0]; }
    DataStruct vB; { vB = data[1]; }
    DataStruct vC; { vC = data[2]; }

    float v[6] = { vA.q.x,vA.q.y,vB.q.x,vB.q.y,vC.q.x,vC.q.y };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<6; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    out_color = mask;
}
#version 460

layout (triangles) in;
layout (triangle_strip, max_vertices=3) out;
in gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
} gl_in[3];
out gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
};

struct DataStruct {vec2 q;};

layout (location=0) in DataStruct inData[];
layout (location=0) out DataStruct outData;

void main ()
{
    gl_Position = gl_in[0].gl_Position;
    outData = inData[0];
    EmitVertex();
    gl_Position = gl_in[1].gl_Position;
    outData = inData[1];
    EmitVertex();
    gl_Position = gl_in[2].gl_Position;
    outData = inData[2];
    EmitVertex();
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require

struct DataStruct {vec3 q;};


layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in DataStruct data[];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = (x < y) ? 0 : 1;
    const bool even = (p%2 == 0);

    DataStruct eA; { const int n = 1 + (3*p); eA = DataStruct(vec3(float(n), float(2*n), float(4*n))); }
    DataStruct eB; { const int n = 1 + (3*p+1); eB = DataStruct(vec3(float(n), float(2*n), float(4*n))); }
    DataStruct eC; { const int n = 1 + (3*p+2); eC = DataStruct(vec3(float(n), float(2*n), float(4*n))); }

    float e[9] = { eA.q.x,eA.q.y,eA.q.z,eB.q.x,eB.q.y,eB.q.z,eC.q.x,eC.q.y,eC.q.z };

    DataStruct vA; { vA = data[0]; }
    DataStruct vB; { vB = data[1]; }
    DataStruct vC; { vC = data[2]; }

    float v[9] = { vA.q.x,vA.q.y,vA.q.z,vB.q.x,vB.q.y,vB.q.z,vC.q.x,vC.q.y,vC.q.z };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<9; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    out_color = mask;
}
#version 460

layout (triangles) in;
layout (triangle_strip, max_vertices=3) out;
in gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
} gl_in[3];
out gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
};

struct DataStruct {vec3 q;};

layout (location=0) in DataStruct inData[];
layout (location=0) out DataStruct outData;

void main ()
{
    gl_Position = gl_in[0].gl_Position;
    outData = inData[0];
    EmitVertex();
    gl_Position = gl_in[1].gl_Position;
    outData = inData[1];
    EmitVertex();
    gl_Position = gl_in[2].gl_Position;
    outData = inData[2];
    EmitVertex();
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require

struct DataStruct {vec4 q;};


layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in DataStruct data[];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = (x < y) ? 0 : 1;
    const bool even = (p%2 == 0);

    DataStruct eA; { const int n = 1 + (3*p); eA = DataStruct(vec4(float(n), float(2*n), float(4*n), float(8*n))); }
    DataStruct eB; { const int n = 1 + (3*p+1); eB = DataStruct(vec4(float(n), float(2*n), float(4*n), float(8*n))); }
    DataStruct eC; { const int n = 1 + (3*p+2); eC = DataStruct(vec4(float(n), float(2*n), float(4*n), float(8*n))); }

    float e[12] = { eA.q.x,eA.q.y,eA.q.z,eA.q.w,eB.q.x,eB.q.y,eB.q.z,eB.q.w,eC.q.x,eC.q.y,eC.q.z,eC.q.w };

    DataStruct vA; { vA = data[0]; }
    DataStruct vB; { vB = data[1]; }
    DataStruct vC; { vC = data[2]; }

    float v[12] = { vA.q.x,vA.q.y,vA.q.z,vA.q.w,vB.q.x,vB.q.y,vB.q.z,vB.q.w,vC.q.x,vC.q.y,vC.q.z,vC.q.w };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<12; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    out_color = mask;
}
#version 460

layout (triangles) in;
layout (triangle_strip, max_vertices=3) out;
in gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
} gl_in[3];
out gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
};

struct DataStruct {vec4 q;};

layout (location=0) in DataStruct inData[];
layout (location=0) out DataStruct outData;

void main ()
{
    gl_Position = gl_in[0].gl_Position;
    outData = inData[0];
    EmitVertex();
    gl_Position = gl_in[1].gl_Position;
    outData = inData[1];
    EmitVertex();
    gl_Position = gl_in[2].gl_Position;
    outData = inData[2];
    EmitVertex();
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require

struct DataStruct {double q;};


layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in DataStruct data[];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = (x < y) ? 0 : 1;
    const bool even = (p%2 == 0);

    DataStruct eA; { const int n = 1 + (3*p); eA = DataStruct(double(n)); }
    DataStruct eB; { const int n = 1 + (3*p+1); eB = DataStruct(double(n)); }
    DataStruct eC; { const int n = 1 + (3*p+2); eC = DataStruct(double(n)); }

    double e[3] = { eA.q,eB.q,eC.q };

    DataStruct vA; { vA = data[0]; }
    DataStruct vB; { vB = data[1]; }
    DataStruct vC; { vC = data[2]; }

    double v[3] = { vA.q,vB.q,vC.q };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<3; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    out_color = mask;
}
#version 460

layout (triangles) in;
layout (triangle_strip, max_vertices=3) out;
in gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
} gl_in[3];
out gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
};

struct DataStruct {double q;};

layout (location=0) in DataStruct inData[];
layout (location=0) out DataStruct outData;

void main ()
{
    gl_Position = gl_in[0].gl_Position;
    outData = inData[0];
    EmitVertex();
    gl_Position = gl_in[1].gl_Position;
    outData = inData[1];
    EmitVertex();
    gl_Position = gl_in[2].gl_Position;
    outData = inData[2];
    EmitVertex();
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require

struct DataStruct {dvec2 q;};


layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in DataStruct data[];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = (x < y) ? 0 : 1;
    const bool even = (p%2 == 0);

    DataStruct eA; { const int n = 1 + (3*p); eA = DataStruct(dvec2(double(n), double(2*n))); }
    DataStruct eB; { const int n = 1 + (3*p+1); eB = DataStruct(dvec2(double(n), double(2*n))); }
    DataStruct eC; { const int n = 1 + (3*p+2); eC = DataStruct(dvec2(double(n), double(2*n))); }

    double e[6] = { eA.q.x,eA.q.y,eB.q.x,eB.q.y,eC.q.x,eC.q.y };

    DataStruct vA; { vA = data[0]; }
    DataStruct vB; { vB = data[1]; }
    DataStruct vC; { vC = data[2]; }

    double v[6] = { vA.q.x,vA.q.y,vB.q.x,vB.q.y,vC.q.x,vC.q.y };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<6; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    out_color = mask;
}
#version 460

layout (triangles) in;
layout (triangle_strip, max_vertices=3) out;
in gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
} gl_in[3];
out gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
};

struct DataStruct {dvec2 q;};

layout (location=0) in DataStruct inData[];
layout (location=0) out DataStruct outData;

void main ()
{
    gl_Position = gl_in[0].gl_Position;
    outData = inData[0];
    EmitVertex();
    gl_Position = gl_in[1].gl_Position;
    outData = inData[1];
    EmitVertex();
    gl_Position = gl_in[2].gl_Position;
    outData = inData[2];
    EmitVertex();
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require

struct DataStruct {dvec3 q;};


layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in DataStruct data[];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = (x < y) ? 0 : 1;
    const bool even = (p%2 == 0);

    DataStruct eA; { const int n = 1 + (3*p); eA = DataStruct(dvec3(double(n), double(2*n), double(4*n))); }
    DataStruct eB; { const int n = 1 + (3*p+1); eB = DataStruct(dvec3(double(n), double(2*n), double(4*n))); }
    DataStruct eC; { const int n = 1 + (3*p+2); eC = DataStruct(dvec3(double(n), double(2*n), double(4*n))); }

    double e[9] = { eA.q.x,eA.q.y,eA.q.z,eB.q.x,eB.q.y,eB.q.z,eC.q.x,eC.q.y,eC.q.z };

    DataStruct vA; { vA = data[0]; }
    DataStruct vB; { vB = data[1]; }
    DataStruct vC; { vC = data[2]; }

    double v[9] = { vA.q.x,vA.q.y,vA.q.z,vB.q.x,vB.q.y,vB.q.z,vC.q.x,vC.q.y,vC.q.z };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<9; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    out_color = mask;
}
#version 460

layout (triangles) in;
layout (triangle_strip, max_vertices=3) out;
in gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
} gl_in[3];
out gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
};

struct DataStruct {dvec3 q;};

layout (location=0) in DataStruct inData[];
layout (location=0) out DataStruct outData;

void main ()
{
    gl_Position = gl_in[0].gl_Position;
    outData = inData[0];
    EmitVertex();
    gl_Position = gl_in[1].gl_Position;
    outData = inData[1];
    EmitVertex();
    gl_Position = gl_in[2].gl_Position;
    outData = inData[2];
    EmitVertex();
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require

struct DataStruct {dvec4 q;};


layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in DataStruct data[];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = (x < y) ? 0 : 1;
    const bool even = (p%2 == 0);

    DataStruct eA; { const int n = 1 + (3*p); eA = DataStruct(dvec4(double(n), double(2*n), double(4*n), double(8*n))); }
    DataStruct eB; { const int n = 1 + (3*p+1); eB = DataStruct(dvec4(double(n), double(2*n), double(4*n), double(8*n))); }
    DataStruct eC; { const int n = 1 + (3*p+2); eC = DataStruct(dvec4(double(n), double(2*n), double(4*n), double(8*n))); }

    double e[12] = { eA.q.x,eA.q.y,eA.q.z,eA.q.w,eB.q.x,eB.q.y,eB.q.z,eB.q.w,eC.q.x,eC.q.y,eC.q.z,eC.q.w };

    DataStruct vA; { vA = data[0]; }
    DataStruct vB; { vB = data[1]; }
    DataStruct vC; { vC = data[2]; }

    double v[12] = { vA.q.x,vA.q.y,vA.q.z,vA.q.w,vB.q.x,vB.q.y,vB.q.z,vB.q.w,vC.q.x,vC.q.y,vC.q.z,vC.q.w };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<12; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    out_color = mask;
}
#version 460

layout (triangles) in;
layout (triangle_strip, max_vertices=3) out;
in gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
} gl_in[3];
out gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
};

struct DataStruct {dvec4 q;};

layout (location=0) in DataStruct inData[];
layout (location=0) out DataStruct outData;

void main ()
{
    gl_Position = gl_in[0].gl_Position;
    outData = inData[0];
    EmitVertex();
    gl_Position = gl_in[1].gl_Position;
    outData = inData[1];
    EmitVertex();
    gl_Position = gl_in[2].gl_Position;
    outData = inData[2];
    EmitVertex();
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require

struct DataStruct {int q;};


layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in DataStruct data[];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = (x < y) ? 0 : 1;
    const bool even = (p%2 == 0);

    DataStruct eA; { const int n = 1 + (3*p); eA = DataStruct(int(n)); }
    DataStruct eB; { const int n = 1 + (3*p+1); eB = DataStruct(int(n)); }
    DataStruct eC; { const int n = 1 + (3*p+2); eC = DataStruct(int(n)); }

    int e[3] = { eA.q,eB.q,eC.q };

    DataStruct vA; { vA = data[0]; }
    DataStruct vB; { vB = data[1]; }
    DataStruct vC; { vC = data[2]; }

    int v[3] = { vA.q,vB.q,vC.q };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<3; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    out_color = mask;
}
#version 460

layout (triangles) in;
layout (triangle_strip, max_vertices=3) out;
in gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
} gl_in[3];
out gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
};

struct DataStruct {int q;};

layout (location=0) in DataStruct inData[];
layout (location=0) out DataStruct outData;

void main ()
{
    gl_Position = gl_in[0].gl_Position;
    outData = inData[0];
    EmitVertex();
    gl_Position = gl_in[1].gl_Position;
    outData = inData[1];
    EmitVertex();
    gl_Position = gl_in[2].gl_Position;
    outData = inData[2];
    EmitVertex();
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require

struct DataStruct {ivec2 q;};


layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in DataStruct data[];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = (x < y) ? 0 : 1;
    const bool even = (p%2 == 0);

    DataStruct eA; { const int n = 1 + (3*p); eA = DataStruct(ivec2(int(n), int(2*n))); }
    DataStruct eB; { const int n = 1 + (3*p+1); eB = DataStruct(ivec2(int(n), int(2*n))); }
    DataStruct eC; { const int n = 1 + (3*p+2); eC = DataStruct(ivec2(int(n), int(2*n))); }

    int e[6] = { eA.q.x,eA.q.y,eB.q.x,eB.q.y,eC.q.x,eC.q.y };

    DataStruct vA; { vA = data[0]; }
    DataStruct vB; { vB = data[1]; }
    DataStruct vC; { vC = data[2]; }

    int v[6] = { vA.q.x,vA.q.y,vB.q.x,vB.q.y,vC.q.x,vC.q.y };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<6; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    out_color = mask;
}
#version 460

layout (triangles) in;
layout (triangle_strip, max_vertices=3) out;
in gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
} gl_in[3];
out gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
};

struct DataStruct {ivec2 q;};

layout (location=0) in DataStruct inData[];
layout (location=0) out DataStruct outData;

void main ()
{
    gl_Position = gl_in[0].gl_Position;
    outData = inData[0];
    EmitVertex();
    gl_Position = gl_in[1].gl_Position;
    outData = inData[1];
    EmitVertex();
    gl_Position = gl_in[2].gl_Position;
    outData = inData[2];
    EmitVertex();
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require

struct DataStruct {ivec3 q;};


layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in DataStruct data[];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = (x < y) ? 0 : 1;
    const bool even = (p%2 == 0);

    DataStruct eA; { const int n = 1 + (3*p); eA = DataStruct(ivec3(int(n), int(2*n), int(4*n))); }
    DataStruct eB; { const int n = 1 + (3*p+1); eB = DataStruct(ivec3(int(n), int(2*n), int(4*n))); }
    DataStruct eC; { const int n = 1 + (3*p+2); eC = DataStruct(ivec3(int(n), int(2*n), int(4*n))); }

    int e[9] = { eA.q.x,eA.q.y,eA.q.z,eB.q.x,eB.q.y,eB.q.z,eC.q.x,eC.q.y,eC.q.z };

    DataStruct vA; { vA = data[0]; }
    DataStruct vB; { vB = data[1]; }
    DataStruct vC; { vC = data[2]; }

    int v[9] = { vA.q.x,vA.q.y,vA.q.z,vB.q.x,vB.q.y,vB.q.z,vC.q.x,vC.q.y,vC.q.z };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<9; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    out_color = mask;
}
#version 460

layout (triangles) in;
layout (triangle_strip, max_vertices=3) out;
in gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
} gl_in[3];
out gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
};

struct DataStruct {ivec3 q;};

layout (location=0) in DataStruct inData[];
layout (location=0) out DataStruct outData;

void main ()
{
    gl_Position = gl_in[0].gl_Position;
    outData = inData[0];
    EmitVertex();
    gl_Position = gl_in[1].gl_Position;
    outData = inData[1];
    EmitVertex();
    gl_Position = gl_in[2].gl_Position;
    outData = inData[2];
    EmitVertex();
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require

struct DataStruct {ivec4 q;};


layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in DataStruct data[];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = (x < y) ? 0 : 1;
    const bool even = (p%2 == 0);

    DataStruct eA; { const int n = 1 + (3*p); eA = DataStruct(ivec4(int(n), int(2*n), int(4*n), int(8*n))); }
    DataStruct eB; { const int n = 1 + (3*p+1); eB = DataStruct(ivec4(int(n), int(2*n), int(4*n), int(8*n))); }
    DataStruct eC; { const int n = 1 + (3*p+2); eC = DataStruct(ivec4(int(n), int(2*n), int(4*n), int(8*n))); }

    int e[12] = { eA.q.x,eA.q.y,eA.q.z,eA.q.w,eB.q.x,eB.q.y,eB.q.z,eB.q.w,eC.q.x,eC.q.y,eC.q.z,eC.q.w };

    DataStruct vA; { vA = data[0]; }
    DataStruct vB; { vB = data[1]; }
    DataStruct vC; { vC = data[2]; }

    int v[12] = { vA.q.x,vA.q.y,vA.q.z,vA.q.w,vB.q.x,vB.q.y,vB.q.z,vB.q.w,vC.q.x,vC.q.y,vC.q.z,vC.q.w };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<12; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    out_color = mask;
}
#version 460

layout (triangles) in;
layout (triangle_strip, max_vertices=3) out;
in gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
} gl_in[3];
out gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
};

struct DataStruct {ivec4 q;};

layout (location=0) in DataStruct inData[];
layout (location=0) out DataStruct outData;

void main ()
{
    gl_Position = gl_in[0].gl_Position;
    outData = inData[0];
    EmitVertex();
    gl_Position = gl_in[1].gl_Position;
    outData = inData[1];
    EmitVertex();
    gl_Position = gl_in[2].gl_Position;
    outData = inData[2];
    EmitVertex();
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require

struct DataStruct {uint q;};


layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in DataStruct data[];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = (x < y) ? 0 : 1;
    const bool even = (p%2 == 0);

    DataStruct eA; { const int n = 1 + (3*p); eA = DataStruct(uint(n)); }
    DataStruct eB; { const int n = 1 + (3*p+1); eB = DataStruct(uint(n)); }
    DataStruct eC; { const int n = 1 + (3*p+2); eC = DataStruct(uint(n)); }

    uint e[3] = { eA.q,eB.q,eC.q };

    DataStruct vA; { vA = data[0]; }
    DataStruct vB; { vB = data[1]; }
    DataStruct vC; { vC = data[2]; }

    uint v[3] = { vA.q,vB.q,vC.q };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<3; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    out_color = mask;
}
#version 460

layout (triangles) in;
layout (triangle_strip, max_vertices=3) out;
in gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
} gl_in[3];
out gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
};

struct DataStruct {uint q;};

layout (location=0) in DataStruct inData[];
layout (location=0) out DataStruct outData;

void main ()
{
    gl_Position = gl_in[0].gl_Position;
    outData = inData[0];
    EmitVertex();
    gl_Position = gl_in[1].gl_Position;
    outData = inData[1];
    EmitVertex();
    gl_Position = gl_in[2].gl_Position;
    outData = inData[2];
    EmitVertex();
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require

struct DataStruct {uvec2 q;};


layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in DataStruct data[];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = (x < y) ? 0 : 1;
    const bool even = (p%2 == 0);

    DataStruct eA; { const int n = 1 + (3*p); eA = DataStruct(uvec2(uint(n), uint(2*n))); }
    DataStruct eB; { const int n = 1 + (3*p+1); eB = DataStruct(uvec2(uint(n), uint(2*n))); }
    DataStruct eC; { const int n = 1 + (3*p+2); eC = DataStruct(uvec2(uint(n), uint(2*n))); }

    uint e[6] = { eA.q.x,eA.q.y,eB.q.x,eB.q.y,eC.q.x,eC.q.y };

    DataStruct vA; { vA = data[0]; }
    DataStruct vB; { vB = data[1]; }
    DataStruct vC; { vC = data[2]; }

    uint v[6] = { vA.q.x,vA.q.y,vB.q.x,vB.q.y,vC.q.x,vC.q.y };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<6; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    out_color = mask;
}
#version 460

layout (triangles) in;
layout (triangle_strip, max_vertices=3) out;
in gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
} gl_in[3];
out gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
};

struct DataStruct {uvec2 q;};

layout (location=0) in DataStruct inData[];
layout (location=0) out DataStruct outData;

void main ()
{
    gl_Position = gl_in[0].gl_Position;
    outData = inData[0];
    EmitVertex();
    gl_Position = gl_in[1].gl_Position;
    outData = inData[1];
    EmitVertex();
    gl_Position = gl_in[2].gl_Position;
    outData = inData[2];
    EmitVertex();
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require

struct DataStruct {uvec3 q;};


layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in DataStruct data[];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = (x < y) ? 0 : 1;
    const bool even = (p%2 == 0);

    DataStruct eA; { const int n = 1 + (3*p); eA = DataStruct(uvec3(uint(n), uint(2*n), uint(4*n))); }
    DataStruct eB; { const int n = 1 + (3*p+1); eB = DataStruct(uvec3(uint(n), uint(2*n), uint(4*n))); }
    DataStruct eC; { const int n = 1 + (3*p+2); eC = DataStruct(uvec3(uint(n), uint(2*n), uint(4*n))); }

    uint e[9] = { eA.q.x,eA.q.y,eA.q.z,eB.q.x,eB.q.y,eB.q.z,eC.q.x,eC.q.y,eC.q.z };

    DataStruct vA; { vA = data[0]; }
    DataStruct vB; { vB = data[1]; }
    DataStruct vC; { vC = data[2]; }

    uint v[9] = { vA.q.x,vA.q.y,vA.q.z,vB.q.x,vB.q.y,vB.q.z,vC.q.x,vC.q.y,vC.q.z };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<9; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    out_color = mask;
}
#version 460

layout (triangles) in;
layout (triangle_strip, max_vertices=3) out;
in gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
} gl_in[3];
out gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
};

struct DataStruct {uvec3 q;};

layout (location=0) in DataStruct inData[];
layout (location=0) out DataStruct outData;

void main ()
{
    gl_Position = gl_in[0].gl_Position;
    outData = inData[0];
    EmitVertex();
    gl_Position = gl_in[1].gl_Position;
    outData = inData[1];
    EmitVertex();
    gl_Position = gl_in[2].gl_Position;
    outData = inData[2];
    EmitVertex();
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require

struct DataStruct {uvec4 q;};


layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in DataStruct data[];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = (x < y) ? 0 : 1;
    const bool even = (p%2 == 0);

    DataStruct eA; { const int n = 1 + (3*p); eA = DataStruct(uvec4(uint(n), uint(2*n), uint(4*n), uint(8*n))); }
    DataStruct eB; { const int n = 1 + (3*p+1); eB = DataStruct(uvec4(uint(n), uint(2*n), uint(4*n), uint(8*n))); }
    DataStruct eC; { const int n = 1 + (3*p+2); eC = DataStruct(uvec4(uint(n), uint(2*n), uint(4*n), uint(8*n))); }

    uint e[12] = { eA.q.x,eA.q.y,eA.q.z,eA.q.w,eB.q.x,eB.q.y,eB.q.z,eB.q.w,eC.q.x,eC.q.y,eC.q.z,eC.q.w };

    DataStruct vA; { vA = data[0]; }
    DataStruct vB; { vB = data[1]; }
    DataStruct vC; { vC = data[2]; }

    uint v[12] = { vA.q.x,vA.q.y,vA.q.z,vA.q.w,vB.q.x,vB.q.y,vB.q.z,vB.q.w,vC.q.x,vC.q.y,vC.q.z,vC.q.w };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<12; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    out_color = mask;
}
#version 460

layout (triangles) in;
layout (triangle_strip, max_vertices=3) out;
in gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
} gl_in[3];
out gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
};

struct DataStruct {uvec4 q;};

layout (location=0) in DataStruct inData[];
layout (location=0) out DataStruct outData;

void main ()
{
    gl_Position = gl_in[0].gl_Position;
    outData = inData[0];
    EmitVertex();
    gl_Position = gl_in[1].gl_Position;
    outData = inData[1];
    EmitVertex();
    gl_Position = gl_in[2].gl_Position;
    outData = inData[2];
    EmitVertex();
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require




layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in float data[][2];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = (x < y) ? 0 : 1;
    const bool even = (p%2 == 0);

    float eA[2]; { const int n = 1 + (3*p); eA = float[2](float(n), float(3)*float(n)); }
    float eB[2]; { const int n = 1 + (3*p+1); eB = float[2](float(n), float(3)*float(n)); }
    float eC[2]; { const int n = 1 + (3*p+2); eC = float[2](float(n), float(3)*float(n)); }

    float e[6] = { eA[0],eA[1],eB[0],eB[1],eC[0],eC[1] };

    float vA[2]; { vA = float[2](data[0][0],data[0][1]); }
    float vB[2]; { vB = float[2](data[1][0],data[1][1]); }
    float vC[2]; { vC = float[2](data[2][0],data[2][1]); }

    float v[6] = { vA[0],vA[1],vB[0],vB[1],vC[0],vC[1] };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<6; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    out_color = mask;
}
#version 460

layout (triangles) in;
layout (triangle_strip, max_vertices=3) out;
in gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
} gl_in[3];
out gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
};



layout (location=0) in float inData[][2];
layout (location=0) out float outData[2];

void main ()
{
    gl_Position = gl_in[0].gl_Position;
    outData = inData[0];
    EmitVertex();
    gl_Position = gl_in[1].gl_Position;
    outData = inData[1];
    EmitVertex();
    gl_Position = gl_in[2].gl_Position;
    outData = inData[2];
    EmitVertex();
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require




layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in vec2 data[][2];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = (x < y) ? 0 : 1;
    const bool even = (p%2 == 0);

    vec2 eA[2]; { const int n = 1 + (3*p); eA = vec2[2](vec2(float(n), float(2*n)), float(3)*vec2(float(n), float(2*n))); }
    vec2 eB[2]; { const int n = 1 + (3*p+1); eB = vec2[2](vec2(float(n), float(2*n)), float(3)*vec2(float(n), float(2*n))); }
    vec2 eC[2]; { const int n = 1 + (3*p+2); eC = vec2[2](vec2(float(n), float(2*n)), float(3)*vec2(float(n), float(2*n))); }

    float e[12] = { eA[0].x,eA[0].y,eA[1].x,eA[1].y,eB[0].x,eB[0].y,eB[1].x,eB[1].y,eC[0].x,eC[0].y,eC[1].x,eC[1].y };

    vec2 vA[2]; { vA = vec2[2](data[0][0],data[0][1]); }
    vec2 vB[2]; { vB = vec2[2](data[1][0],data[1][1]); }
    vec2 vC[2]; { vC = vec2[2](data[2][0],data[2][1]); }

    float v[12] = { vA[0].x,vA[0].y,vA[1].x,vA[1].y,vB[0].x,vB[0].y,vB[1].x,vB[1].y,vC[0].x,vC[0].y,vC[1].x,vC[1].y };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<12; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    out_color = mask;
}
#version 460

layout (triangles) in;
layout (triangle_strip, max_vertices=3) out;
in gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
} gl_in[3];
out gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
};



layout (location=0) in vec2 inData[][2];
layout (location=0) out vec2 outData[2];

void main ()
{
    gl_Position = gl_in[0].gl_Position;
    outData = inData[0];
    EmitVertex();
    gl_Position = gl_in[1].gl_Position;
    outData = inData[1];
    EmitVertex();
    gl_Position = gl_in[2].gl_Position;
    outData = inData[2];
    EmitVertex();
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require




layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in vec3 data[][2];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = (x < y) ? 0 : 1;
    const bool even = (p%2 == 0);

    vec3 eA[2]; { const int n = 1 + (3*p); eA = vec3[2](vec3(float(n), float(2*n), float(4*n)), float(3)*vec3(float(n), float(2*n), float(4*n))); }
    vec3 eB[2]; { const int n = 1 + (3*p+1); eB = vec3[2](vec3(float(n), float(2*n), float(4*n)), float(3)*vec3(float(n), float(2*n), float(4*n))); }
    vec3 eC[2]; { const int n = 1 + (3*p+2); eC = vec3[2](vec3(float(n), float(2*n), float(4*n)), float(3)*vec3(float(n), float(2*n), float(4*n))); }

    float e[18] = { eA[0].x,eA[0].y,eA[0].z,eA[1].x,eA[1].y,eA[1].z,eB[0].x,eB[0].y,eB[0].z,eB[1].x,eB[1].y,eB[1].z,eC[0].x,eC[0].y,eC[0].z,eC[1].x,eC[1].y,eC[1].z };

    vec3 vA[2]; { vA = vec3[2](data[0][0],data[0][1]); }
    vec3 vB[2]; { vB = vec3[2](data[1][0],data[1][1]); }
    vec3 vC[2]; { vC = vec3[2](data[2][0],data[2][1]); }

    float v[18] = { vA[0].x,vA[0].y,vA[0].z,vA[1].x,vA[1].y,vA[1].z,vB[0].x,vB[0].y,vB[0].z,vB[1].x,vB[1].y,vB[1].z,vC[0].x,vC[0].y,vC[0].z,vC[1].x,vC[1].y,vC[1].z };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<18; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    out_color = mask;
}
#version 460

layout (triangles) in;
layout (triangle_strip, max_vertices=3) out;
in gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
} gl_in[3];
out gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
};



layout (location=0) in vec3 inData[][2];
layout (location=0) out vec3 outData[2];

void main ()
{
    gl_Position = gl_in[0].gl_Position;
    outData = inData[0];
    EmitVertex();
    gl_Position = gl_in[1].gl_Position;
    outData = inData[1];
    EmitVertex();
    gl_Position = gl_in[2].gl_Position;
    outData = inData[2];
    EmitVertex();
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require




layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in vec4 data[][2];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = (x < y) ? 0 : 1;
    const bool even = (p%2 == 0);

    vec4 eA[2]; { const int n = 1 + (3*p); eA = vec4[2](vec4(float(n), float(2*n), float(4*n), float(8*n)), float(3)*vec4(float(n), float(2*n), float(4*n), float(8*n))); }
    vec4 eB[2]; { const int n = 1 + (3*p+1); eB = vec4[2](vec4(float(n), float(2*n), float(4*n), float(8*n)), float(3)*vec4(float(n), float(2*n), float(4*n), float(8*n))); }
    vec4 eC[2]; { const int n = 1 + (3*p+2); eC = vec4[2](vec4(float(n), float(2*n), float(4*n), float(8*n)), float(3)*vec4(float(n), float(2*n), float(4*n), float(8*n))); }

    float e[24] = { eA[0].x,eA[0].y,eA[0].z,eA[0].w,eA[1].x,eA[1].y,eA[1].z,eA[1].w,eB[0].x,eB[0].y,eB[0].z,eB[0].w,eB[1].x,eB[1].y,eB[1].z,eB[1].w,eC[0].x,eC[0].y,eC[0].z,eC[0].w,eC[1].x,eC[1].y,eC[1].z,eC[1].w };

    vec4 vA[2]; { vA = vec4[2](data[0][0],data[0][1]); }
    vec4 vB[2]; { vB = vec4[2](data[1][0],data[1][1]); }
    vec4 vC[2]; { vC = vec4[2](data[2][0],data[2][1]); }

    float v[24] = { vA[0].x,vA[0].y,vA[0].z,vA[0].w,vA[1].x,vA[1].y,vA[1].z,vA[1].w,vB[0].x,vB[0].y,vB[0].z,vB[0].w,vB[1].x,vB[1].y,vB[1].z,vB[1].w,vC[0].x,vC[0].y,vC[0].z,vC[0].w,vC[1].x,vC[1].y,vC[1].z,vC[1].w };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<24; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    out_color = mask;
}
#version 460

layout (triangles) in;
layout (triangle_strip, max_vertices=3) out;
in gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
} gl_in[3];
out gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
};



layout (location=0) in vec4 inData[][2];
layout (location=0) out vec4 outData[2];

void main ()
{
    gl_Position = gl_in[0].gl_Position;
    outData = inData[0];
    EmitVertex();
    gl_Position = gl_in[1].gl_Position;
    outData = inData[1];
    EmitVertex();
    gl_Position = gl_in[2].gl_Position;
    outData = inData[2];
    EmitVertex();
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require




layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in double data[][2];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = (x < y) ? 0 : 1;
    const bool even = (p%2 == 0);

    double eA[2]; { const int n = 1 + (3*p); eA = double[2](double(n), double(3)*double(n)); }
    double eB[2]; { const int n = 1 + (3*p+1); eB = double[2](double(n), double(3)*double(n)); }
    double eC[2]; { const int n = 1 + (3*p+2); eC = double[2](double(n), double(3)*double(n)); }

    double e[6] = { eA[0],eA[1],eB[0],eB[1],eC[0],eC[1] };

    double vA[2]; { vA = double[2](data[0][0],data[0][1]); }
    double vB[2]; { vB = double[2](data[1][0],data[1][1]); }
    double vC[2]; { vC = double[2](data[2][0],data[2][1]); }

    double v[6] = { vA[0],vA[1],vB[0],vB[1],vC[0],vC[1] };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<6; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    out_color = mask;
}
#version 460

layout (triangles) in;
layout (triangle_strip, max_vertices=3) out;
in gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
} gl_in[3];
out gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
};



layout (location=0) in double inData[][2];
layout (location=0) out double outData[2];

void main ()
{
    gl_Position = gl_in[0].gl_Position;
    outData = inData[0];
    EmitVertex();
    gl_Position = gl_in[1].gl_Position;
    outData = inData[1];
    EmitVertex();
    gl_Position = gl_in[2].gl_Position;
    outData = inData[2];
    EmitVertex();
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require




layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in dvec2 data[][2];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = (x < y) ? 0 : 1;
    const bool even = (p%2 == 0);

    dvec2 eA[2]; { const int n = 1 + (3*p); eA = dvec2[2](dvec2(double(n), double(2*n)), double(3)*dvec2(double(n), double(2*n))); }
    dvec2 eB[2]; { const int n = 1 + (3*p+1); eB = dvec2[2](dvec2(double(n), double(2*n)), double(3)*dvec2(double(n), double(2*n))); }
    dvec2 eC[2]; { const int n = 1 + (3*p+2); eC = dvec2[2](dvec2(double(n), double(2*n)), double(3)*dvec2(double(n), double(2*n))); }

    double e[12] = { eA[0].x,eA[0].y,eA[1].x,eA[1].y,eB[0].x,eB[0].y,eB[1].x,eB[1].y,eC[0].x,eC[0].y,eC[1].x,eC[1].y };

    dvec2 vA[2]; { vA = dvec2[2](data[0][0],data[0][1]); }
    dvec2 vB[2]; { vB = dvec2[2](data[1][0],data[1][1]); }
    dvec2 vC[2]; { vC = dvec2[2](data[2][0],data[2][1]); }

    double v[12] = { vA[0].x,vA[0].y,vA[1].x,vA[1].y,vB[0].x,vB[0].y,vB[1].x,vB[1].y,vC[0].x,vC[0].y,vC[1].x,vC[1].y };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<12; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    out_color = mask;
}
#version 460

layout (triangles) in;
layout (triangle_strip, max_vertices=3) out;
in gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
} gl_in[3];
out gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
};



layout (location=0) in dvec2 inData[][2];
layout (location=0) out dvec2 outData[2];

void main ()
{
    gl_Position = gl_in[0].gl_Position;
    outData = inData[0];
    EmitVertex();
    gl_Position = gl_in[1].gl_Position;
    outData = inData[1];
    EmitVertex();
    gl_Position = gl_in[2].gl_Position;
    outData = inData[2];
    EmitVertex();
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require




layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in dvec3 data[][2];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = (x < y) ? 0 : 1;
    const bool even = (p%2 == 0);

    dvec3 eA[2]; { const int n = 1 + (3*p); eA = dvec3[2](dvec3(double(n), double(2*n), double(4*n)), double(3)*dvec3(double(n), double(2*n), double(4*n))); }
    dvec3 eB[2]; { const int n = 1 + (3*p+1); eB = dvec3[2](dvec3(double(n), double(2*n), double(4*n)), double(3)*dvec3(double(n), double(2*n), double(4*n))); }
    dvec3 eC[2]; { const int n = 1 + (3*p+2); eC = dvec3[2](dvec3(double(n), double(2*n), double(4*n)), double(3)*dvec3(double(n), double(2*n), double(4*n))); }

    double e[18] = { eA[0].x,eA[0].y,eA[0].z,eA[1].x,eA[1].y,eA[1].z,eB[0].x,eB[0].y,eB[0].z,eB[1].x,eB[1].y,eB[1].z,eC[0].x,eC[0].y,eC[0].z,eC[1].x,eC[1].y,eC[1].z };

    dvec3 vA[2]; { vA = dvec3[2](data[0][0],data[0][1]); }
    dvec3 vB[2]; { vB = dvec3[2](data[1][0],data[1][1]); }
    dvec3 vC[2]; { vC = dvec3[2](data[2][0],data[2][1]); }

    double v[18] = { vA[0].x,vA[0].y,vA[0].z,vA[1].x,vA[1].y,vA[1].z,vB[0].x,vB[0].y,vB[0].z,vB[1].x,vB[1].y,vB[1].z,vC[0].x,vC[0].y,vC[0].z,vC[1].x,vC[1].y,vC[1].z };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<18; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    out_color = mask;
}
#version 460

layout (triangles) in;
layout (triangle_strip, max_vertices=3) out;
in gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
} gl_in[3];
out gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
};



layout (location=0) in dvec3 inData[][2];
layout (location=0) out dvec3 outData[2];

void main ()
{
    gl_Position = gl_in[0].gl_Position;
    outData = inData[0];
    EmitVertex();
    gl_Position = gl_in[1].gl_Position;
    outData = inData[1];
    EmitVertex();
    gl_Position = gl_in[2].gl_Position;
    outData = inData[2];
    EmitVertex();
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require




layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in dvec4 data[][2];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = (x < y) ? 0 : 1;
    const bool even = (p%2 == 0);

    dvec4 eA[2]; { const int n = 1 + (3*p); eA = dvec4[2](dvec4(double(n), double(2*n), double(4*n), double(8*n)), double(3)*dvec4(double(n), double(2*n), double(4*n), double(8*n))); }
    dvec4 eB[2]; { const int n = 1 + (3*p+1); eB = dvec4[2](dvec4(double(n), double(2*n), double(4*n), double(8*n)), double(3)*dvec4(double(n), double(2*n), double(4*n), double(8*n))); }
    dvec4 eC[2]; { const int n = 1 + (3*p+2); eC = dvec4[2](dvec4(double(n), double(2*n), double(4*n), double(8*n)), double(3)*dvec4(double(n), double(2*n), double(4*n), double(8*n))); }

    double e[24] = { eA[0].x,eA[0].y,eA[0].z,eA[0].w,eA[1].x,eA[1].y,eA[1].z,eA[1].w,eB[0].x,eB[0].y,eB[0].z,eB[0].w,eB[1].x,eB[1].y,eB[1].z,eB[1].w,eC[0].x,eC[0].y,eC[0].z,eC[0].w,eC[1].x,eC[1].y,eC[1].z,eC[1].w };

    dvec4 vA[2]; { vA = dvec4[2](data[0][0],data[0][1]); }
    dvec4 vB[2]; { vB = dvec4[2](data[1][0],data[1][1]); }
    dvec4 vC[2]; { vC = dvec4[2](data[2][0],data[2][1]); }

    double v[24] = { vA[0].x,vA[0].y,vA[0].z,vA[0].w,vA[1].x,vA[1].y,vA[1].z,vA[1].w,vB[0].x,vB[0].y,vB[0].z,vB[0].w,vB[1].x,vB[1].y,vB[1].z,vB[1].w,vC[0].x,vC[0].y,vC[0].z,vC[0].w,vC[1].x,vC[1].y,vC[1].z,vC[1].w };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<24; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    out_color = mask;
}
#version 460

layout (triangles) in;
layout (triangle_strip, max_vertices=3) out;
in gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
} gl_in[3];
out gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
};



layout (location=0) in dvec4 inData[][2];
layout (location=0) out dvec4 outData[2];

void main ()
{
    gl_Position = gl_in[0].gl_Position;
    outData = inData[0];
    EmitVertex();
    gl_Position = gl_in[1].gl_Position;
    outData = inData[1];
    EmitVertex();
    gl_Position = gl_in[2].gl_Position;
    outData = inData[2];
    EmitVertex();
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require




layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in int data[][2];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = (x < y) ? 0 : 1;
    const bool even = (p%2 == 0);

    int eA[2]; { const int n = 1 + (3*p); eA = int[2](int(n), int(3)*int(n)); }
    int eB[2]; { const int n = 1 + (3*p+1); eB = int[2](int(n), int(3)*int(n)); }
    int eC[2]; { const int n = 1 + (3*p+2); eC = int[2](int(n), int(3)*int(n)); }

    int e[6] = { eA[0],eA[1],eB[0],eB[1],eC[0],eC[1] };

    int vA[2]; { vA = int[2](data[0][0],data[0][1]); }
    int vB[2]; { vB = int[2](data[1][0],data[1][1]); }
    int vC[2]; { vC = int[2](data[2][0],data[2][1]); }

    int v[6] = { vA[0],vA[1],vB[0],vB[1],vC[0],vC[1] };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<6; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    out_color = mask;
}
#version 460

layout (triangles) in;
layout (triangle_strip, max_vertices=3) out;
in gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
} gl_in[3];
out gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
};



layout (location=0) in int inData[][2];
layout (location=0) out int outData[2];

void main ()
{
    gl_Position = gl_in[0].gl_Position;
    outData = inData[0];
    EmitVertex();
    gl_Position = gl_in[1].gl_Position;
    outData = inData[1];
    EmitVertex();
    gl_Position = gl_in[2].gl_Position;
    outData = inData[2];
    EmitVertex();
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require




layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in ivec2 data[][2];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = (x < y) ? 0 : 1;
    const bool even = (p%2 == 0);

    ivec2 eA[2]; { const int n = 1 + (3*p); eA = ivec2[2](ivec2(int(n), int(2*n)), int(3)*ivec2(int(n), int(2*n))); }
    ivec2 eB[2]; { const int n = 1 + (3*p+1); eB = ivec2[2](ivec2(int(n), int(2*n)), int(3)*ivec2(int(n), int(2*n))); }
    ivec2 eC[2]; { const int n = 1 + (3*p+2); eC = ivec2[2](ivec2(int(n), int(2*n)), int(3)*ivec2(int(n), int(2*n))); }

    int e[12] = { eA[0].x,eA[0].y,eA[1].x,eA[1].y,eB[0].x,eB[0].y,eB[1].x,eB[1].y,eC[0].x,eC[0].y,eC[1].x,eC[1].y };

    ivec2 vA[2]; { vA = ivec2[2](data[0][0],data[0][1]); }
    ivec2 vB[2]; { vB = ivec2[2](data[1][0],data[1][1]); }
    ivec2 vC[2]; { vC = ivec2[2](data[2][0],data[2][1]); }

    int v[12] = { vA[0].x,vA[0].y,vA[1].x,vA[1].y,vB[0].x,vB[0].y,vB[1].x,vB[1].y,vC[0].x,vC[0].y,vC[1].x,vC[1].y };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<12; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    out_color = mask;
}
#version 460

layout (triangles) in;
layout (triangle_strip, max_vertices=3) out;
in gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
} gl_in[3];
out gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
};



layout (location=0) in ivec2 inData[][2];
layout (location=0) out ivec2 outData[2];

void main ()
{
    gl_Position = gl_in[0].gl_Position;
    outData = inData[0];
    EmitVertex();
    gl_Position = gl_in[1].gl_Position;
    outData = inData[1];
    EmitVertex();
    gl_Position = gl_in[2].gl_Position;
    outData = inData[2];
    EmitVertex();
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require




layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in ivec3 data[][2];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = (x < y) ? 0 : 1;
    const bool even = (p%2 == 0);

    ivec3 eA[2]; { const int n = 1 + (3*p); eA = ivec3[2](ivec3(int(n), int(2*n), int(4*n)), int(3)*ivec3(int(n), int(2*n), int(4*n))); }
    ivec3 eB[2]; { const int n = 1 + (3*p+1); eB = ivec3[2](ivec3(int(n), int(2*n), int(4*n)), int(3)*ivec3(int(n), int(2*n), int(4*n))); }
    ivec3 eC[2]; { const int n = 1 + (3*p+2); eC = ivec3[2](ivec3(int(n), int(2*n), int(4*n)), int(3)*ivec3(int(n), int(2*n), int(4*n))); }

    int e[18] = { eA[0].x,eA[0].y,eA[0].z,eA[1].x,eA[1].y,eA[1].z,eB[0].x,eB[0].y,eB[0].z,eB[1].x,eB[1].y,eB[1].z,eC[0].x,eC[0].y,eC[0].z,eC[1].x,eC[1].y,eC[1].z };

    ivec3 vA[2]; { vA = ivec3[2](data[0][0],data[0][1]); }
    ivec3 vB[2]; { vB = ivec3[2](data[1][0],data[1][1]); }
    ivec3 vC[2]; { vC = ivec3[2](data[2][0],data[2][1]); }

    int v[18] = { vA[0].x,vA[0].y,vA[0].z,vA[1].x,vA[1].y,vA[1].z,vB[0].x,vB[0].y,vB[0].z,vB[1].x,vB[1].y,vB[1].z,vC[0].x,vC[0].y,vC[0].z,vC[1].x,vC[1].y,vC[1].z };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<18; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    out_color = mask;
}
#version 460

layout (triangles) in;
layout (triangle_strip, max_vertices=3) out;
in gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
} gl_in[3];
out gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
};



layout (location=0) in ivec3 inData[][2];
layout (location=0) out ivec3 outData[2];

void main ()
{
    gl_Position = gl_in[0].gl_Position;
    outData = inData[0];
    EmitVertex();
    gl_Position = gl_in[1].gl_Position;
    outData = inData[1];
    EmitVertex();
    gl_Position = gl_in[2].gl_Position;
    outData = inData[2];
    EmitVertex();
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require




layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in ivec4 data[][2];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = (x < y) ? 0 : 1;
    const bool even = (p%2 == 0);

    ivec4 eA[2]; { const int n = 1 + (3*p); eA = ivec4[2](ivec4(int(n), int(2*n), int(4*n), int(8*n)), int(3)*ivec4(int(n), int(2*n), int(4*n), int(8*n))); }
    ivec4 eB[2]; { const int n = 1 + (3*p+1); eB = ivec4[2](ivec4(int(n), int(2*n), int(4*n), int(8*n)), int(3)*ivec4(int(n), int(2*n), int(4*n), int(8*n))); }
    ivec4 eC[2]; { const int n = 1 + (3*p+2); eC = ivec4[2](ivec4(int(n), int(2*n), int(4*n), int(8*n)), int(3)*ivec4(int(n), int(2*n), int(4*n), int(8*n))); }

    int e[24] = { eA[0].x,eA[0].y,eA[0].z,eA[0].w,eA[1].x,eA[1].y,eA[1].z,eA[1].w,eB[0].x,eB[0].y,eB[0].z,eB[0].w,eB[1].x,eB[1].y,eB[1].z,eB[1].w,eC[0].x,eC[0].y,eC[0].z,eC[0].w,eC[1].x,eC[1].y,eC[1].z,eC[1].w };

    ivec4 vA[2]; { vA = ivec4[2](data[0][0],data[0][1]); }
    ivec4 vB[2]; { vB = ivec4[2](data[1][0],data[1][1]); }
    ivec4 vC[2]; { vC = ivec4[2](data[2][0],data[2][1]); }

    int v[24] = { vA[0].x,vA[0].y,vA[0].z,vA[0].w,vA[1].x,vA[1].y,vA[1].z,vA[1].w,vB[0].x,vB[0].y,vB[0].z,vB[0].w,vB[1].x,vB[1].y,vB[1].z,vB[1].w,vC[0].x,vC[0].y,vC[0].z,vC[0].w,vC[1].x,vC[1].y,vC[1].z,vC[1].w };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<24; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    out_color = mask;
}
#version 460

layout (triangles) in;
layout (triangle_strip, max_vertices=3) out;
in gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
} gl_in[3];
out gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
};



layout (location=0) in ivec4 inData[][2];
layout (location=0) out ivec4 outData[2];

void main ()
{
    gl_Position = gl_in[0].gl_Position;
    outData = inData[0];
    EmitVertex();
    gl_Position = gl_in[1].gl_Position;
    outData = inData[1];
    EmitVertex();
    gl_Position = gl_in[2].gl_Position;
    outData = inData[2];
    EmitVertex();
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require




layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in uint data[][2];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = (x < y) ? 0 : 1;
    const bool even = (p%2 == 0);

    uint eA[2]; { const int n = 1 + (3*p); eA = uint[2](uint(n), uint(3)*uint(n)); }
    uint eB[2]; { const int n = 1 + (3*p+1); eB = uint[2](uint(n), uint(3)*uint(n)); }
    uint eC[2]; { const int n = 1 + (3*p+2); eC = uint[2](uint(n), uint(3)*uint(n)); }

    uint e[6] = { eA[0],eA[1],eB[0],eB[1],eC[0],eC[1] };

    uint vA[2]; { vA = uint[2](data[0][0],data[0][1]); }
    uint vB[2]; { vB = uint[2](data[1][0],data[1][1]); }
    uint vC[2]; { vC = uint[2](data[2][0],data[2][1]); }

    uint v[6] = { vA[0],vA[1],vB[0],vB[1],vC[0],vC[1] };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<6; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    out_color = mask;
}
#version 460

layout (triangles) in;
layout (triangle_strip, max_vertices=3) out;
in gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
} gl_in[3];
out gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
};



layout (location=0) in uint inData[][2];
layout (location=0) out uint outData[2];

void main ()
{
    gl_Position = gl_in[0].gl_Position;
    outData = inData[0];
    EmitVertex();
    gl_Position = gl_in[1].gl_Position;
    outData = inData[1];
    EmitVertex();
    gl_Position = gl_in[2].gl_Position;
    outData = inData[2];
    EmitVertex();
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require




layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in uvec2 data[][2];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = (x < y) ? 0 : 1;
    const bool even = (p%2 == 0);

    uvec2 eA[2]; { const int n = 1 + (3*p); eA = uvec2[2](uvec2(uint(n), uint(2*n)), uint(3)*uvec2(uint(n), uint(2*n))); }
    uvec2 eB[2]; { const int n = 1 + (3*p+1); eB = uvec2[2](uvec2(uint(n), uint(2*n)), uint(3)*uvec2(uint(n), uint(2*n))); }
    uvec2 eC[2]; { const int n = 1 + (3*p+2); eC = uvec2[2](uvec2(uint(n), uint(2*n)), uint(3)*uvec2(uint(n), uint(2*n))); }

    uint e[12] = { eA[0].x,eA[0].y,eA[1].x,eA[1].y,eB[0].x,eB[0].y,eB[1].x,eB[1].y,eC[0].x,eC[0].y,eC[1].x,eC[1].y };

    uvec2 vA[2]; { vA = uvec2[2](data[0][0],data[0][1]); }
    uvec2 vB[2]; { vB = uvec2[2](data[1][0],data[1][1]); }
    uvec2 vC[2]; { vC = uvec2[2](data[2][0],data[2][1]); }

    uint v[12] = { vA[0].x,vA[0].y,vA[1].x,vA[1].y,vB[0].x,vB[0].y,vB[1].x,vB[1].y,vC[0].x,vC[0].y,vC[1].x,vC[1].y };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<12; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    out_color = mask;
}
#version 460

layout (triangles) in;
layout (triangle_strip, max_vertices=3) out;
in gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
} gl_in[3];
out gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
};



layout (location=0) in uvec2 inData[][2];
layout (location=0) out uvec2 outData[2];

void main ()
{
    gl_Position = gl_in[0].gl_Position;
    outData = inData[0];
    EmitVertex();
    gl_Position = gl_in[1].gl_Position;
    outData = inData[1];
    EmitVertex();
    gl_Position = gl_in[2].gl_Position;
    outData = inData[2];
    EmitVertex();
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require




layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in uvec3 data[][2];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = (x < y) ? 0 : 1;
    const bool even = (p%2 == 0);

    uvec3 eA[2]; { const int n = 1 + (3*p); eA = uvec3[2](uvec3(uint(n), uint(2*n), uint(4*n)), uint(3)*uvec3(uint(n), uint(2*n), uint(4*n))); }
    uvec3 eB[2]; { const int n = 1 + (3*p+1); eB = uvec3[2](uvec3(uint(n), uint(2*n), uint(4*n)), uint(3)*uvec3(uint(n), uint(2*n), uint(4*n))); }
    uvec3 eC[2]; { const int n = 1 + (3*p+2); eC = uvec3[2](uvec3(uint(n), uint(2*n), uint(4*n)), uint(3)*uvec3(uint(n), uint(2*n), uint(4*n))); }

    uint e[18] = { eA[0].x,eA[0].y,eA[0].z,eA[1].x,eA[1].y,eA[1].z,eB[0].x,eB[0].y,eB[0].z,eB[1].x,eB[1].y,eB[1].z,eC[0].x,eC[0].y,eC[0].z,eC[1].x,eC[1].y,eC[1].z };

    uvec3 vA[2]; { vA = uvec3[2](data[0][0],data[0][1]); }
    uvec3 vB[2]; { vB = uvec3[2](data[1][0],data[1][1]); }
    uvec3 vC[2]; { vC = uvec3[2](data[2][0],data[2][1]); }

    uint v[18] = { vA[0].x,vA[0].y,vA[0].z,vA[1].x,vA[1].y,vA[1].z,vB[0].x,vB[0].y,vB[0].z,vB[1].x,vB[1].y,vB[1].z,vC[0].x,vC[0].y,vC[0].z,vC[1].x,vC[1].y,vC[1].z };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<18; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    out_color = mask;
}
#version 460

layout (triangles) in;
layout (triangle_strip, max_vertices=3) out;
in gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
} gl_in[3];
out gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
};



layout (location=0) in uvec3 inData[][2];
layout (location=0) out uvec3 outData[2];

void main ()
{
    gl_Position = gl_in[0].gl_Position;
    outData = inData[0];
    EmitVertex();
    gl_Position = gl_in[1].gl_Position;
    outData = inData[1];
    EmitVertex();
    gl_Position = gl_in[2].gl_Position;
    outData = inData[2];
    EmitVertex();
}
#version 450
#extension GL_EXT_fragment_shader_barycentric : require




layout(location = 0) out uvec4 out_color;

layout(location = 0) pervertexEXT in uvec4 data[][2];
void main()
{
    const int  w    = 8;
    const int  h    = 8;
    const int  x    = int(gl_FragCoord.x - 0.5f);
    const int  y    = int(gl_FragCoord.y - 0.5f);
    const int  p    = (x < y) ? 0 : 1;
    const bool even = (p%2 == 0);

    uvec4 eA[2]; { const int n = 1 + (3*p); eA = uvec4[2](uvec4(uint(n), uint(2*n), uint(4*n), uint(8*n)), uint(3)*uvec4(uint(n), uint(2*n), uint(4*n), uint(8*n))); }
    uvec4 eB[2]; { const int n = 1 + (3*p+1); eB = uvec4[2](uvec4(uint(n), uint(2*n), uint(4*n), uint(8*n)), uint(3)*uvec4(uint(n), uint(2*n), uint(4*n), uint(8*n))); }
    uvec4 eC[2]; { const int n = 1 + (3*p+2); eC = uvec4[2](uvec4(uint(n), uint(2*n), uint(4*n), uint(8*n)), uint(3)*uvec4(uint(n), uint(2*n), uint(4*n), uint(8*n))); }

    uint e[24] = { eA[0].x,eA[0].y,eA[0].z,eA[0].w,eA[1].x,eA[1].y,eA[1].z,eA[1].w,eB[0].x,eB[0].y,eB[0].z,eB[0].w,eB[1].x,eB[1].y,eB[1].z,eB[1].w,eC[0].x,eC[0].y,eC[0].z,eC[0].w,eC[1].x,eC[1].y,eC[1].z,eC[1].w };

    uvec4 vA[2]; { vA = uvec4[2](data[0][0],data[0][1]); }
    uvec4 vB[2]; { vB = uvec4[2](data[1][0],data[1][1]); }
    uvec4 vC[2]; { vC = uvec4[2](data[2][0],data[2][1]); }

    uint v[24] = { vA[0].x,vA[0].y,vA[0].z,vA[0].w,vA[1].x,vA[1].y,vA[1].z,vA[1].w,vB[0].x,vB[0].y,vB[0].z,vB[0].w,vB[1].x,vB[1].y,vB[1].z,vB[1].w,vC[0].x,vC[0].y,vC[0].z,vC[0].w,vC[1].x,vC[1].y,vC[1].z,vC[1].w };
    uvec4 mask = uvec4(0);

    for (int i = 0; i<24; i++)
        if (e[i] == v[i])
            mask.x = mask.x | (1<<i);
    out_color = mask;
}
#version 460

layout (triangles) in;
layout (triangle_strip, max_vertices=3) out;
in gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
} gl_in[3];
out gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
};



layout (location=0) in uvec4 inData[][2];
layout (location=0) out uvec4 outData[2];

void main ()
{
    gl_Position = gl_in[0].gl_Position;
    outData = inData[0];
    EmitVertex();
    gl_Position = gl_in[1].gl_Position;
    outData = inData[1];
    EmitVertex();
    gl_Position = gl_in[2].gl_Position;
    outData = inData[2];
    EmitVertex();
}
#version 460

layout (triangles) in;
layout (triangle_strip, max_vertices=3) out;
in gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
} gl_in[3];
out gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
};



struct InOutDataStruct {uint idx; float data;};
layout(location = 0) in InOutDataStruct inParam[];
layout (location=0) flat out InOutDataStruct outParam;

void main ()
{
    gl_Position = gl_in[0].gl_Position;
    outParam = inParam[0];
    EmitVertex();
    gl_Position = gl_in[1].gl_Position;
    outParam = inParam[1];
    EmitVertex();
    gl_Position = gl_in[2].gl_Position;
    outParam = inParam[2];
    EmitVertex();
}
#version 460

layout (triangles) in;
layout (triangle_strip, max_vertices=3) out;
in gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
} gl_in[3];
out gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
};



struct InOutDataStruct {uint idx; vec2 data;};
layout(location = 0) in InOutDataStruct inParam[];
layout (location=0) flat out InOutDataStruct outParam;

void main ()
{
    gl_Position = gl_in[0].gl_Position;
    outParam = inParam[0];
    EmitVertex();
    gl_Position = gl_in[1].gl_Position;
    outParam = inParam[1];
    EmitVertex();
    gl_Position = gl_in[2].gl_Position;
    outParam = inParam[2];
    EmitVertex();
}
#version 460

layout (triangles) in;
layout (triangle_strip, max_vertices=3) out;
in gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
} gl_in[3];
out gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
};



struct InOutDataStruct {uint idx; vec3 data;};
layout(location = 0) in InOutDataStruct inParam[];
layout (location=0) flat out InOutDataStruct outParam;

void main ()
{
    gl_Position = gl_in[0].gl_Position;
    outParam = inParam[0];
    EmitVertex();
    gl_Position = gl_in[1].gl_Position;
    outParam = inParam[1];
    EmitVertex();
    gl_Position = gl_in[2].gl_Position;
    outParam = inParam[2];
    EmitVertex();
}
#version 460

layout (triangles) in;
layout (triangle_strip, max_vertices=3) out;
in gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
} gl_in[3];
out gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
};



struct InOutDataStruct {uint idx; vec4 data;};
layout(location = 0) in InOutDataStruct inParam[];
layout (location=0) flat out InOutDataStruct outParam;

void main ()
{
    gl_Position = gl_in[0].gl_Position;
    outParam = inParam[0];
    EmitVertex();
    gl_Position = gl_in[1].gl_Position;
    outParam = inParam[1];
    EmitVertex();
    gl_Position = gl_in[2].gl_Position;
    outParam = inParam[2];
    EmitVertex();
}
#version 460

layout (triangles) in;
layout (triangle_strip, max_vertices=3) out;
in gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
} gl_in[3];
out gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
};



struct InOutDataStruct {uint idx; double data;};
layout(location = 0) in InOutDataStruct inParam[];
layout (location=0) flat out InOutDataStruct outParam;

void main ()
{
    gl_Position = gl_in[0].gl_Position;
    outParam = inParam[0];
    EmitVertex();
    gl_Position = gl_in[1].gl_Position;
    outParam = inParam[1];
    EmitVertex();
    gl_Position = gl_in[2].gl_Position;
    outParam = inParam[2];
    EmitVertex();
}
#version 460

layout (triangles) in;
layout (triangle_strip, max_vertices=3) out;
in gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
} gl_in[3];
out gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
};



struct InOutDataStruct {uint idx; dvec2 data;};
layout(location = 0) in InOutDataStruct inParam[];
layout (location=0) flat out InOutDataStruct outParam;

void main ()
{
    gl_Position = gl_in[0].gl_Position;
    outParam = inParam[0];
    EmitVertex();
    gl_Position = gl_in[1].gl_Position;
    outParam = inParam[1];
    EmitVertex();
    gl_Position = gl_in[2].gl_Position;
    outParam = inParam[2];
    EmitVertex();
}
#version 460

layout (triangles) in;
layout (triangle_strip, max_vertices=3) out;
in gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
} gl_in[3];
out gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
};



struct InOutDataStruct {uint idx; dvec3 data;};
layout(location = 0) in InOutDataStruct inParam[];
layout (location=0) flat out InOutDataStruct outParam;

void main ()
{
    gl_Position = gl_in[0].gl_Position;
    outParam = inParam[0];
    EmitVertex();
    gl_Position = gl_in[1].gl_Position;
    outParam = inParam[1];
    EmitVertex();
    gl_Position = gl_in[2].gl_Position;
    outParam = inParam[2];
    EmitVertex();
}
#version 460

layout (triangles) in;
layout (triangle_strip, max_vertices=3) out;
in gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
} gl_in[3];
out gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
};



struct InOutDataStruct {uint idx; dvec4 data;};
layout(location = 0) in InOutDataStruct inParam[];
layout (location=0) flat out InOutDataStruct outParam;

void main ()
{
    gl_Position = gl_in[0].gl_Position;
    outParam = inParam[0];
    EmitVertex();
    gl_Position = gl_in[1].gl_Position;
    outParam = inParam[1];
    EmitVertex();
    gl_Position = gl_in[2].gl_Position;
    outParam = inParam[2];
    EmitVertex();
}
#version 460

layout (triangles) in;
layout (triangle_strip, max_vertices=3) out;
in gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
} gl_in[3];
out gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
};



struct InOutDataStruct {uint idx; int data;};
layout(location = 0) in InOutDataStruct inParam[];
layout (location=0) flat out InOutDataStruct outParam;

void main ()
{
    gl_Position = gl_in[0].gl_Position;
    outParam = inParam[0];
    EmitVertex();
    gl_Position = gl_in[1].gl_Position;
    outParam = inParam[1];
    EmitVertex();
    gl_Position = gl_in[2].gl_Position;
    outParam = inParam[2];
    EmitVertex();
}
#version 460

layout (triangles) in;
layout (triangle_strip, max_vertices=3) out;
in gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
} gl_in[3];
out gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
};



struct InOutDataStruct {uint idx; ivec2 data;};
layout(location = 0) in InOutDataStruct inParam[];
layout (location=0) flat out InOutDataStruct outParam;

void main ()
{
    gl_Position = gl_in[0].gl_Position;
    outParam = inParam[0];
    EmitVertex();
    gl_Position = gl_in[1].gl_Position;
    outParam = inParam[1];
    EmitVertex();
    gl_Position = gl_in[2].gl_Position;
    outParam = inParam[2];
    EmitVertex();
}
#version 460

layout (triangles) in;
layout (triangle_strip, max_vertices=3) out;
in gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
} gl_in[3];
out gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
};



struct InOutDataStruct {uint idx; ivec3 data;};
layout(location = 0) in InOutDataStruct inParam[];
layout (location=0) flat out InOutDataStruct outParam;

void main ()
{
    gl_Position = gl_in[0].gl_Position;
    outParam = inParam[0];
    EmitVertex();
    gl_Position = gl_in[1].gl_Position;
    outParam = inParam[1];
    EmitVertex();
    gl_Position = gl_in[2].gl_Position;
    outParam = inParam[2];
    EmitVertex();
}
#version 460

layout (triangles) in;
layout (triangle_strip, max_vertices=3) out;
in gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
} gl_in[3];
out gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
};



struct InOutDataStruct {uint idx; ivec4 data;};
layout(location = 0) in InOutDataStruct inParam[];
layout (location=0) flat out InOutDataStruct outParam;

void main ()
{
    gl_Position = gl_in[0].gl_Position;
    outParam = inParam[0];
    EmitVertex();
    gl_Position = gl_in[1].gl_Position;
    outParam = inParam[1];
    EmitVertex();
    gl_Position = gl_in[2].gl_Position;
    outParam = inParam[2];
    EmitVertex();
}
#version 460

layout (triangles) in;
layout (triangle_strip, max_vertices=3) out;
in gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
} gl_in[3];
out gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
};



struct InOutDataStruct {uint idx; uint data;};
layout(location = 0) in InOutDataStruct inParam[];
layout (location=0) flat out InOutDataStruct outParam;

void main ()
{
    gl_Position = gl_in[0].gl_Position;
    outParam = inParam[0];
    EmitVertex();
    gl_Position = gl_in[1].gl_Position;
    outParam = inParam[1];
    EmitVertex();
    gl_Position = gl_in[2].gl_Position;
    outParam = inParam[2];
    EmitVertex();
}
#version 460

layout (triangles) in;
layout (triangle_strip, max_vertices=3) out;
in gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
} gl_in[3];
out gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
};



struct InOutDataStruct {uint idx; uvec2 data;};
layout(location = 0) in InOutDataStruct inParam[];
layout (location=0) flat out InOutDataStruct outParam;

void main ()
{
    gl_Position = gl_in[0].gl_Position;
    outParam = inParam[0];
    EmitVertex();
    gl_Position = gl_in[1].gl_Position;
    outParam = inParam[1];
    EmitVertex();
    gl_Position = gl_in[2].gl_Position;
    outParam = inParam[2];
    EmitVertex();
}
#version 460

layout (triangles) in;
layout (triangle_strip, max_vertices=3) out;
in gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
} gl_in[3];
out gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
};



struct InOutDataStruct {uint idx; uvec3 data;};
layout(location = 0) in InOutDataStruct inParam[];
layout (location=0) flat out InOutDataStruct outParam;

void main ()
{
    gl_Position = gl_in[0].gl_Position;
    outParam = inParam[0];
    EmitVertex();
    gl_Position = gl_in[1].gl_Position;
    outParam = inParam[1];
    EmitVertex();
    gl_Position = gl_in[2].gl_Position;
    outParam = inParam[2];
    EmitVertex();
}
#version 460

layout (triangles) in;
layout (triangle_strip, max_vertices=3) out;
in gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
} gl_in[3];
out gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
};



struct InOutDataStruct {uint idx; uvec4 data;};
layout(location = 0) in InOutDataStruct inParam[];
layout (location=0) flat out InOutDataStruct outParam;

void main ()
{
    gl_Position = gl_in[0].gl_Position;
    outParam = inParam[0];
    EmitVertex();
    gl_Position = gl_in[1].gl_Position;
    outParam = inParam[1];
    EmitVertex();
    gl_Position = gl_in[2].gl_Position;
    outParam = inParam[2];
    EmitVertex();
}
#version 460

layout (triangles) in;
layout (triangle_strip, max_vertices=3) out;
in gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
} gl_in[3];
out gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
};

struct DataStruct {float q;};

struct InOutDataStruct {uint idx; DataStruct data;};
layout(location = 0) in InOutDataStruct inParam[];
layout (location=0) flat out InOutDataStruct outParam;

void main ()
{
    gl_Position = gl_in[0].gl_Position;
    outParam = inParam[0];
    EmitVertex();
    gl_Position = gl_in[1].gl_Position;
    outParam = inParam[1];
    EmitVertex();
    gl_Position = gl_in[2].gl_Position;
    outParam = inParam[2];
    EmitVertex();
}
#version 460

layout (triangles) in;
layout (triangle_strip, max_vertices=3) out;
in gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
} gl_in[3];
out gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
};

struct DataStruct {vec2 q;};

struct InOutDataStruct {uint idx; DataStruct data;};
layout(location = 0) in InOutDataStruct inParam[];
layout (location=0) flat out InOutDataStruct outParam;

void main ()
{
    gl_Position = gl_in[0].gl_Position;
    outParam = inParam[0];
    EmitVertex();
    gl_Position = gl_in[1].gl_Position;
    outParam = inParam[1];
    EmitVertex();
    gl_Position = gl_in[2].gl_Position;
    outParam = inParam[2];
    EmitVertex();
}
#version 460

layout (triangles) in;
layout (triangle_strip, max_vertices=3) out;
in gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
} gl_in[3];
out gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
};

struct DataStruct {vec3 q;};

struct InOutDataStruct {uint idx; DataStruct data;};
layout(location = 0) in InOutDataStruct inParam[];
layout (location=0) flat out InOutDataStruct outParam;

void main ()
{
    gl_Position = gl_in[0].gl_Position;
    outParam = inParam[0];
    EmitVertex();
    gl_Position = gl_in[1].gl_Position;
    outParam = inParam[1];
    EmitVertex();
    gl_Position = gl_in[2].gl_Position;
    outParam = inParam[2];
    EmitVertex();
}
#version 460

layout (triangles) in;
layout (triangle_strip, max_vertices=3) out;
in gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
} gl_in[3];
out gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
};

struct DataStruct {vec4 q;};

struct InOutDataStruct {uint idx; DataStruct data;};
layout(location = 0) in InOutDataStruct inParam[];
layout (location=0) flat out InOutDataStruct outParam;

void main ()
{
    gl_Position = gl_in[0].gl_Position;
    outParam = inParam[0];
    EmitVertex();
    gl_Position = gl_in[1].gl_Position;
    outParam = inParam[1];
    EmitVertex();
    gl_Position = gl_in[2].gl_Position;
    outParam = inParam[2];
    EmitVertex();
}
#version 460

layout (triangles) in;
layout (triangle_strip, max_vertices=3) out;
in gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
} gl_in[3];
out gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
};

struct DataStruct {double q;};

struct InOutDataStruct {uint idx; DataStruct data;};
layout(location = 0) in InOutDataStruct inParam[];
layout (location=0) flat out InOutDataStruct outParam;

void main ()
{
    gl_Position = gl_in[0].gl_Position;
    outParam = inParam[0];
    EmitVertex();
    gl_Position = gl_in[1].gl_Position;
    outParam = inParam[1];
    EmitVertex();
    gl_Position = gl_in[2].gl_Position;
    outParam = inParam[2];
    EmitVertex();
}
#version 460

layout (triangles) in;
layout (triangle_strip, max_vertices=3) out;
in gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
} gl_in[3];
out gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
};

struct DataStruct {dvec2 q;};

struct InOutDataStruct {uint idx; DataStruct data;};
layout(location = 0) in InOutDataStruct inParam[];
layout (location=0) flat out InOutDataStruct outParam;

void main ()
{
    gl_Position = gl_in[0].gl_Position;
    outParam = inParam[0];
    EmitVertex();
    gl_Position = gl_in[1].gl_Position;
    outParam = inParam[1];
    EmitVertex();
    gl_Position = gl_in[2].gl_Position;
    outParam = inParam[2];
    EmitVertex();
}
#version 460

layout (triangles) in;
layout (triangle_strip, max_vertices=3) out;
in gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
} gl_in[3];
out gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
};

struct DataStruct {dvec3 q;};

struct InOutDataStruct {uint idx; DataStruct data;};
layout(location = 0) in InOutDataStruct inParam[];
layout (location=0) flat out InOutDataStruct outParam;

void main ()
{
    gl_Position = gl_in[0].gl_Position;
    outParam = inParam[0];
    EmitVertex();
    gl_Position = gl_in[1].gl_Position;
    outParam = inParam[1];
    EmitVertex();
    gl_Position = gl_in[2].gl_Position;
    outParam = inParam[2];
    EmitVertex();
}
#version 460

layout (triangles) in;
layout (triangle_strip, max_vertices=3) out;
in gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
} gl_in[3];
out gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
};

struct DataStruct {dvec4 q;};

struct InOutDataStruct {uint idx; DataStruct data;};
layout(location = 0) in InOutDataStruct inParam[];
layout (location=0) flat out InOutDataStruct outParam;

void main ()
{
    gl_Position = gl_in[0].gl_Position;
    outParam = inParam[0];
    EmitVertex();
    gl_Position = gl_in[1].gl_Position;
    outParam = inParam[1];
    EmitVertex();
    gl_Position = gl_in[2].gl_Position;
    outParam = inParam[2];
    EmitVertex();
}
#version 460

layout (triangles) in;
layout (triangle_strip, max_vertices=3) out;
in gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
} gl_in[3];
out gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
};

struct DataStruct {int q;};

struct InOutDataStruct {uint idx; DataStruct data;};
layout(location = 0) in InOutDataStruct inParam[];
layout (location=0) flat out InOutDataStruct outParam;

void main ()
{
    gl_Position = gl_in[0].gl_Position;
    outParam = inParam[0];
    EmitVertex();
    gl_Position = gl_in[1].gl_Position;
    outParam = inParam[1];
    EmitVertex();
    gl_Position = gl_in[2].gl_Position;
    outParam = inParam[2];
    EmitVertex();
}
#version 460

layout (triangles) in;
layout (triangle_strip, max_vertices=3) out;
in gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
} gl_in[3];
out gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
};

struct DataStruct {ivec2 q;};

struct InOutDataStruct {uint idx; DataStruct data;};
layout(location = 0) in InOutDataStruct inParam[];
layout (location=0) flat out InOutDataStruct outParam;

void main ()
{
    gl_Position = gl_in[0].gl_Position;
    outParam = inParam[0];
    EmitVertex();
    gl_Position = gl_in[1].gl_Position;
    outParam = inParam[1];
    EmitVertex();
    gl_Position = gl_in[2].gl_Position;
    outParam = inParam[2];
    EmitVertex();
}
#version 460

layout (triangles) in;
layout (triangle_strip, max_vertices=3) out;
in gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
} gl_in[3];
out gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
};

struct DataStruct {ivec3 q;};

struct InOutDataStruct {uint idx; DataStruct data;};
layout(location = 0) in InOutDataStruct inParam[];
layout (location=0) flat out InOutDataStruct outParam;

void main ()
{
    gl_Position = gl_in[0].gl_Position;
    outParam = inParam[0];
    EmitVertex();
    gl_Position = gl_in[1].gl_Position;
    outParam = inParam[1];
    EmitVertex();
    gl_Position = gl_in[2].gl_Position;
    outParam = inParam[2];
    EmitVertex();
}
#version 460

layout (triangles) in;
layout (triangle_strip, max_vertices=3) out;
in gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
} gl_in[3];
out gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
};

struct DataStruct {ivec4 q;};

struct InOutDataStruct {uint idx; DataStruct data;};
layout(location = 0) in InOutDataStruct inParam[];
layout (location=0) flat out InOutDataStruct outParam;

void main ()
{
    gl_Position = gl_in[0].gl_Position;
    outParam = inParam[0];
    EmitVertex();
    gl_Position = gl_in[1].gl_Position;
    outParam = inParam[1];
    EmitVertex();
    gl_Position = gl_in[2].gl_Position;
    outParam = inParam[2];
    EmitVertex();
}
#version 460

layout (triangles) in;
layout (triangle_strip, max_vertices=3) out;
in gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
} gl_in[3];
out gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
};

struct DataStruct {uint q;};

struct InOutDataStruct {uint idx; DataStruct data;};
layout(location = 0) in InOutDataStruct inParam[];
layout (location=0) flat out InOutDataStruct outParam;

void main ()
{
    gl_Position = gl_in[0].gl_Position;
    outParam = inParam[0];
    EmitVertex();
    gl_Position = gl_in[1].gl_Position;
    outParam = inParam[1];
    EmitVertex();
    gl_Position = gl_in[2].gl_Position;
    outParam = inParam[2];
    EmitVertex();
}
#version 460

layout (triangles) in;
layout (triangle_strip, max_vertices=3) out;
in gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
} gl_in[3];
out gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
};

struct DataStruct {uvec2 q;};

struct InOutDataStruct {uint idx; DataStruct data;};
layout(location = 0) in InOutDataStruct inParam[];
layout (location=0) flat out InOutDataStruct outParam;

void main ()
{
    gl_Position = gl_in[0].gl_Position;
    outParam = inParam[0];
    EmitVertex();
    gl_Position = gl_in[1].gl_Position;
    outParam = inParam[1];
    EmitVertex();
    gl_Position = gl_in[2].gl_Position;
    outParam = inParam[2];
    EmitVertex();
}
#version 460

layout (triangles) in;
layout (triangle_strip, max_vertices=3) out;
in gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
} gl_in[3];
out gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
};

struct DataStruct {uvec3 q;};

struct InOutDataStruct {uint idx; DataStruct data;};
layout(location = 0) in InOutDataStruct inParam[];
layout (location=0) flat out InOutDataStruct outParam;

void main ()
{
    gl_Position = gl_in[0].gl_Position;
    outParam = inParam[0];
    EmitVertex();
    gl_Position = gl_in[1].gl_Position;
    outParam = inParam[1];
    EmitVertex();
    gl_Position = gl_in[2].gl_Position;
    outParam = inParam[2];
    EmitVertex();
}
#version 460

layout (triangles) in;
layout (triangle_strip, max_vertices=3) out;
in gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
} gl_in[3];
out gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
};

struct DataStruct {uvec4 q;};

struct InOutDataStruct {uint idx; DataStruct data;};
layout(location = 0) in InOutDataStruct inParam[];
layout (location=0) flat out InOutDataStruct outParam;

void main ()
{
    gl_Position = gl_in[0].gl_Position;
    outParam = inParam[0];
    EmitVertex();
    gl_Position = gl_in[1].gl_Position;
    outParam = inParam[1];
    EmitVertex();
    gl_Position = gl_in[2].gl_Position;
    outParam = inParam[2];
    EmitVertex();
}
#version 460

layout (triangles) in;
layout (triangle_strip, max_vertices=3) out;
in gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
} gl_in[3];
out gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
};



struct InOutDataStruct {uint idx; float data[2];};
layout(location = 0) in InOutDataStruct inParam[];
layout (location=0) flat out InOutDataStruct outParam;

void main ()
{
    gl_Position = gl_in[0].gl_Position;
    outParam = inParam[0];
    EmitVertex();
    gl_Position = gl_in[1].gl_Position;
    outParam = inParam[1];
    EmitVertex();
    gl_Position = gl_in[2].gl_Position;
    outParam = inParam[2];
    EmitVertex();
}
#version 460

layout (triangles) in;
layout (triangle_strip, max_vertices=3) out;
in gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
} gl_in[3];
out gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
};



struct InOutDataStruct {uint idx; vec2 data[2];};
layout(location = 0) in InOutDataStruct inParam[];
layout (location=0) flat out InOutDataStruct outParam;

void main ()
{
    gl_Position = gl_in[0].gl_Position;
    outParam = inParam[0];
    EmitVertex();
    gl_Position = gl_in[1].gl_Position;
    outParam = inParam[1];
    EmitVertex();
    gl_Position = gl_in[2].gl_Position;
    outParam = inParam[2];
    EmitVertex();
}
#version 460

layout (triangles) in;
layout (triangle_strip, max_vertices=3) out;
in gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
} gl_in[3];
out gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
};



struct InOutDataStruct {uint idx; vec3 data[2];};
layout(location = 0) in InOutDataStruct inParam[];
layout (location=0) flat out InOutDataStruct outParam;

void main ()
{
    gl_Position = gl_in[0].gl_Position;
    outParam = inParam[0];
    EmitVertex();
    gl_Position = gl_in[1].gl_Position;
    outParam = inParam[1];
    EmitVertex();
    gl_Position = gl_in[2].gl_Position;
    outParam = inParam[2];
    EmitVertex();
}
#version 460

layout (triangles) in;
layout (triangle_strip, max_vertices=3) out;
in gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
} gl_in[3];
out gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
};



struct InOutDataStruct {uint idx; vec4 data[2];};
layout(location = 0) in InOutDataStruct inParam[];
layout (location=0) flat out InOutDataStruct outParam;

void main ()
{
    gl_Position = gl_in[0].gl_Position;
    outParam = inParam[0];
    EmitVertex();
    gl_Position = gl_in[1].gl_Position;
    outParam = inParam[1];
    EmitVertex();
    gl_Position = gl_in[2].gl_Position;
    outParam = inParam[2];
    EmitVertex();
}
#version 460

layout (triangles) in;
layout (triangle_strip, max_vertices=3) out;
in gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
} gl_in[3];
out gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
};



struct InOutDataStruct {uint idx; double data[2];};
layout(location = 0) in InOutDataStruct inParam[];
layout (location=0) flat out InOutDataStruct outParam;

void main ()
{
    gl_Position = gl_in[0].gl_Position;
    outParam = inParam[0];
    EmitVertex();
    gl_Position = gl_in[1].gl_Position;
    outParam = inParam[1];
    EmitVertex();
    gl_Position = gl_in[2].gl_Position;
    outParam = inParam[2];
    EmitVertex();
}
#version 460

layout (triangles) in;
layout (triangle_strip, max_vertices=3) out;
in gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
} gl_in[3];
out gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
};



struct InOutDataStruct {uint idx; dvec2 data[2];};
layout(location = 0) in InOutDataStruct inParam[];
layout (location=0) flat out InOutDataStruct outParam;

void main ()
{
    gl_Position = gl_in[0].gl_Position;
    outParam = inParam[0];
    EmitVertex();
    gl_Position = gl_in[1].gl_Position;
    outParam = inParam[1];
    EmitVertex();
    gl_Position = gl_in[2].gl_Position;
    outParam = inParam[2];
    EmitVertex();
}
#version 460

layout (triangles) in;
layout (triangle_strip, max_vertices=3) out;
in gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
} gl_in[3];
out gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
};



struct InOutDataStruct {uint idx; dvec3 data[2];};
layout(location = 0) in InOutDataStruct inParam[];
layout (location=0) flat out InOutDataStruct outParam;

void main ()
{
    gl_Position = gl_in[0].gl_Position;
    outParam = inParam[0];
    EmitVertex();
    gl_Position = gl_in[1].gl_Position;
    outParam = inParam[1];
    EmitVertex();
    gl_Position = gl_in[2].gl_Position;
    outParam = inParam[2];
    EmitVertex();
}
#version 460

layout (triangles) in;
layout (triangle_strip, max_vertices=3) out;
in gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
} gl_in[3];
out gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
};



struct InOutDataStruct {uint idx; dvec4 data[2];};
layout(location = 0) in InOutDataStruct inParam[];
layout (location=0) flat out InOutDataStruct outParam;

void main ()
{
    gl_Position = gl_in[0].gl_Position;
    outParam = inParam[0];
    EmitVertex();
    gl_Position = gl_in[1].gl_Position;
    outParam = inParam[1];
    EmitVertex();
    gl_Position = gl_in[2].gl_Position;
    outParam = inParam[2];
    EmitVertex();
}
#version 460

layout (triangles) in;
layout (triangle_strip, max_vertices=3) out;
in gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
} gl_in[3];
out gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
};



struct InOutDataStruct {uint idx; int data[2];};
layout(location = 0) in InOutDataStruct inParam[];
layout (location=0) flat out InOutDataStruct outParam;

void main ()
{
    gl_Position = gl_in[0].gl_Position;
    outParam = inParam[0];
    EmitVertex();
    gl_Position = gl_in[1].gl_Position;
    outParam = inParam[1];
    EmitVertex();
    gl_Position = gl_in[2].gl_Position;
    outParam = inParam[2];
    EmitVertex();
}
#version 460

layout (triangles) in;
layout (triangle_strip, max_vertices=3) out;
in gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
} gl_in[3];
out gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
};



struct InOutDataStruct {uint idx; ivec2 data[2];};
layout(location = 0) in InOutDataStruct inParam[];
layout (location=0) flat out InOutDataStruct outParam;

void main ()
{
    gl_Position = gl_in[0].gl_Position;
    outParam = inParam[0];
    EmitVertex();
    gl_Position = gl_in[1].gl_Position;
    outParam = inParam[1];
    EmitVertex();
    gl_Position = gl_in[2].gl_Position;
    outParam = inParam[2];
    EmitVertex();
}
#version 460

layout (triangles) in;
layout (triangle_strip, max_vertices=3) out;
in gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
} gl_in[3];
out gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
};



struct InOutDataStruct {uint idx; ivec3 data[2];};
layout(location = 0) in InOutDataStruct inParam[];
layout (location=0) flat out InOutDataStruct outParam;

void main ()
{
    gl_Position = gl_in[0].gl_Position;
    outParam = inParam[0];
    EmitVertex();
    gl_Position = gl_in[1].gl_Position;
    outParam = inParam[1];
    EmitVertex();
    gl_Position = gl_in[2].gl_Position;
    outParam = inParam[2];
    EmitVertex();
}
#version 460

layout (triangles) in;
layout (triangle_strip, max_vertices=3) out;
in gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
} gl_in[3];
out gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
};



struct InOutDataStruct {uint idx; ivec4 data[2];};
layout(location = 0) in InOutDataStruct inParam[];
layout (location=0) flat out InOutDataStruct outParam;

void main ()
{
    gl_Position = gl_in[0].gl_Position;
    outParam = inParam[0];
    EmitVertex();
    gl_Position = gl_in[1].gl_Position;
    outParam = inParam[1];
    EmitVertex();
    gl_Position = gl_in[2].gl_Position;
    outParam = inParam[2];
    EmitVertex();
}
#version 460

layout (triangles) in;
layout (triangle_strip, max_vertices=3) out;
in gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
} gl_in[3];
out gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
};



struct InOutDataStruct {uint idx; uint data[2];};
layout(location = 0) in InOutDataStruct inParam[];
layout (location=0) flat out InOutDataStruct outParam;

void main ()
{
    gl_Position = gl_in[0].gl_Position;
    outParam = inParam[0];
    EmitVertex();
    gl_Position = gl_in[1].gl_Position;
    outParam = inParam[1];
    EmitVertex();
    gl_Position = gl_in[2].gl_Position;
    outParam = inParam[2];
    EmitVertex();
}
#version 460

layout (triangles) in;
layout (triangle_strip, max_vertices=3) out;
in gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
} gl_in[3];
out gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
};



struct InOutDataStruct {uint idx; uvec2 data[2];};
layout(location = 0) in InOutDataStruct inParam[];
layout (location=0) flat out InOutDataStruct outParam;

void main ()
{
    gl_Position = gl_in[0].gl_Position;
    outParam = inParam[0];
    EmitVertex();
    gl_Position = gl_in[1].gl_Position;
    outParam = inParam[1];
    EmitVertex();
    gl_Position = gl_in[2].gl_Position;
    outParam = inParam[2];
    EmitVertex();
}
#version 460

layout (triangles) in;
layout (triangle_strip, max_vertices=3) out;
in gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
} gl_in[3];
out gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
};



struct InOutDataStruct {uint idx; uvec3 data[2];};
layout(location = 0) in InOutDataStruct inParam[];
layout (location=0) flat out InOutDataStruct outParam;

void main ()
{
    gl_Position = gl_in[0].gl_Position;
    outParam = inParam[0];
    EmitVertex();
    gl_Position = gl_in[1].gl_Position;
    outParam = inParam[1];
    EmitVertex();
    gl_Position = gl_in[2].gl_Position;
    outParam = inParam[2];
    EmitVertex();
}
#version 460

layout (triangles) in;
layout (triangle_strip, max_vertices=3) out;
in gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
} gl_in[3];
out gl_PerVertex
{
    vec4 gl_Position;
    float gl_PointSize;
};



struct InOutDataStruct {uint idx; uvec4 data[2];};
layout(location = 0) in InOutDataStruct inParam[];
layout (location=0) flat out InOutDataStruct outParam;

void main ()
{
    gl_Position = gl_in[0].gl_Position;
    outParam = inParam[0];
    EmitVertex();
    gl_Position = gl_in[1].gl_Position;
    outParam = inParam[1];
    EmitVertex();
    gl_Position = gl_in[2].gl_Position;
    outParam = inParam[2];
    EmitVertex();
}
