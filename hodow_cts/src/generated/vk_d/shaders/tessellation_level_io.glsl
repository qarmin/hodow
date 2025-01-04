#version 450
vec4 positions[8] = vec4[](
    vec4(-1.0, -1.0, 0.0, 1.0),
    vec4( 1.0, -1.0, 0.0, 1.0),
    vec4(-1.0,  1.0, 0.0, 1.0),
    vec4( 1.0,  1.0, 0.0, 1.0),
    vec4(-0.5, -0.5, 0.0, 1.0),
    vec4( 0.5, -0.5, 0.0, 1.0),
    vec4(-0.5,  0.5, 0.0, 1.0),
    vec4( 0.5,  0.5, 0.0, 1.0)
);
out gl_PerVertex {
    vec4 gl_Position;
};
void main (void)
{
    gl_Position = positions[gl_VertexIndex];
}
#version 450
#extension GL_EXT_tessellation_shader : require

layout (vertices = 4) out;

layout (location=0) out patch vec4 perPatchColor;

in gl_PerVertex {
    vec4  gl_Position;
} gl_in[];

out gl_PerVertex {
    vec4  gl_Position;
} gl_out[];

void main ()
{
   perPatchColor = (gl_PrimitiveID == 0) ? vec4(0.0, 0.0, 1.0, 1.0) : vec4(1.0, 1.0, 0.0, 1.0);
   gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
   gl_TessLevelOuter = float[4](1.000000, 1.000000, 1.000000, 1.000000);
   gl_TessLevelInner = float[2](1.000000, 1.000000);
}
#version 450
layout(quads, equal_spacing) in;

layout (location=0) in patch vec4 perPatchColor;

layout (location=0) out vec4 outColor;

in gl_PerVertex {
    vec4  gl_Position;
} gl_in[];

out gl_PerVertex {
    vec4 gl_Position;
};
#define INTERP_QUAD_VAR(TYPE, VAR, INi, OUT) do { \
    TYPE VAR[4]; \
    for (int i = 0; i < 4; i++) VAR[i] = INi; \
    { \
        TYPE temp1 = TYPE(VAR[0] * TYPE(1 - gl_TessCoord[0]) + VAR[1] * TYPE(gl_TessCoord[0])); \
        TYPE temp2 = TYPE(VAR[2] * TYPE(1 - gl_TessCoord[0]) + VAR[3] * TYPE(gl_TessCoord[0])); \
        OUT = TYPE(temp1 * TYPE(1 - gl_TessCoord[1]) + temp2 * TYPE(gl_TessCoord[1])); \
    } \
} while(false)

void main ()
{
    float varInner0 = gl_TessLevelInner[0];
    float varInner1 = gl_TessLevelInner[1];
    vec4 colorData = vec4(perPatchColor.x * varInner0, perPatchColor.y * varInner1, perPatchColor.z * varInner0, perPatchColor.w * varInner1);
    outColor = colorData;
    INTERP_QUAD_VAR(vec4, var_gl_pos, gl_in[i].gl_Position, gl_Position);
}
#version 450
layout (location=0) in vec4 inColor;
layout (location=0) out vec4 outColor;
void main()
{
    outColor = inColor;
}
#version 450
layout(quads, equal_spacing) in;

layout (location=0) in patch vec4 perPatchColor;

layout (location=0) out vec4 outColor;

in gl_PerVertex {
    vec4  gl_Position;
} gl_in[];

out gl_PerVertex {
    vec4 gl_Position;
};
#define INTERP_QUAD_VAR(TYPE, VAR, INi, OUT) do { \
    TYPE VAR[4]; \
    for (int i = 0; i < 4; i++) VAR[i] = INi; \
    { \
        TYPE temp1 = TYPE(VAR[0] * TYPE(1 - gl_TessCoord[0]) + VAR[1] * TYPE(gl_TessCoord[0])); \
        TYPE temp2 = TYPE(VAR[2] * TYPE(1 - gl_TessCoord[0]) + VAR[3] * TYPE(gl_TessCoord[0])); \
        OUT = TYPE(temp1 * TYPE(1 - gl_TessCoord[1]) + temp2 * TYPE(gl_TessCoord[1])); \
    } \
} while(false)

void main ()
{
    float varOuter0 = gl_TessLevelOuter[0];
    float varOuter1 = gl_TessLevelOuter[1];
    float varOuter2 = gl_TessLevelOuter[2];
    float varOuter3 = gl_TessLevelOuter[3];
    vec4 colorData = vec4(perPatchColor.x * varOuter0, perPatchColor.y * varOuter1, perPatchColor.z * varOuter2, perPatchColor.w * varOuter3);
    outColor = colorData;
    INTERP_QUAD_VAR(vec4, var_gl_pos, gl_in[i].gl_Position, gl_Position);
}
#version 450
layout(quads, equal_spacing) in;

layout (location=0) in patch vec4 perPatchColor;

layout (location=0) out vec4 outColor;

in gl_PerVertex {
    vec4  gl_Position;
} gl_in[];

out gl_PerVertex {
    vec4 gl_Position;
};
#define INTERP_QUAD_VAR(TYPE, VAR, INi, OUT) do { \
    TYPE VAR[4]; \
    for (int i = 0; i < 4; i++) VAR[i] = INi; \
    { \
        TYPE temp1 = TYPE(VAR[0] * TYPE(1 - gl_TessCoord[0]) + VAR[1] * TYPE(gl_TessCoord[0])); \
        TYPE temp2 = TYPE(VAR[2] * TYPE(1 - gl_TessCoord[0]) + VAR[3] * TYPE(gl_TessCoord[0])); \
        OUT = TYPE(temp1 * TYPE(1 - gl_TessCoord[1]) + temp2 * TYPE(gl_TessCoord[1])); \
    } \
} while(false)

void main ()
{
    float varOuter0 = gl_TessLevelOuter[0];
    float varOuter1 = gl_TessLevelOuter[1];
    float varOuter2 = gl_TessLevelOuter[2];
    float varOuter3 = gl_TessLevelOuter[3];
    float varInner0 = gl_TessLevelInner[0];
    float varInner1 = gl_TessLevelInner[1];
    vec4 colorData = vec4(perPatchColor.x * varOuter0, perPatchColor.y * varOuter1, perPatchColor.z * varOuter2, perPatchColor.w * varOuter3);
    colorData = vec4(perPatchColor.x * varInner0, perPatchColor.y * varInner1, perPatchColor.z * varInner0, perPatchColor.w * varInner1);
    outColor = colorData;
    INTERP_QUAD_VAR(vec4, var_gl_pos, gl_in[i].gl_Position, gl_Position);
}
#version 450
#extension GL_EXT_tessellation_shader : require

layout (vertices = 4) out;

layout (location=0) out patch vec4 perPatchColor;

in gl_PerVertex {
    vec4  gl_Position;
} gl_in[];

out gl_PerVertex {
    vec4  gl_Position;
} gl_out[];

void main ()
{
   perPatchColor = (gl_PrimitiveID == 0) ? vec4(0.0, 0.0, 1.0, 1.0) : vec4(1.0, 1.0, 0.0, 1.0);
   gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
   gl_TessLevelOuter = float[4](0.000000, 1.000000, 1.000000, 1.000000);
   gl_TessLevelInner = float[2](1.000000, 1.000000);
}
#version 450
layout(quads, equal_spacing) in;

layout (location=0) in patch vec4 perPatchColor;

layout (location=0) out vec4 outColor;

in gl_PerVertex {
    vec4  gl_Position;
} gl_in[];

out gl_PerVertex {
    vec4 gl_Position;
};
#define INTERP_QUAD_VAR(TYPE, VAR, INi, OUT) do { \
    TYPE VAR[4]; \
    for (int i = 0; i < 4; i++) VAR[i] = INi; \
    { \
        TYPE temp1 = TYPE(VAR[0] * TYPE(1 - gl_TessCoord[0]) + VAR[1] * TYPE(gl_TessCoord[0])); \
        TYPE temp2 = TYPE(VAR[2] * TYPE(1 - gl_TessCoord[0]) + VAR[3] * TYPE(gl_TessCoord[0])); \
        OUT = TYPE(temp1 * TYPE(1 - gl_TessCoord[1]) + temp2 * TYPE(gl_TessCoord[1])); \
    } \
} while(false)

void main ()
{
    outColor = perPatchColor;
    INTERP_QUAD_VAR(vec4, var_gl_pos, gl_in[i].gl_Position, gl_Position);
}
#version 450
#extension GL_EXT_tessellation_shader : require

layout (vertices = 4) out;

layout (location=0) out patch vec4 perPatchColor;

in gl_PerVertex {
    vec4  gl_Position;
} gl_in[];

out gl_PerVertex {
    vec4  gl_Position;
} gl_out[];

void main ()
{
   perPatchColor = (gl_PrimitiveID == 0) ? vec4(0.0, 0.0, 1.0, 1.0) : vec4(1.0, 1.0, 0.0, 1.0);
   gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
   gl_TessLevelOuter = float[4](0.000000, 0.000000, 0.000000, 0.000000);
   gl_TessLevelInner = float[2](1.000000, 1.000000);
}
#version 450
#extension GL_EXT_tessellation_shader : require

layout (vertices = 4) out;

layout (location=0) out patch vec4 perPatchColor;

in gl_PerVertex {
    vec4  gl_Position;
} gl_in[];

out gl_PerVertex {
    vec4  gl_Position;
} gl_out[];

void main ()
{
   perPatchColor = (gl_PrimitiveID == 0) ? vec4(0.0, 0.0, 1.0, 1.0) : vec4(1.0, 1.0, 0.0, 1.0);
   gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
   gl_TessLevelOuter = float[4](0.000000, 0.000000, 0.000000, 0.000000);
   gl_TessLevelInner = float[2](0.000000, 0.000000);
}
