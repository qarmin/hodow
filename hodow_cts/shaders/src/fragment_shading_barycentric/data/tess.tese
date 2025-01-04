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

${dataStruct}

layout (location=0) in ${typePrefix} inData[]${typeSuffix};
struct OutDataStruct {uint idx; ${typePrefix} data${typeSuffix};};
layout (location=0) flat out OutDataStruct outParam;

void main (void)
{
    gl_Position = (gl_TessCoord.x * gl_in[0].gl_Position) +
                  (gl_TessCoord.y * gl_in[1].gl_Position) +
                  (gl_TessCoord.z * gl_in[2].gl_Position);
    if (gl_TessCoord.xyz == vec3(0.0,1.0,0.0)) {outParam.idx = ${i2}; outParam.data = ${teseData2}; }
    else if (gl_TessCoord.xyz == vec3(1.0,0.0,0.0)) {outParam.idx = ${i0}; outParam.data = ${teseData0}; }
    else if (gl_TessCoord.xyz == vec3(0.0,0.0,1.0)) {outParam.idx = ${i1}; outParam.data = ${teseData1}; }
}
