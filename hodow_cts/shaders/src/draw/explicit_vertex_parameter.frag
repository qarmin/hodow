#version 450
#extension GL_AMD_shader_explicit_vertex_parameter : require

layout(location = 0) __explicitInterpAMD in float in_data_explicit;
layout(location = 1) ${auxqualifier} ${qualifier}        in float in_data_${qualifier};
layout(location = 0) out vec4 out_color;
layout (binding = 0, std140) writeonly buffer Output {
    vec4 values [${numValues}];
} sb_out;

void main()
{
    uint index = (uint(gl_FragCoord.y) * 16 * ${samples}) + uint(gl_FragCoord.x) * ${samples} + gl_SampleID;
    // Barycentric coodinates (I, J, K)
    vec3 bary_coord = vec3(${barycoord}.x, ${barycoord}.y, 1.0f - ${barycoord}.x - ${barycoord}.y);

    // Vertex 0 -> (I = 0, J = 0, K = 1)
    float data0 = interpolateAtVertexAMD(in_data_explicit, 0);
    // Vertex 1 -> (I = 1, J = 0, K = 0)
    float data1 = interpolateAtVertexAMD(in_data_explicit, 1);
    // Vertex 1 -> (I = 0, J = 1, K = 0)
    float data2 = interpolateAtVertexAMD(in_data_explicit, 2);
    // Match data component with barycentric coordinate
    vec3  data  = vec3(data1, data2, data0);

    float res      = (bary_coord.x * data.x) + (bary_coord.y * data.y) + (bary_coord.z * data.z);
    float expected = in_data_${qualifier};

    sb_out.values[ index ] = vec4(expected, res, 0u, 0u);

    const float threshold = 0.0005f;
    if (abs(res - expected) < threshold)
        out_color = vec4(0.0f, 1.0f, 0.0f, 1.0f);
    else
        out_color = vec4(1.0f, 0.0f, 0.0f, 1.0f);
}
