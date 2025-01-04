#version 450
#extension GL_AMD_shader_explicit_vertex_parameter : require

layout(location = 0) in vec4 in_position;
layout(location = 1) in float in_data;
layout(location = 0) __explicitInterpAMD out float out_data_explicit;
layout(location = 1)  smooth        out float out_data_smooth;

out gl_PerVertex {
    vec4  gl_Position;
    float gl_PointSize;
};

void main() {
    gl_PointSize              = 1.0;
    gl_Position               = in_position;
    out_data_explicit         = in_data;
    out_data_smooth     = in_data;
}
#version 450
#extension GL_AMD_shader_explicit_vertex_parameter : require

layout(location = 0) __explicitInterpAMD in float in_data_explicit;
layout(location = 1)  smooth        in float in_data_smooth;
layout(location = 0) out vec4 out_color;
layout (binding = 0, std140) writeonly buffer Output {
    vec4 values [256];
} sb_out;

void main()
{
    uint index = (uint(gl_FragCoord.y) * 16 * 1) + uint(gl_FragCoord.x) * 1 + gl_SampleID;
    // Barycentric coodinates (I, J, K)
    vec3 bary_coord = vec3(gl_BaryCoordSmoothAMD.x, gl_BaryCoordSmoothAMD.y, 1.0f - gl_BaryCoordSmoothAMD.x - gl_BaryCoordSmoothAMD.y);

    // Vertex 0 -> (I = 0, J = 0, K = 1)
    float data0 = interpolateAtVertexAMD(in_data_explicit, 0);
    // Vertex 1 -> (I = 1, J = 0, K = 0)
    float data1 = interpolateAtVertexAMD(in_data_explicit, 1);
    // Vertex 1 -> (I = 0, J = 1, K = 0)
    float data2 = interpolateAtVertexAMD(in_data_explicit, 2);
    // Match data component with barycentric coordinate
    vec3  data  = vec3(data1, data2, data0);

    float res      = (bary_coord.x * data.x) + (bary_coord.y * data.y) + (bary_coord.z * data.z);
    float expected = in_data_smooth;

    sb_out.values[ index ] = vec4(expected, res, 0u, 0u);

    const float threshold = 0.0005f;
    if (abs(res - expected) < threshold)
        out_color = vec4(0.0f, 1.0f, 0.0f, 1.0f);
    else
        out_color = vec4(1.0f, 0.0f, 0.0f, 1.0f);
}
#version 450
#extension GL_AMD_shader_explicit_vertex_parameter : require

layout(location = 0) in vec4 in_position;
layout(location = 1) in float in_data;
layout(location = 0) __explicitInterpAMD out float out_data_explicit;
layout(location = 1)  noperspective        out float out_data_noperspective;

out gl_PerVertex {
    vec4  gl_Position;
    float gl_PointSize;
};

void main() {
    gl_PointSize              = 1.0;
    gl_Position               = in_position;
    out_data_explicit         = in_data;
    out_data_noperspective     = in_data;
}
#version 450
#extension GL_AMD_shader_explicit_vertex_parameter : require

layout(location = 0) __explicitInterpAMD in float in_data_explicit;
layout(location = 1)  noperspective        in float in_data_noperspective;
layout(location = 0) out vec4 out_color;
layout (binding = 0, std140) writeonly buffer Output {
    vec4 values [256];
} sb_out;

void main()
{
    uint index = (uint(gl_FragCoord.y) * 16 * 1) + uint(gl_FragCoord.x) * 1 + gl_SampleID;
    // Barycentric coodinates (I, J, K)
    vec3 bary_coord = vec3(gl_BaryCoordNoPerspAMD.x, gl_BaryCoordNoPerspAMD.y, 1.0f - gl_BaryCoordNoPerspAMD.x - gl_BaryCoordNoPerspAMD.y);

    // Vertex 0 -> (I = 0, J = 0, K = 1)
    float data0 = interpolateAtVertexAMD(in_data_explicit, 0);
    // Vertex 1 -> (I = 1, J = 0, K = 0)
    float data1 = interpolateAtVertexAMD(in_data_explicit, 1);
    // Vertex 1 -> (I = 0, J = 1, K = 0)
    float data2 = interpolateAtVertexAMD(in_data_explicit, 2);
    // Match data component with barycentric coordinate
    vec3  data  = vec3(data1, data2, data0);

    float res      = (bary_coord.x * data.x) + (bary_coord.y * data.y) + (bary_coord.z * data.z);
    float expected = in_data_noperspective;

    sb_out.values[ index ] = vec4(expected, res, 0u, 0u);

    const float threshold = 0.0005f;
    if (abs(res - expected) < threshold)
        out_color = vec4(0.0f, 1.0f, 0.0f, 1.0f);
    else
        out_color = vec4(1.0f, 0.0f, 0.0f, 1.0f);
}
#version 450
#extension GL_AMD_shader_explicit_vertex_parameter : require

layout(location = 0) __explicitInterpAMD in float in_data_explicit;
layout(location = 1)  smooth        in float in_data_smooth;
layout(location = 0) out vec4 out_color;
layout (binding = 0, std140) writeonly buffer Output {
    vec4 values [1024];
} sb_out;

void main()
{
    uint index = (uint(gl_FragCoord.y) * 16 * 2) + uint(gl_FragCoord.x) * 2 + gl_SampleID;
    // Barycentric coodinates (I, J, K)
    vec3 bary_coord = vec3(gl_BaryCoordSmoothAMD.x, gl_BaryCoordSmoothAMD.y, 1.0f - gl_BaryCoordSmoothAMD.x - gl_BaryCoordSmoothAMD.y);

    // Vertex 0 -> (I = 0, J = 0, K = 1)
    float data0 = interpolateAtVertexAMD(in_data_explicit, 0);
    // Vertex 1 -> (I = 1, J = 0, K = 0)
    float data1 = interpolateAtVertexAMD(in_data_explicit, 1);
    // Vertex 1 -> (I = 0, J = 1, K = 0)
    float data2 = interpolateAtVertexAMD(in_data_explicit, 2);
    // Match data component with barycentric coordinate
    vec3  data  = vec3(data1, data2, data0);

    float res      = (bary_coord.x * data.x) + (bary_coord.y * data.y) + (bary_coord.z * data.z);
    float expected = in_data_smooth;

    sb_out.values[ index ] = vec4(expected, res, 0u, 0u);

    const float threshold = 0.0005f;
    if (abs(res - expected) < threshold)
        out_color = vec4(0.0f, 1.0f, 0.0f, 1.0f);
    else
        out_color = vec4(1.0f, 0.0f, 0.0f, 1.0f);
}
#version 450
#extension GL_AMD_shader_explicit_vertex_parameter : require

layout(location = 0) in vec4 in_position;
layout(location = 1) in float in_data;
layout(location = 0) __explicitInterpAMD out float out_data_explicit;
layout(location = 1) sample smooth        out float out_data_smooth;

out gl_PerVertex {
    vec4  gl_Position;
    float gl_PointSize;
};

void main() {
    gl_PointSize              = 1.0;
    gl_Position               = in_position;
    out_data_explicit         = in_data;
    out_data_smooth     = in_data;
}
#version 450
#extension GL_AMD_shader_explicit_vertex_parameter : require

layout(location = 0) __explicitInterpAMD in float in_data_explicit;
layout(location = 1) sample smooth        in float in_data_smooth;
layout(location = 0) out vec4 out_color;
layout (binding = 0, std140) writeonly buffer Output {
    vec4 values [1024];
} sb_out;

void main()
{
    uint index = (uint(gl_FragCoord.y) * 16 * 2) + uint(gl_FragCoord.x) * 2 + gl_SampleID;
    // Barycentric coodinates (I, J, K)
    vec3 bary_coord = vec3(gl_BaryCoordSmoothSampleAMD.x, gl_BaryCoordSmoothSampleAMD.y, 1.0f - gl_BaryCoordSmoothSampleAMD.x - gl_BaryCoordSmoothSampleAMD.y);

    // Vertex 0 -> (I = 0, J = 0, K = 1)
    float data0 = interpolateAtVertexAMD(in_data_explicit, 0);
    // Vertex 1 -> (I = 1, J = 0, K = 0)
    float data1 = interpolateAtVertexAMD(in_data_explicit, 1);
    // Vertex 1 -> (I = 0, J = 1, K = 0)
    float data2 = interpolateAtVertexAMD(in_data_explicit, 2);
    // Match data component with barycentric coordinate
    vec3  data  = vec3(data1, data2, data0);

    float res      = (bary_coord.x * data.x) + (bary_coord.y * data.y) + (bary_coord.z * data.z);
    float expected = in_data_smooth;

    sb_out.values[ index ] = vec4(expected, res, 0u, 0u);

    const float threshold = 0.0005f;
    if (abs(res - expected) < threshold)
        out_color = vec4(0.0f, 1.0f, 0.0f, 1.0f);
    else
        out_color = vec4(1.0f, 0.0f, 0.0f, 1.0f);
}
#version 450
#extension GL_AMD_shader_explicit_vertex_parameter : require

layout(location = 0) in vec4 in_position;
layout(location = 1) in float in_data;
layout(location = 0) __explicitInterpAMD out float out_data_explicit;
layout(location = 1) centroid smooth        out float out_data_smooth;

out gl_PerVertex {
    vec4  gl_Position;
    float gl_PointSize;
};

void main() {
    gl_PointSize              = 1.0;
    gl_Position               = in_position;
    out_data_explicit         = in_data;
    out_data_smooth     = in_data;
}
#version 450
#extension GL_AMD_shader_explicit_vertex_parameter : require

layout(location = 0) __explicitInterpAMD in float in_data_explicit;
layout(location = 1) centroid smooth        in float in_data_smooth;
layout(location = 0) out vec4 out_color;
layout (binding = 0, std140) writeonly buffer Output {
    vec4 values [1024];
} sb_out;

void main()
{
    uint index = (uint(gl_FragCoord.y) * 16 * 2) + uint(gl_FragCoord.x) * 2 + gl_SampleID;
    // Barycentric coodinates (I, J, K)
    vec3 bary_coord = vec3(gl_BaryCoordSmoothCentroidAMD.x, gl_BaryCoordSmoothCentroidAMD.y, 1.0f - gl_BaryCoordSmoothCentroidAMD.x - gl_BaryCoordSmoothCentroidAMD.y);

    // Vertex 0 -> (I = 0, J = 0, K = 1)
    float data0 = interpolateAtVertexAMD(in_data_explicit, 0);
    // Vertex 1 -> (I = 1, J = 0, K = 0)
    float data1 = interpolateAtVertexAMD(in_data_explicit, 1);
    // Vertex 1 -> (I = 0, J = 1, K = 0)
    float data2 = interpolateAtVertexAMD(in_data_explicit, 2);
    // Match data component with barycentric coordinate
    vec3  data  = vec3(data1, data2, data0);

    float res      = (bary_coord.x * data.x) + (bary_coord.y * data.y) + (bary_coord.z * data.z);
    float expected = in_data_smooth;

    sb_out.values[ index ] = vec4(expected, res, 0u, 0u);

    const float threshold = 0.0005f;
    if (abs(res - expected) < threshold)
        out_color = vec4(0.0f, 1.0f, 0.0f, 1.0f);
    else
        out_color = vec4(1.0f, 0.0f, 0.0f, 1.0f);
}
#version 450
#extension GL_AMD_shader_explicit_vertex_parameter : require

layout(location = 0) __explicitInterpAMD in float in_data_explicit;
layout(location = 1)  noperspective        in float in_data_noperspective;
layout(location = 0) out vec4 out_color;
layout (binding = 0, std140) writeonly buffer Output {
    vec4 values [1024];
} sb_out;

void main()
{
    uint index = (uint(gl_FragCoord.y) * 16 * 2) + uint(gl_FragCoord.x) * 2 + gl_SampleID;
    // Barycentric coodinates (I, J, K)
    vec3 bary_coord = vec3(gl_BaryCoordNoPerspAMD.x, gl_BaryCoordNoPerspAMD.y, 1.0f - gl_BaryCoordNoPerspAMD.x - gl_BaryCoordNoPerspAMD.y);

    // Vertex 0 -> (I = 0, J = 0, K = 1)
    float data0 = interpolateAtVertexAMD(in_data_explicit, 0);
    // Vertex 1 -> (I = 1, J = 0, K = 0)
    float data1 = interpolateAtVertexAMD(in_data_explicit, 1);
    // Vertex 1 -> (I = 0, J = 1, K = 0)
    float data2 = interpolateAtVertexAMD(in_data_explicit, 2);
    // Match data component with barycentric coordinate
    vec3  data  = vec3(data1, data2, data0);

    float res      = (bary_coord.x * data.x) + (bary_coord.y * data.y) + (bary_coord.z * data.z);
    float expected = in_data_noperspective;

    sb_out.values[ index ] = vec4(expected, res, 0u, 0u);

    const float threshold = 0.0005f;
    if (abs(res - expected) < threshold)
        out_color = vec4(0.0f, 1.0f, 0.0f, 1.0f);
    else
        out_color = vec4(1.0f, 0.0f, 0.0f, 1.0f);
}
#version 450
#extension GL_AMD_shader_explicit_vertex_parameter : require

layout(location = 0) in vec4 in_position;
layout(location = 1) in float in_data;
layout(location = 0) __explicitInterpAMD out float out_data_explicit;
layout(location = 1) sample noperspective        out float out_data_noperspective;

out gl_PerVertex {
    vec4  gl_Position;
    float gl_PointSize;
};

void main() {
    gl_PointSize              = 1.0;
    gl_Position               = in_position;
    out_data_explicit         = in_data;
    out_data_noperspective     = in_data;
}
#version 450
#extension GL_AMD_shader_explicit_vertex_parameter : require

layout(location = 0) __explicitInterpAMD in float in_data_explicit;
layout(location = 1) sample noperspective        in float in_data_noperspective;
layout(location = 0) out vec4 out_color;
layout (binding = 0, std140) writeonly buffer Output {
    vec4 values [1024];
} sb_out;

void main()
{
    uint index = (uint(gl_FragCoord.y) * 16 * 2) + uint(gl_FragCoord.x) * 2 + gl_SampleID;
    // Barycentric coodinates (I, J, K)
    vec3 bary_coord = vec3(gl_BaryCoordNoPerspSampleAMD.x, gl_BaryCoordNoPerspSampleAMD.y, 1.0f - gl_BaryCoordNoPerspSampleAMD.x - gl_BaryCoordNoPerspSampleAMD.y);

    // Vertex 0 -> (I = 0, J = 0, K = 1)
    float data0 = interpolateAtVertexAMD(in_data_explicit, 0);
    // Vertex 1 -> (I = 1, J = 0, K = 0)
    float data1 = interpolateAtVertexAMD(in_data_explicit, 1);
    // Vertex 1 -> (I = 0, J = 1, K = 0)
    float data2 = interpolateAtVertexAMD(in_data_explicit, 2);
    // Match data component with barycentric coordinate
    vec3  data  = vec3(data1, data2, data0);

    float res      = (bary_coord.x * data.x) + (bary_coord.y * data.y) + (bary_coord.z * data.z);
    float expected = in_data_noperspective;

    sb_out.values[ index ] = vec4(expected, res, 0u, 0u);

    const float threshold = 0.0005f;
    if (abs(res - expected) < threshold)
        out_color = vec4(0.0f, 1.0f, 0.0f, 1.0f);
    else
        out_color = vec4(1.0f, 0.0f, 0.0f, 1.0f);
}
#version 450
#extension GL_AMD_shader_explicit_vertex_parameter : require

layout(location = 0) in vec4 in_position;
layout(location = 1) in float in_data;
layout(location = 0) __explicitInterpAMD out float out_data_explicit;
layout(location = 1) centroid noperspective        out float out_data_noperspective;

out gl_PerVertex {
    vec4  gl_Position;
    float gl_PointSize;
};

void main() {
    gl_PointSize              = 1.0;
    gl_Position               = in_position;
    out_data_explicit         = in_data;
    out_data_noperspective     = in_data;
}
#version 450
#extension GL_AMD_shader_explicit_vertex_parameter : require

layout(location = 0) __explicitInterpAMD in float in_data_explicit;
layout(location = 1) centroid noperspective        in float in_data_noperspective;
layout(location = 0) out vec4 out_color;
layout (binding = 0, std140) writeonly buffer Output {
    vec4 values [1024];
} sb_out;

void main()
{
    uint index = (uint(gl_FragCoord.y) * 16 * 2) + uint(gl_FragCoord.x) * 2 + gl_SampleID;
    // Barycentric coodinates (I, J, K)
    vec3 bary_coord = vec3(gl_BaryCoordNoPerspCentroidAMD.x, gl_BaryCoordNoPerspCentroidAMD.y, 1.0f - gl_BaryCoordNoPerspCentroidAMD.x - gl_BaryCoordNoPerspCentroidAMD.y);

    // Vertex 0 -> (I = 0, J = 0, K = 1)
    float data0 = interpolateAtVertexAMD(in_data_explicit, 0);
    // Vertex 1 -> (I = 1, J = 0, K = 0)
    float data1 = interpolateAtVertexAMD(in_data_explicit, 1);
    // Vertex 1 -> (I = 0, J = 1, K = 0)
    float data2 = interpolateAtVertexAMD(in_data_explicit, 2);
    // Match data component with barycentric coordinate
    vec3  data  = vec3(data1, data2, data0);

    float res      = (bary_coord.x * data.x) + (bary_coord.y * data.y) + (bary_coord.z * data.z);
    float expected = in_data_noperspective;

    sb_out.values[ index ] = vec4(expected, res, 0u, 0u);

    const float threshold = 0.0005f;
    if (abs(res - expected) < threshold)
        out_color = vec4(0.0f, 1.0f, 0.0f, 1.0f);
    else
        out_color = vec4(1.0f, 0.0f, 0.0f, 1.0f);
}
#version 450
#extension GL_AMD_shader_explicit_vertex_parameter : require

layout(location = 0) __explicitInterpAMD in float in_data_explicit;
layout(location = 1)  smooth        in float in_data_smooth;
layout(location = 0) out vec4 out_color;
layout (binding = 0, std140) writeonly buffer Output {
    vec4 values [4096];
} sb_out;

void main()
{
    uint index = (uint(gl_FragCoord.y) * 16 * 4) + uint(gl_FragCoord.x) * 4 + gl_SampleID;
    // Barycentric coodinates (I, J, K)
    vec3 bary_coord = vec3(gl_BaryCoordSmoothAMD.x, gl_BaryCoordSmoothAMD.y, 1.0f - gl_BaryCoordSmoothAMD.x - gl_BaryCoordSmoothAMD.y);

    // Vertex 0 -> (I = 0, J = 0, K = 1)
    float data0 = interpolateAtVertexAMD(in_data_explicit, 0);
    // Vertex 1 -> (I = 1, J = 0, K = 0)
    float data1 = interpolateAtVertexAMD(in_data_explicit, 1);
    // Vertex 1 -> (I = 0, J = 1, K = 0)
    float data2 = interpolateAtVertexAMD(in_data_explicit, 2);
    // Match data component with barycentric coordinate
    vec3  data  = vec3(data1, data2, data0);

    float res      = (bary_coord.x * data.x) + (bary_coord.y * data.y) + (bary_coord.z * data.z);
    float expected = in_data_smooth;

    sb_out.values[ index ] = vec4(expected, res, 0u, 0u);

    const float threshold = 0.0005f;
    if (abs(res - expected) < threshold)
        out_color = vec4(0.0f, 1.0f, 0.0f, 1.0f);
    else
        out_color = vec4(1.0f, 0.0f, 0.0f, 1.0f);
}
#version 450
#extension GL_AMD_shader_explicit_vertex_parameter : require

layout(location = 0) __explicitInterpAMD in float in_data_explicit;
layout(location = 1) sample smooth        in float in_data_smooth;
layout(location = 0) out vec4 out_color;
layout (binding = 0, std140) writeonly buffer Output {
    vec4 values [4096];
} sb_out;

void main()
{
    uint index = (uint(gl_FragCoord.y) * 16 * 4) + uint(gl_FragCoord.x) * 4 + gl_SampleID;
    // Barycentric coodinates (I, J, K)
    vec3 bary_coord = vec3(gl_BaryCoordSmoothSampleAMD.x, gl_BaryCoordSmoothSampleAMD.y, 1.0f - gl_BaryCoordSmoothSampleAMD.x - gl_BaryCoordSmoothSampleAMD.y);

    // Vertex 0 -> (I = 0, J = 0, K = 1)
    float data0 = interpolateAtVertexAMD(in_data_explicit, 0);
    // Vertex 1 -> (I = 1, J = 0, K = 0)
    float data1 = interpolateAtVertexAMD(in_data_explicit, 1);
    // Vertex 1 -> (I = 0, J = 1, K = 0)
    float data2 = interpolateAtVertexAMD(in_data_explicit, 2);
    // Match data component with barycentric coordinate
    vec3  data  = vec3(data1, data2, data0);

    float res      = (bary_coord.x * data.x) + (bary_coord.y * data.y) + (bary_coord.z * data.z);
    float expected = in_data_smooth;

    sb_out.values[ index ] = vec4(expected, res, 0u, 0u);

    const float threshold = 0.0005f;
    if (abs(res - expected) < threshold)
        out_color = vec4(0.0f, 1.0f, 0.0f, 1.0f);
    else
        out_color = vec4(1.0f, 0.0f, 0.0f, 1.0f);
}
#version 450
#extension GL_AMD_shader_explicit_vertex_parameter : require

layout(location = 0) __explicitInterpAMD in float in_data_explicit;
layout(location = 1) centroid smooth        in float in_data_smooth;
layout(location = 0) out vec4 out_color;
layout (binding = 0, std140) writeonly buffer Output {
    vec4 values [4096];
} sb_out;

void main()
{
    uint index = (uint(gl_FragCoord.y) * 16 * 4) + uint(gl_FragCoord.x) * 4 + gl_SampleID;
    // Barycentric coodinates (I, J, K)
    vec3 bary_coord = vec3(gl_BaryCoordSmoothCentroidAMD.x, gl_BaryCoordSmoothCentroidAMD.y, 1.0f - gl_BaryCoordSmoothCentroidAMD.x - gl_BaryCoordSmoothCentroidAMD.y);

    // Vertex 0 -> (I = 0, J = 0, K = 1)
    float data0 = interpolateAtVertexAMD(in_data_explicit, 0);
    // Vertex 1 -> (I = 1, J = 0, K = 0)
    float data1 = interpolateAtVertexAMD(in_data_explicit, 1);
    // Vertex 1 -> (I = 0, J = 1, K = 0)
    float data2 = interpolateAtVertexAMD(in_data_explicit, 2);
    // Match data component with barycentric coordinate
    vec3  data  = vec3(data1, data2, data0);

    float res      = (bary_coord.x * data.x) + (bary_coord.y * data.y) + (bary_coord.z * data.z);
    float expected = in_data_smooth;

    sb_out.values[ index ] = vec4(expected, res, 0u, 0u);

    const float threshold = 0.0005f;
    if (abs(res - expected) < threshold)
        out_color = vec4(0.0f, 1.0f, 0.0f, 1.0f);
    else
        out_color = vec4(1.0f, 0.0f, 0.0f, 1.0f);
}
#version 450
#extension GL_AMD_shader_explicit_vertex_parameter : require

layout(location = 0) __explicitInterpAMD in float in_data_explicit;
layout(location = 1)  noperspective        in float in_data_noperspective;
layout(location = 0) out vec4 out_color;
layout (binding = 0, std140) writeonly buffer Output {
    vec4 values [4096];
} sb_out;

void main()
{
    uint index = (uint(gl_FragCoord.y) * 16 * 4) + uint(gl_FragCoord.x) * 4 + gl_SampleID;
    // Barycentric coodinates (I, J, K)
    vec3 bary_coord = vec3(gl_BaryCoordNoPerspAMD.x, gl_BaryCoordNoPerspAMD.y, 1.0f - gl_BaryCoordNoPerspAMD.x - gl_BaryCoordNoPerspAMD.y);

    // Vertex 0 -> (I = 0, J = 0, K = 1)
    float data0 = interpolateAtVertexAMD(in_data_explicit, 0);
    // Vertex 1 -> (I = 1, J = 0, K = 0)
    float data1 = interpolateAtVertexAMD(in_data_explicit, 1);
    // Vertex 1 -> (I = 0, J = 1, K = 0)
    float data2 = interpolateAtVertexAMD(in_data_explicit, 2);
    // Match data component with barycentric coordinate
    vec3  data  = vec3(data1, data2, data0);

    float res      = (bary_coord.x * data.x) + (bary_coord.y * data.y) + (bary_coord.z * data.z);
    float expected = in_data_noperspective;

    sb_out.values[ index ] = vec4(expected, res, 0u, 0u);

    const float threshold = 0.0005f;
    if (abs(res - expected) < threshold)
        out_color = vec4(0.0f, 1.0f, 0.0f, 1.0f);
    else
        out_color = vec4(1.0f, 0.0f, 0.0f, 1.0f);
}
#version 450
#extension GL_AMD_shader_explicit_vertex_parameter : require

layout(location = 0) __explicitInterpAMD in float in_data_explicit;
layout(location = 1) sample noperspective        in float in_data_noperspective;
layout(location = 0) out vec4 out_color;
layout (binding = 0, std140) writeonly buffer Output {
    vec4 values [4096];
} sb_out;

void main()
{
    uint index = (uint(gl_FragCoord.y) * 16 * 4) + uint(gl_FragCoord.x) * 4 + gl_SampleID;
    // Barycentric coodinates (I, J, K)
    vec3 bary_coord = vec3(gl_BaryCoordNoPerspSampleAMD.x, gl_BaryCoordNoPerspSampleAMD.y, 1.0f - gl_BaryCoordNoPerspSampleAMD.x - gl_BaryCoordNoPerspSampleAMD.y);

    // Vertex 0 -> (I = 0, J = 0, K = 1)
    float data0 = interpolateAtVertexAMD(in_data_explicit, 0);
    // Vertex 1 -> (I = 1, J = 0, K = 0)
    float data1 = interpolateAtVertexAMD(in_data_explicit, 1);
    // Vertex 1 -> (I = 0, J = 1, K = 0)
    float data2 = interpolateAtVertexAMD(in_data_explicit, 2);
    // Match data component with barycentric coordinate
    vec3  data  = vec3(data1, data2, data0);

    float res      = (bary_coord.x * data.x) + (bary_coord.y * data.y) + (bary_coord.z * data.z);
    float expected = in_data_noperspective;

    sb_out.values[ index ] = vec4(expected, res, 0u, 0u);

    const float threshold = 0.0005f;
    if (abs(res - expected) < threshold)
        out_color = vec4(0.0f, 1.0f, 0.0f, 1.0f);
    else
        out_color = vec4(1.0f, 0.0f, 0.0f, 1.0f);
}
#version 450
#extension GL_AMD_shader_explicit_vertex_parameter : require

layout(location = 0) __explicitInterpAMD in float in_data_explicit;
layout(location = 1) centroid noperspective        in float in_data_noperspective;
layout(location = 0) out vec4 out_color;
layout (binding = 0, std140) writeonly buffer Output {
    vec4 values [4096];
} sb_out;

void main()
{
    uint index = (uint(gl_FragCoord.y) * 16 * 4) + uint(gl_FragCoord.x) * 4 + gl_SampleID;
    // Barycentric coodinates (I, J, K)
    vec3 bary_coord = vec3(gl_BaryCoordNoPerspCentroidAMD.x, gl_BaryCoordNoPerspCentroidAMD.y, 1.0f - gl_BaryCoordNoPerspCentroidAMD.x - gl_BaryCoordNoPerspCentroidAMD.y);

    // Vertex 0 -> (I = 0, J = 0, K = 1)
    float data0 = interpolateAtVertexAMD(in_data_explicit, 0);
    // Vertex 1 -> (I = 1, J = 0, K = 0)
    float data1 = interpolateAtVertexAMD(in_data_explicit, 1);
    // Vertex 1 -> (I = 0, J = 1, K = 0)
    float data2 = interpolateAtVertexAMD(in_data_explicit, 2);
    // Match data component with barycentric coordinate
    vec3  data  = vec3(data1, data2, data0);

    float res      = (bary_coord.x * data.x) + (bary_coord.y * data.y) + (bary_coord.z * data.z);
    float expected = in_data_noperspective;

    sb_out.values[ index ] = vec4(expected, res, 0u, 0u);

    const float threshold = 0.0005f;
    if (abs(res - expected) < threshold)
        out_color = vec4(0.0f, 1.0f, 0.0f, 1.0f);
    else
        out_color = vec4(1.0f, 0.0f, 0.0f, 1.0f);
}
#version 450
#extension GL_AMD_shader_explicit_vertex_parameter : require

layout(location = 0) __explicitInterpAMD in float in_data_explicit;
layout(location = 1)  smooth        in float in_data_smooth;
layout(location = 0) out vec4 out_color;
layout (binding = 0, std140) writeonly buffer Output {
    vec4 values [16384];
} sb_out;

void main()
{
    uint index = (uint(gl_FragCoord.y) * 16 * 8) + uint(gl_FragCoord.x) * 8 + gl_SampleID;
    // Barycentric coodinates (I, J, K)
    vec3 bary_coord = vec3(gl_BaryCoordSmoothAMD.x, gl_BaryCoordSmoothAMD.y, 1.0f - gl_BaryCoordSmoothAMD.x - gl_BaryCoordSmoothAMD.y);

    // Vertex 0 -> (I = 0, J = 0, K = 1)
    float data0 = interpolateAtVertexAMD(in_data_explicit, 0);
    // Vertex 1 -> (I = 1, J = 0, K = 0)
    float data1 = interpolateAtVertexAMD(in_data_explicit, 1);
    // Vertex 1 -> (I = 0, J = 1, K = 0)
    float data2 = interpolateAtVertexAMD(in_data_explicit, 2);
    // Match data component with barycentric coordinate
    vec3  data  = vec3(data1, data2, data0);

    float res      = (bary_coord.x * data.x) + (bary_coord.y * data.y) + (bary_coord.z * data.z);
    float expected = in_data_smooth;

    sb_out.values[ index ] = vec4(expected, res, 0u, 0u);

    const float threshold = 0.0005f;
    if (abs(res - expected) < threshold)
        out_color = vec4(0.0f, 1.0f, 0.0f, 1.0f);
    else
        out_color = vec4(1.0f, 0.0f, 0.0f, 1.0f);
}
#version 450
#extension GL_AMD_shader_explicit_vertex_parameter : require

layout(location = 0) __explicitInterpAMD in float in_data_explicit;
layout(location = 1) sample smooth        in float in_data_smooth;
layout(location = 0) out vec4 out_color;
layout (binding = 0, std140) writeonly buffer Output {
    vec4 values [16384];
} sb_out;

void main()
{
    uint index = (uint(gl_FragCoord.y) * 16 * 8) + uint(gl_FragCoord.x) * 8 + gl_SampleID;
    // Barycentric coodinates (I, J, K)
    vec3 bary_coord = vec3(gl_BaryCoordSmoothSampleAMD.x, gl_BaryCoordSmoothSampleAMD.y, 1.0f - gl_BaryCoordSmoothSampleAMD.x - gl_BaryCoordSmoothSampleAMD.y);

    // Vertex 0 -> (I = 0, J = 0, K = 1)
    float data0 = interpolateAtVertexAMD(in_data_explicit, 0);
    // Vertex 1 -> (I = 1, J = 0, K = 0)
    float data1 = interpolateAtVertexAMD(in_data_explicit, 1);
    // Vertex 1 -> (I = 0, J = 1, K = 0)
    float data2 = interpolateAtVertexAMD(in_data_explicit, 2);
    // Match data component with barycentric coordinate
    vec3  data  = vec3(data1, data2, data0);

    float res      = (bary_coord.x * data.x) + (bary_coord.y * data.y) + (bary_coord.z * data.z);
    float expected = in_data_smooth;

    sb_out.values[ index ] = vec4(expected, res, 0u, 0u);

    const float threshold = 0.0005f;
    if (abs(res - expected) < threshold)
        out_color = vec4(0.0f, 1.0f, 0.0f, 1.0f);
    else
        out_color = vec4(1.0f, 0.0f, 0.0f, 1.0f);
}
#version 450
#extension GL_AMD_shader_explicit_vertex_parameter : require

layout(location = 0) __explicitInterpAMD in float in_data_explicit;
layout(location = 1) centroid smooth        in float in_data_smooth;
layout(location = 0) out vec4 out_color;
layout (binding = 0, std140) writeonly buffer Output {
    vec4 values [16384];
} sb_out;

void main()
{
    uint index = (uint(gl_FragCoord.y) * 16 * 8) + uint(gl_FragCoord.x) * 8 + gl_SampleID;
    // Barycentric coodinates (I, J, K)
    vec3 bary_coord = vec3(gl_BaryCoordSmoothCentroidAMD.x, gl_BaryCoordSmoothCentroidAMD.y, 1.0f - gl_BaryCoordSmoothCentroidAMD.x - gl_BaryCoordSmoothCentroidAMD.y);

    // Vertex 0 -> (I = 0, J = 0, K = 1)
    float data0 = interpolateAtVertexAMD(in_data_explicit, 0);
    // Vertex 1 -> (I = 1, J = 0, K = 0)
    float data1 = interpolateAtVertexAMD(in_data_explicit, 1);
    // Vertex 1 -> (I = 0, J = 1, K = 0)
    float data2 = interpolateAtVertexAMD(in_data_explicit, 2);
    // Match data component with barycentric coordinate
    vec3  data  = vec3(data1, data2, data0);

    float res      = (bary_coord.x * data.x) + (bary_coord.y * data.y) + (bary_coord.z * data.z);
    float expected = in_data_smooth;

    sb_out.values[ index ] = vec4(expected, res, 0u, 0u);

    const float threshold = 0.0005f;
    if (abs(res - expected) < threshold)
        out_color = vec4(0.0f, 1.0f, 0.0f, 1.0f);
    else
        out_color = vec4(1.0f, 0.0f, 0.0f, 1.0f);
}
#version 450
#extension GL_AMD_shader_explicit_vertex_parameter : require

layout(location = 0) __explicitInterpAMD in float in_data_explicit;
layout(location = 1)  noperspective        in float in_data_noperspective;
layout(location = 0) out vec4 out_color;
layout (binding = 0, std140) writeonly buffer Output {
    vec4 values [16384];
} sb_out;

void main()
{
    uint index = (uint(gl_FragCoord.y) * 16 * 8) + uint(gl_FragCoord.x) * 8 + gl_SampleID;
    // Barycentric coodinates (I, J, K)
    vec3 bary_coord = vec3(gl_BaryCoordNoPerspAMD.x, gl_BaryCoordNoPerspAMD.y, 1.0f - gl_BaryCoordNoPerspAMD.x - gl_BaryCoordNoPerspAMD.y);

    // Vertex 0 -> (I = 0, J = 0, K = 1)
    float data0 = interpolateAtVertexAMD(in_data_explicit, 0);
    // Vertex 1 -> (I = 1, J = 0, K = 0)
    float data1 = interpolateAtVertexAMD(in_data_explicit, 1);
    // Vertex 1 -> (I = 0, J = 1, K = 0)
    float data2 = interpolateAtVertexAMD(in_data_explicit, 2);
    // Match data component with barycentric coordinate
    vec3  data  = vec3(data1, data2, data0);

    float res      = (bary_coord.x * data.x) + (bary_coord.y * data.y) + (bary_coord.z * data.z);
    float expected = in_data_noperspective;

    sb_out.values[ index ] = vec4(expected, res, 0u, 0u);

    const float threshold = 0.0005f;
    if (abs(res - expected) < threshold)
        out_color = vec4(0.0f, 1.0f, 0.0f, 1.0f);
    else
        out_color = vec4(1.0f, 0.0f, 0.0f, 1.0f);
}
#version 450
#extension GL_AMD_shader_explicit_vertex_parameter : require

layout(location = 0) __explicitInterpAMD in float in_data_explicit;
layout(location = 1) sample noperspective        in float in_data_noperspective;
layout(location = 0) out vec4 out_color;
layout (binding = 0, std140) writeonly buffer Output {
    vec4 values [16384];
} sb_out;

void main()
{
    uint index = (uint(gl_FragCoord.y) * 16 * 8) + uint(gl_FragCoord.x) * 8 + gl_SampleID;
    // Barycentric coodinates (I, J, K)
    vec3 bary_coord = vec3(gl_BaryCoordNoPerspSampleAMD.x, gl_BaryCoordNoPerspSampleAMD.y, 1.0f - gl_BaryCoordNoPerspSampleAMD.x - gl_BaryCoordNoPerspSampleAMD.y);

    // Vertex 0 -> (I = 0, J = 0, K = 1)
    float data0 = interpolateAtVertexAMD(in_data_explicit, 0);
    // Vertex 1 -> (I = 1, J = 0, K = 0)
    float data1 = interpolateAtVertexAMD(in_data_explicit, 1);
    // Vertex 1 -> (I = 0, J = 1, K = 0)
    float data2 = interpolateAtVertexAMD(in_data_explicit, 2);
    // Match data component with barycentric coordinate
    vec3  data  = vec3(data1, data2, data0);

    float res      = (bary_coord.x * data.x) + (bary_coord.y * data.y) + (bary_coord.z * data.z);
    float expected = in_data_noperspective;

    sb_out.values[ index ] = vec4(expected, res, 0u, 0u);

    const float threshold = 0.0005f;
    if (abs(res - expected) < threshold)
        out_color = vec4(0.0f, 1.0f, 0.0f, 1.0f);
    else
        out_color = vec4(1.0f, 0.0f, 0.0f, 1.0f);
}
#version 450
#extension GL_AMD_shader_explicit_vertex_parameter : require

layout(location = 0) __explicitInterpAMD in float in_data_explicit;
layout(location = 1) centroid noperspective        in float in_data_noperspective;
layout(location = 0) out vec4 out_color;
layout (binding = 0, std140) writeonly buffer Output {
    vec4 values [16384];
} sb_out;

void main()
{
    uint index = (uint(gl_FragCoord.y) * 16 * 8) + uint(gl_FragCoord.x) * 8 + gl_SampleID;
    // Barycentric coodinates (I, J, K)
    vec3 bary_coord = vec3(gl_BaryCoordNoPerspCentroidAMD.x, gl_BaryCoordNoPerspCentroidAMD.y, 1.0f - gl_BaryCoordNoPerspCentroidAMD.x - gl_BaryCoordNoPerspCentroidAMD.y);

    // Vertex 0 -> (I = 0, J = 0, K = 1)
    float data0 = interpolateAtVertexAMD(in_data_explicit, 0);
    // Vertex 1 -> (I = 1, J = 0, K = 0)
    float data1 = interpolateAtVertexAMD(in_data_explicit, 1);
    // Vertex 1 -> (I = 0, J = 1, K = 0)
    float data2 = interpolateAtVertexAMD(in_data_explicit, 2);
    // Match data component with barycentric coordinate
    vec3  data  = vec3(data1, data2, data0);

    float res      = (bary_coord.x * data.x) + (bary_coord.y * data.y) + (bary_coord.z * data.z);
    float expected = in_data_noperspective;

    sb_out.values[ index ] = vec4(expected, res, 0u, 0u);

    const float threshold = 0.0005f;
    if (abs(res - expected) < threshold)
        out_color = vec4(0.0f, 1.0f, 0.0f, 1.0f);
    else
        out_color = vec4(1.0f, 0.0f, 0.0f, 1.0f);
}
#version 450
#extension GL_AMD_shader_explicit_vertex_parameter : require

layout(location = 0) __explicitInterpAMD in float in_data_explicit;
layout(location = 1)  smooth        in float in_data_smooth;
layout(location = 0) out vec4 out_color;
layout (binding = 0, std140) writeonly buffer Output {
    vec4 values [65536];
} sb_out;

void main()
{
    uint index = (uint(gl_FragCoord.y) * 16 * 16) + uint(gl_FragCoord.x) * 16 + gl_SampleID;
    // Barycentric coodinates (I, J, K)
    vec3 bary_coord = vec3(gl_BaryCoordSmoothAMD.x, gl_BaryCoordSmoothAMD.y, 1.0f - gl_BaryCoordSmoothAMD.x - gl_BaryCoordSmoothAMD.y);

    // Vertex 0 -> (I = 0, J = 0, K = 1)
    float data0 = interpolateAtVertexAMD(in_data_explicit, 0);
    // Vertex 1 -> (I = 1, J = 0, K = 0)
    float data1 = interpolateAtVertexAMD(in_data_explicit, 1);
    // Vertex 1 -> (I = 0, J = 1, K = 0)
    float data2 = interpolateAtVertexAMD(in_data_explicit, 2);
    // Match data component with barycentric coordinate
    vec3  data  = vec3(data1, data2, data0);

    float res      = (bary_coord.x * data.x) + (bary_coord.y * data.y) + (bary_coord.z * data.z);
    float expected = in_data_smooth;

    sb_out.values[ index ] = vec4(expected, res, 0u, 0u);

    const float threshold = 0.0005f;
    if (abs(res - expected) < threshold)
        out_color = vec4(0.0f, 1.0f, 0.0f, 1.0f);
    else
        out_color = vec4(1.0f, 0.0f, 0.0f, 1.0f);
}
#version 450
#extension GL_AMD_shader_explicit_vertex_parameter : require

layout(location = 0) __explicitInterpAMD in float in_data_explicit;
layout(location = 1) sample smooth        in float in_data_smooth;
layout(location = 0) out vec4 out_color;
layout (binding = 0, std140) writeonly buffer Output {
    vec4 values [65536];
} sb_out;

void main()
{
    uint index = (uint(gl_FragCoord.y) * 16 * 16) + uint(gl_FragCoord.x) * 16 + gl_SampleID;
    // Barycentric coodinates (I, J, K)
    vec3 bary_coord = vec3(gl_BaryCoordSmoothSampleAMD.x, gl_BaryCoordSmoothSampleAMD.y, 1.0f - gl_BaryCoordSmoothSampleAMD.x - gl_BaryCoordSmoothSampleAMD.y);

    // Vertex 0 -> (I = 0, J = 0, K = 1)
    float data0 = interpolateAtVertexAMD(in_data_explicit, 0);
    // Vertex 1 -> (I = 1, J = 0, K = 0)
    float data1 = interpolateAtVertexAMD(in_data_explicit, 1);
    // Vertex 1 -> (I = 0, J = 1, K = 0)
    float data2 = interpolateAtVertexAMD(in_data_explicit, 2);
    // Match data component with barycentric coordinate
    vec3  data  = vec3(data1, data2, data0);

    float res      = (bary_coord.x * data.x) + (bary_coord.y * data.y) + (bary_coord.z * data.z);
    float expected = in_data_smooth;

    sb_out.values[ index ] = vec4(expected, res, 0u, 0u);

    const float threshold = 0.0005f;
    if (abs(res - expected) < threshold)
        out_color = vec4(0.0f, 1.0f, 0.0f, 1.0f);
    else
        out_color = vec4(1.0f, 0.0f, 0.0f, 1.0f);
}
#version 450
#extension GL_AMD_shader_explicit_vertex_parameter : require

layout(location = 0) __explicitInterpAMD in float in_data_explicit;
layout(location = 1) centroid smooth        in float in_data_smooth;
layout(location = 0) out vec4 out_color;
layout (binding = 0, std140) writeonly buffer Output {
    vec4 values [65536];
} sb_out;

void main()
{
    uint index = (uint(gl_FragCoord.y) * 16 * 16) + uint(gl_FragCoord.x) * 16 + gl_SampleID;
    // Barycentric coodinates (I, J, K)
    vec3 bary_coord = vec3(gl_BaryCoordSmoothCentroidAMD.x, gl_BaryCoordSmoothCentroidAMD.y, 1.0f - gl_BaryCoordSmoothCentroidAMD.x - gl_BaryCoordSmoothCentroidAMD.y);

    // Vertex 0 -> (I = 0, J = 0, K = 1)
    float data0 = interpolateAtVertexAMD(in_data_explicit, 0);
    // Vertex 1 -> (I = 1, J = 0, K = 0)
    float data1 = interpolateAtVertexAMD(in_data_explicit, 1);
    // Vertex 1 -> (I = 0, J = 1, K = 0)
    float data2 = interpolateAtVertexAMD(in_data_explicit, 2);
    // Match data component with barycentric coordinate
    vec3  data  = vec3(data1, data2, data0);

    float res      = (bary_coord.x * data.x) + (bary_coord.y * data.y) + (bary_coord.z * data.z);
    float expected = in_data_smooth;

    sb_out.values[ index ] = vec4(expected, res, 0u, 0u);

    const float threshold = 0.0005f;
    if (abs(res - expected) < threshold)
        out_color = vec4(0.0f, 1.0f, 0.0f, 1.0f);
    else
        out_color = vec4(1.0f, 0.0f, 0.0f, 1.0f);
}
#version 450
#extension GL_AMD_shader_explicit_vertex_parameter : require

layout(location = 0) __explicitInterpAMD in float in_data_explicit;
layout(location = 1)  noperspective        in float in_data_noperspective;
layout(location = 0) out vec4 out_color;
layout (binding = 0, std140) writeonly buffer Output {
    vec4 values [65536];
} sb_out;

void main()
{
    uint index = (uint(gl_FragCoord.y) * 16 * 16) + uint(gl_FragCoord.x) * 16 + gl_SampleID;
    // Barycentric coodinates (I, J, K)
    vec3 bary_coord = vec3(gl_BaryCoordNoPerspAMD.x, gl_BaryCoordNoPerspAMD.y, 1.0f - gl_BaryCoordNoPerspAMD.x - gl_BaryCoordNoPerspAMD.y);

    // Vertex 0 -> (I = 0, J = 0, K = 1)
    float data0 = interpolateAtVertexAMD(in_data_explicit, 0);
    // Vertex 1 -> (I = 1, J = 0, K = 0)
    float data1 = interpolateAtVertexAMD(in_data_explicit, 1);
    // Vertex 1 -> (I = 0, J = 1, K = 0)
    float data2 = interpolateAtVertexAMD(in_data_explicit, 2);
    // Match data component with barycentric coordinate
    vec3  data  = vec3(data1, data2, data0);

    float res      = (bary_coord.x * data.x) + (bary_coord.y * data.y) + (bary_coord.z * data.z);
    float expected = in_data_noperspective;

    sb_out.values[ index ] = vec4(expected, res, 0u, 0u);

    const float threshold = 0.0005f;
    if (abs(res - expected) < threshold)
        out_color = vec4(0.0f, 1.0f, 0.0f, 1.0f);
    else
        out_color = vec4(1.0f, 0.0f, 0.0f, 1.0f);
}
#version 450
#extension GL_AMD_shader_explicit_vertex_parameter : require

layout(location = 0) __explicitInterpAMD in float in_data_explicit;
layout(location = 1) sample noperspective        in float in_data_noperspective;
layout(location = 0) out vec4 out_color;
layout (binding = 0, std140) writeonly buffer Output {
    vec4 values [65536];
} sb_out;

void main()
{
    uint index = (uint(gl_FragCoord.y) * 16 * 16) + uint(gl_FragCoord.x) * 16 + gl_SampleID;
    // Barycentric coodinates (I, J, K)
    vec3 bary_coord = vec3(gl_BaryCoordNoPerspSampleAMD.x, gl_BaryCoordNoPerspSampleAMD.y, 1.0f - gl_BaryCoordNoPerspSampleAMD.x - gl_BaryCoordNoPerspSampleAMD.y);

    // Vertex 0 -> (I = 0, J = 0, K = 1)
    float data0 = interpolateAtVertexAMD(in_data_explicit, 0);
    // Vertex 1 -> (I = 1, J = 0, K = 0)
    float data1 = interpolateAtVertexAMD(in_data_explicit, 1);
    // Vertex 1 -> (I = 0, J = 1, K = 0)
    float data2 = interpolateAtVertexAMD(in_data_explicit, 2);
    // Match data component with barycentric coordinate
    vec3  data  = vec3(data1, data2, data0);

    float res      = (bary_coord.x * data.x) + (bary_coord.y * data.y) + (bary_coord.z * data.z);
    float expected = in_data_noperspective;

    sb_out.values[ index ] = vec4(expected, res, 0u, 0u);

    const float threshold = 0.0005f;
    if (abs(res - expected) < threshold)
        out_color = vec4(0.0f, 1.0f, 0.0f, 1.0f);
    else
        out_color = vec4(1.0f, 0.0f, 0.0f, 1.0f);
}
#version 450
#extension GL_AMD_shader_explicit_vertex_parameter : require

layout(location = 0) __explicitInterpAMD in float in_data_explicit;
layout(location = 1) centroid noperspective        in float in_data_noperspective;
layout(location = 0) out vec4 out_color;
layout (binding = 0, std140) writeonly buffer Output {
    vec4 values [65536];
} sb_out;

void main()
{
    uint index = (uint(gl_FragCoord.y) * 16 * 16) + uint(gl_FragCoord.x) * 16 + gl_SampleID;
    // Barycentric coodinates (I, J, K)
    vec3 bary_coord = vec3(gl_BaryCoordNoPerspCentroidAMD.x, gl_BaryCoordNoPerspCentroidAMD.y, 1.0f - gl_BaryCoordNoPerspCentroidAMD.x - gl_BaryCoordNoPerspCentroidAMD.y);

    // Vertex 0 -> (I = 0, J = 0, K = 1)
    float data0 = interpolateAtVertexAMD(in_data_explicit, 0);
    // Vertex 1 -> (I = 1, J = 0, K = 0)
    float data1 = interpolateAtVertexAMD(in_data_explicit, 1);
    // Vertex 1 -> (I = 0, J = 1, K = 0)
    float data2 = interpolateAtVertexAMD(in_data_explicit, 2);
    // Match data component with barycentric coordinate
    vec3  data  = vec3(data1, data2, data0);

    float res      = (bary_coord.x * data.x) + (bary_coord.y * data.y) + (bary_coord.z * data.z);
    float expected = in_data_noperspective;

    sb_out.values[ index ] = vec4(expected, res, 0u, 0u);

    const float threshold = 0.0005f;
    if (abs(res - expected) < threshold)
        out_color = vec4(0.0f, 1.0f, 0.0f, 1.0f);
    else
        out_color = vec4(1.0f, 0.0f, 0.0f, 1.0f);
}
#version 450
#extension GL_AMD_shader_explicit_vertex_parameter : require

layout(location = 0) __explicitInterpAMD in float in_data_explicit;
layout(location = 1)  smooth        in float in_data_smooth;
layout(location = 0) out vec4 out_color;
layout (binding = 0, std140) writeonly buffer Output {
    vec4 values [262144];
} sb_out;

void main()
{
    uint index = (uint(gl_FragCoord.y) * 16 * 32) + uint(gl_FragCoord.x) * 32 + gl_SampleID;
    // Barycentric coodinates (I, J, K)
    vec3 bary_coord = vec3(gl_BaryCoordSmoothAMD.x, gl_BaryCoordSmoothAMD.y, 1.0f - gl_BaryCoordSmoothAMD.x - gl_BaryCoordSmoothAMD.y);

    // Vertex 0 -> (I = 0, J = 0, K = 1)
    float data0 = interpolateAtVertexAMD(in_data_explicit, 0);
    // Vertex 1 -> (I = 1, J = 0, K = 0)
    float data1 = interpolateAtVertexAMD(in_data_explicit, 1);
    // Vertex 1 -> (I = 0, J = 1, K = 0)
    float data2 = interpolateAtVertexAMD(in_data_explicit, 2);
    // Match data component with barycentric coordinate
    vec3  data  = vec3(data1, data2, data0);

    float res      = (bary_coord.x * data.x) + (bary_coord.y * data.y) + (bary_coord.z * data.z);
    float expected = in_data_smooth;

    sb_out.values[ index ] = vec4(expected, res, 0u, 0u);

    const float threshold = 0.0005f;
    if (abs(res - expected) < threshold)
        out_color = vec4(0.0f, 1.0f, 0.0f, 1.0f);
    else
        out_color = vec4(1.0f, 0.0f, 0.0f, 1.0f);
}
#version 450
#extension GL_AMD_shader_explicit_vertex_parameter : require

layout(location = 0) __explicitInterpAMD in float in_data_explicit;
layout(location = 1) sample smooth        in float in_data_smooth;
layout(location = 0) out vec4 out_color;
layout (binding = 0, std140) writeonly buffer Output {
    vec4 values [262144];
} sb_out;

void main()
{
    uint index = (uint(gl_FragCoord.y) * 16 * 32) + uint(gl_FragCoord.x) * 32 + gl_SampleID;
    // Barycentric coodinates (I, J, K)
    vec3 bary_coord = vec3(gl_BaryCoordSmoothSampleAMD.x, gl_BaryCoordSmoothSampleAMD.y, 1.0f - gl_BaryCoordSmoothSampleAMD.x - gl_BaryCoordSmoothSampleAMD.y);

    // Vertex 0 -> (I = 0, J = 0, K = 1)
    float data0 = interpolateAtVertexAMD(in_data_explicit, 0);
    // Vertex 1 -> (I = 1, J = 0, K = 0)
    float data1 = interpolateAtVertexAMD(in_data_explicit, 1);
    // Vertex 1 -> (I = 0, J = 1, K = 0)
    float data2 = interpolateAtVertexAMD(in_data_explicit, 2);
    // Match data component with barycentric coordinate
    vec3  data  = vec3(data1, data2, data0);

    float res      = (bary_coord.x * data.x) + (bary_coord.y * data.y) + (bary_coord.z * data.z);
    float expected = in_data_smooth;

    sb_out.values[ index ] = vec4(expected, res, 0u, 0u);

    const float threshold = 0.0005f;
    if (abs(res - expected) < threshold)
        out_color = vec4(0.0f, 1.0f, 0.0f, 1.0f);
    else
        out_color = vec4(1.0f, 0.0f, 0.0f, 1.0f);
}
#version 450
#extension GL_AMD_shader_explicit_vertex_parameter : require

layout(location = 0) __explicitInterpAMD in float in_data_explicit;
layout(location = 1) centroid smooth        in float in_data_smooth;
layout(location = 0) out vec4 out_color;
layout (binding = 0, std140) writeonly buffer Output {
    vec4 values [262144];
} sb_out;

void main()
{
    uint index = (uint(gl_FragCoord.y) * 16 * 32) + uint(gl_FragCoord.x) * 32 + gl_SampleID;
    // Barycentric coodinates (I, J, K)
    vec3 bary_coord = vec3(gl_BaryCoordSmoothCentroidAMD.x, gl_BaryCoordSmoothCentroidAMD.y, 1.0f - gl_BaryCoordSmoothCentroidAMD.x - gl_BaryCoordSmoothCentroidAMD.y);

    // Vertex 0 -> (I = 0, J = 0, K = 1)
    float data0 = interpolateAtVertexAMD(in_data_explicit, 0);
    // Vertex 1 -> (I = 1, J = 0, K = 0)
    float data1 = interpolateAtVertexAMD(in_data_explicit, 1);
    // Vertex 1 -> (I = 0, J = 1, K = 0)
    float data2 = interpolateAtVertexAMD(in_data_explicit, 2);
    // Match data component with barycentric coordinate
    vec3  data  = vec3(data1, data2, data0);

    float res      = (bary_coord.x * data.x) + (bary_coord.y * data.y) + (bary_coord.z * data.z);
    float expected = in_data_smooth;

    sb_out.values[ index ] = vec4(expected, res, 0u, 0u);

    const float threshold = 0.0005f;
    if (abs(res - expected) < threshold)
        out_color = vec4(0.0f, 1.0f, 0.0f, 1.0f);
    else
        out_color = vec4(1.0f, 0.0f, 0.0f, 1.0f);
}
#version 450
#extension GL_AMD_shader_explicit_vertex_parameter : require

layout(location = 0) __explicitInterpAMD in float in_data_explicit;
layout(location = 1)  noperspective        in float in_data_noperspective;
layout(location = 0) out vec4 out_color;
layout (binding = 0, std140) writeonly buffer Output {
    vec4 values [262144];
} sb_out;

void main()
{
    uint index = (uint(gl_FragCoord.y) * 16 * 32) + uint(gl_FragCoord.x) * 32 + gl_SampleID;
    // Barycentric coodinates (I, J, K)
    vec3 bary_coord = vec3(gl_BaryCoordNoPerspAMD.x, gl_BaryCoordNoPerspAMD.y, 1.0f - gl_BaryCoordNoPerspAMD.x - gl_BaryCoordNoPerspAMD.y);

    // Vertex 0 -> (I = 0, J = 0, K = 1)
    float data0 = interpolateAtVertexAMD(in_data_explicit, 0);
    // Vertex 1 -> (I = 1, J = 0, K = 0)
    float data1 = interpolateAtVertexAMD(in_data_explicit, 1);
    // Vertex 1 -> (I = 0, J = 1, K = 0)
    float data2 = interpolateAtVertexAMD(in_data_explicit, 2);
    // Match data component with barycentric coordinate
    vec3  data  = vec3(data1, data2, data0);

    float res      = (bary_coord.x * data.x) + (bary_coord.y * data.y) + (bary_coord.z * data.z);
    float expected = in_data_noperspective;

    sb_out.values[ index ] = vec4(expected, res, 0u, 0u);

    const float threshold = 0.0005f;
    if (abs(res - expected) < threshold)
        out_color = vec4(0.0f, 1.0f, 0.0f, 1.0f);
    else
        out_color = vec4(1.0f, 0.0f, 0.0f, 1.0f);
}
#version 450
#extension GL_AMD_shader_explicit_vertex_parameter : require

layout(location = 0) __explicitInterpAMD in float in_data_explicit;
layout(location = 1) sample noperspective        in float in_data_noperspective;
layout(location = 0) out vec4 out_color;
layout (binding = 0, std140) writeonly buffer Output {
    vec4 values [262144];
} sb_out;

void main()
{
    uint index = (uint(gl_FragCoord.y) * 16 * 32) + uint(gl_FragCoord.x) * 32 + gl_SampleID;
    // Barycentric coodinates (I, J, K)
    vec3 bary_coord = vec3(gl_BaryCoordNoPerspSampleAMD.x, gl_BaryCoordNoPerspSampleAMD.y, 1.0f - gl_BaryCoordNoPerspSampleAMD.x - gl_BaryCoordNoPerspSampleAMD.y);

    // Vertex 0 -> (I = 0, J = 0, K = 1)
    float data0 = interpolateAtVertexAMD(in_data_explicit, 0);
    // Vertex 1 -> (I = 1, J = 0, K = 0)
    float data1 = interpolateAtVertexAMD(in_data_explicit, 1);
    // Vertex 1 -> (I = 0, J = 1, K = 0)
    float data2 = interpolateAtVertexAMD(in_data_explicit, 2);
    // Match data component with barycentric coordinate
    vec3  data  = vec3(data1, data2, data0);

    float res      = (bary_coord.x * data.x) + (bary_coord.y * data.y) + (bary_coord.z * data.z);
    float expected = in_data_noperspective;

    sb_out.values[ index ] = vec4(expected, res, 0u, 0u);

    const float threshold = 0.0005f;
    if (abs(res - expected) < threshold)
        out_color = vec4(0.0f, 1.0f, 0.0f, 1.0f);
    else
        out_color = vec4(1.0f, 0.0f, 0.0f, 1.0f);
}
#version 450
#extension GL_AMD_shader_explicit_vertex_parameter : require

layout(location = 0) __explicitInterpAMD in float in_data_explicit;
layout(location = 1) centroid noperspective        in float in_data_noperspective;
layout(location = 0) out vec4 out_color;
layout (binding = 0, std140) writeonly buffer Output {
    vec4 values [262144];
} sb_out;

void main()
{
    uint index = (uint(gl_FragCoord.y) * 16 * 32) + uint(gl_FragCoord.x) * 32 + gl_SampleID;
    // Barycentric coodinates (I, J, K)
    vec3 bary_coord = vec3(gl_BaryCoordNoPerspCentroidAMD.x, gl_BaryCoordNoPerspCentroidAMD.y, 1.0f - gl_BaryCoordNoPerspCentroidAMD.x - gl_BaryCoordNoPerspCentroidAMD.y);

    // Vertex 0 -> (I = 0, J = 0, K = 1)
    float data0 = interpolateAtVertexAMD(in_data_explicit, 0);
    // Vertex 1 -> (I = 1, J = 0, K = 0)
    float data1 = interpolateAtVertexAMD(in_data_explicit, 1);
    // Vertex 1 -> (I = 0, J = 1, K = 0)
    float data2 = interpolateAtVertexAMD(in_data_explicit, 2);
    // Match data component with barycentric coordinate
    vec3  data  = vec3(data1, data2, data0);

    float res      = (bary_coord.x * data.x) + (bary_coord.y * data.y) + (bary_coord.z * data.z);
    float expected = in_data_noperspective;

    sb_out.values[ index ] = vec4(expected, res, 0u, 0u);

    const float threshold = 0.0005f;
    if (abs(res - expected) < threshold)
        out_color = vec4(0.0f, 1.0f, 0.0f, 1.0f);
    else
        out_color = vec4(1.0f, 0.0f, 0.0f, 1.0f);
}
#version 450
#extension GL_AMD_shader_explicit_vertex_parameter : require

layout(location = 0) __explicitInterpAMD in float in_data_explicit;
layout(location = 1)  smooth        in float in_data_smooth;
layout(location = 0) out vec4 out_color;
layout (binding = 0, std140) writeonly buffer Output {
    vec4 values [1048576];
} sb_out;

void main()
{
    uint index = (uint(gl_FragCoord.y) * 16 * 64) + uint(gl_FragCoord.x) * 64 + gl_SampleID;
    // Barycentric coodinates (I, J, K)
    vec3 bary_coord = vec3(gl_BaryCoordSmoothAMD.x, gl_BaryCoordSmoothAMD.y, 1.0f - gl_BaryCoordSmoothAMD.x - gl_BaryCoordSmoothAMD.y);

    // Vertex 0 -> (I = 0, J = 0, K = 1)
    float data0 = interpolateAtVertexAMD(in_data_explicit, 0);
    // Vertex 1 -> (I = 1, J = 0, K = 0)
    float data1 = interpolateAtVertexAMD(in_data_explicit, 1);
    // Vertex 1 -> (I = 0, J = 1, K = 0)
    float data2 = interpolateAtVertexAMD(in_data_explicit, 2);
    // Match data component with barycentric coordinate
    vec3  data  = vec3(data1, data2, data0);

    float res      = (bary_coord.x * data.x) + (bary_coord.y * data.y) + (bary_coord.z * data.z);
    float expected = in_data_smooth;

    sb_out.values[ index ] = vec4(expected, res, 0u, 0u);

    const float threshold = 0.0005f;
    if (abs(res - expected) < threshold)
        out_color = vec4(0.0f, 1.0f, 0.0f, 1.0f);
    else
        out_color = vec4(1.0f, 0.0f, 0.0f, 1.0f);
}
#version 450
#extension GL_AMD_shader_explicit_vertex_parameter : require

layout(location = 0) __explicitInterpAMD in float in_data_explicit;
layout(location = 1) sample smooth        in float in_data_smooth;
layout(location = 0) out vec4 out_color;
layout (binding = 0, std140) writeonly buffer Output {
    vec4 values [1048576];
} sb_out;

void main()
{
    uint index = (uint(gl_FragCoord.y) * 16 * 64) + uint(gl_FragCoord.x) * 64 + gl_SampleID;
    // Barycentric coodinates (I, J, K)
    vec3 bary_coord = vec3(gl_BaryCoordSmoothSampleAMD.x, gl_BaryCoordSmoothSampleAMD.y, 1.0f - gl_BaryCoordSmoothSampleAMD.x - gl_BaryCoordSmoothSampleAMD.y);

    // Vertex 0 -> (I = 0, J = 0, K = 1)
    float data0 = interpolateAtVertexAMD(in_data_explicit, 0);
    // Vertex 1 -> (I = 1, J = 0, K = 0)
    float data1 = interpolateAtVertexAMD(in_data_explicit, 1);
    // Vertex 1 -> (I = 0, J = 1, K = 0)
    float data2 = interpolateAtVertexAMD(in_data_explicit, 2);
    // Match data component with barycentric coordinate
    vec3  data  = vec3(data1, data2, data0);

    float res      = (bary_coord.x * data.x) + (bary_coord.y * data.y) + (bary_coord.z * data.z);
    float expected = in_data_smooth;

    sb_out.values[ index ] = vec4(expected, res, 0u, 0u);

    const float threshold = 0.0005f;
    if (abs(res - expected) < threshold)
        out_color = vec4(0.0f, 1.0f, 0.0f, 1.0f);
    else
        out_color = vec4(1.0f, 0.0f, 0.0f, 1.0f);
}
#version 450
#extension GL_AMD_shader_explicit_vertex_parameter : require

layout(location = 0) __explicitInterpAMD in float in_data_explicit;
layout(location = 1) centroid smooth        in float in_data_smooth;
layout(location = 0) out vec4 out_color;
layout (binding = 0, std140) writeonly buffer Output {
    vec4 values [1048576];
} sb_out;

void main()
{
    uint index = (uint(gl_FragCoord.y) * 16 * 64) + uint(gl_FragCoord.x) * 64 + gl_SampleID;
    // Barycentric coodinates (I, J, K)
    vec3 bary_coord = vec3(gl_BaryCoordSmoothCentroidAMD.x, gl_BaryCoordSmoothCentroidAMD.y, 1.0f - gl_BaryCoordSmoothCentroidAMD.x - gl_BaryCoordSmoothCentroidAMD.y);

    // Vertex 0 -> (I = 0, J = 0, K = 1)
    float data0 = interpolateAtVertexAMD(in_data_explicit, 0);
    // Vertex 1 -> (I = 1, J = 0, K = 0)
    float data1 = interpolateAtVertexAMD(in_data_explicit, 1);
    // Vertex 1 -> (I = 0, J = 1, K = 0)
    float data2 = interpolateAtVertexAMD(in_data_explicit, 2);
    // Match data component with barycentric coordinate
    vec3  data  = vec3(data1, data2, data0);

    float res      = (bary_coord.x * data.x) + (bary_coord.y * data.y) + (bary_coord.z * data.z);
    float expected = in_data_smooth;

    sb_out.values[ index ] = vec4(expected, res, 0u, 0u);

    const float threshold = 0.0005f;
    if (abs(res - expected) < threshold)
        out_color = vec4(0.0f, 1.0f, 0.0f, 1.0f);
    else
        out_color = vec4(1.0f, 0.0f, 0.0f, 1.0f);
}
#version 450
#extension GL_AMD_shader_explicit_vertex_parameter : require

layout(location = 0) __explicitInterpAMD in float in_data_explicit;
layout(location = 1)  noperspective        in float in_data_noperspective;
layout(location = 0) out vec4 out_color;
layout (binding = 0, std140) writeonly buffer Output {
    vec4 values [1048576];
} sb_out;

void main()
{
    uint index = (uint(gl_FragCoord.y) * 16 * 64) + uint(gl_FragCoord.x) * 64 + gl_SampleID;
    // Barycentric coodinates (I, J, K)
    vec3 bary_coord = vec3(gl_BaryCoordNoPerspAMD.x, gl_BaryCoordNoPerspAMD.y, 1.0f - gl_BaryCoordNoPerspAMD.x - gl_BaryCoordNoPerspAMD.y);

    // Vertex 0 -> (I = 0, J = 0, K = 1)
    float data0 = interpolateAtVertexAMD(in_data_explicit, 0);
    // Vertex 1 -> (I = 1, J = 0, K = 0)
    float data1 = interpolateAtVertexAMD(in_data_explicit, 1);
    // Vertex 1 -> (I = 0, J = 1, K = 0)
    float data2 = interpolateAtVertexAMD(in_data_explicit, 2);
    // Match data component with barycentric coordinate
    vec3  data  = vec3(data1, data2, data0);

    float res      = (bary_coord.x * data.x) + (bary_coord.y * data.y) + (bary_coord.z * data.z);
    float expected = in_data_noperspective;

    sb_out.values[ index ] = vec4(expected, res, 0u, 0u);

    const float threshold = 0.0005f;
    if (abs(res - expected) < threshold)
        out_color = vec4(0.0f, 1.0f, 0.0f, 1.0f);
    else
        out_color = vec4(1.0f, 0.0f, 0.0f, 1.0f);
}
#version 450
#extension GL_AMD_shader_explicit_vertex_parameter : require

layout(location = 0) __explicitInterpAMD in float in_data_explicit;
layout(location = 1) sample noperspective        in float in_data_noperspective;
layout(location = 0) out vec4 out_color;
layout (binding = 0, std140) writeonly buffer Output {
    vec4 values [1048576];
} sb_out;

void main()
{
    uint index = (uint(gl_FragCoord.y) * 16 * 64) + uint(gl_FragCoord.x) * 64 + gl_SampleID;
    // Barycentric coodinates (I, J, K)
    vec3 bary_coord = vec3(gl_BaryCoordNoPerspSampleAMD.x, gl_BaryCoordNoPerspSampleAMD.y, 1.0f - gl_BaryCoordNoPerspSampleAMD.x - gl_BaryCoordNoPerspSampleAMD.y);

    // Vertex 0 -> (I = 0, J = 0, K = 1)
    float data0 = interpolateAtVertexAMD(in_data_explicit, 0);
    // Vertex 1 -> (I = 1, J = 0, K = 0)
    float data1 = interpolateAtVertexAMD(in_data_explicit, 1);
    // Vertex 1 -> (I = 0, J = 1, K = 0)
    float data2 = interpolateAtVertexAMD(in_data_explicit, 2);
    // Match data component with barycentric coordinate
    vec3  data  = vec3(data1, data2, data0);

    float res      = (bary_coord.x * data.x) + (bary_coord.y * data.y) + (bary_coord.z * data.z);
    float expected = in_data_noperspective;

    sb_out.values[ index ] = vec4(expected, res, 0u, 0u);

    const float threshold = 0.0005f;
    if (abs(res - expected) < threshold)
        out_color = vec4(0.0f, 1.0f, 0.0f, 1.0f);
    else
        out_color = vec4(1.0f, 0.0f, 0.0f, 1.0f);
}
#version 450
#extension GL_AMD_shader_explicit_vertex_parameter : require

layout(location = 0) __explicitInterpAMD in float in_data_explicit;
layout(location = 1) centroid noperspective        in float in_data_noperspective;
layout(location = 0) out vec4 out_color;
layout (binding = 0, std140) writeonly buffer Output {
    vec4 values [1048576];
} sb_out;

void main()
{
    uint index = (uint(gl_FragCoord.y) * 16 * 64) + uint(gl_FragCoord.x) * 64 + gl_SampleID;
    // Barycentric coodinates (I, J, K)
    vec3 bary_coord = vec3(gl_BaryCoordNoPerspCentroidAMD.x, gl_BaryCoordNoPerspCentroidAMD.y, 1.0f - gl_BaryCoordNoPerspCentroidAMD.x - gl_BaryCoordNoPerspCentroidAMD.y);

    // Vertex 0 -> (I = 0, J = 0, K = 1)
    float data0 = interpolateAtVertexAMD(in_data_explicit, 0);
    // Vertex 1 -> (I = 1, J = 0, K = 0)
    float data1 = interpolateAtVertexAMD(in_data_explicit, 1);
    // Vertex 1 -> (I = 0, J = 1, K = 0)
    float data2 = interpolateAtVertexAMD(in_data_explicit, 2);
    // Match data component with barycentric coordinate
    vec3  data  = vec3(data1, data2, data0);

    float res      = (bary_coord.x * data.x) + (bary_coord.y * data.y) + (bary_coord.z * data.z);
    float expected = in_data_noperspective;

    sb_out.values[ index ] = vec4(expected, res, 0u, 0u);

    const float threshold = 0.0005f;
    if (abs(res - expected) < threshold)
        out_color = vec4(0.0f, 1.0f, 0.0f, 1.0f);
    else
        out_color = vec4(1.0f, 0.0f, 0.0f, 1.0f);
}
