#version 450
#extension GL_EXT_mesh_shader : enable

layout(location = 0) perprimitiveEXT in PrimBlock {
    float field_a;
    vec3  field_b;
    float field_c;
} prim_in;

layout(location = 0) out vec4 outColor;

void main()
{
    uint  prim = uint(gl_PrimitiveID);
    float expA = 0.25 * float(prim) + 0.25;
    vec3  expB = vec3(0.5, 0.25 * float(prim) + 0.25, 0.75);
    float expC = 0.5  * float(prim) + 0.25;
    const float eps = 0.005;

    bool ok = abs(prim_in.field_a - expA) < eps
           && all(lessThan(abs(prim_in.field_b - expB), vec3(eps)))
           && abs(prim_in.field_c - expC) < eps;

    vec4 primColor = (prim == 0u) ? vec4(1.0, 0.0, 0.0, 1.0) : vec4(0.0, 1.0, 0.0, 1.0);
    outColor = ok ? primColor : vec4(1.0, 0.0, 1.0, 1.0);
}
