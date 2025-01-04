#version 460
layout (location=0) in vec4 inPos;
layout (location=1) in vec4 inExtraData;
layout (location=0) out flat int outInstanceIndex;





out gl_PerVertex {
    vec4  gl_Position;
    float gl_PointSize;
    float gl_ClipDistance[1];
    float gl_CullDistance[1];
};
void main (void) {
    gl_Position = inPos;
    gl_PointSize = 1.0;
    gl_ClipDistance[0] = inExtraData.x;
    gl_CullDistance[0] = inExtraData.y;
    outInstanceIndex = gl_InstanceIndex;
}
