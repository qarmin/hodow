#version 460
layout (location=0) in vec4 inPos;
layout (location=1) in vec4 inExtraData;
layout (location=0) out flat int outInstanceIndex;
layout (location=1) out flat int drawIndex;

layout (location=2) out flat int baseVertex;

layout (location=3) out flat int baseInstance;

layout (set=0, binding=0, std430) readonly buffer Buffer0 { int values[8]; } buffer0;
layout (set=0, binding=1, std430) readonly buffer Buffer1 { int values[12]; } buffer1;
layout (set=0, binding=2, std430) readonly buffer Buffer2 { int values[16]; } buffer2;
layout (set=0, binding=3, std430) readonly buffer Buffer3 { int values[20]; } buffer3;

layout (location=5) out flat int iovar0;
layout (location=6) out flat int iovar1;
layout (location=7) out flat int iovar2;
layout (location=8) out flat int iovar3;
layout (location=9) out flat int iovar4;
layout (location=10) out flat int iovar5;
layout (location=11) out flat int iovar6;
layout (location=12) out flat int iovar7;
layout (location=13) out flat int iovar8;
layout (location=14) out flat int iovar9;
layout (location=15) out flat int iovar10;
layout (location=16) out flat int iovar11;
layout (location=17) out flat int iovar12;
layout (location=18) out flat int iovar13;
layout (location=19) out flat int iovar14;
layout (location=20) out flat int iovar15;
layout (location=21) out flat int iovar16;
layout (location=22) out flat int iovar17;
layout (location=23) out flat int iovar18;
layout (location=24) out flat int iovar19;

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
    drawIndex = gl_DrawID;
    baseVertex = gl_BaseVertex;
    baseInstance = gl_BaseInstance;
    iovar0 = buffer3.values[0];
    iovar1 = buffer3.values[1];
    iovar2 = buffer3.values[2];
    iovar3 = buffer3.values[3];
    iovar4 = buffer3.values[4];
    iovar5 = buffer3.values[5];
    iovar6 = buffer3.values[6];
    iovar7 = buffer3.values[7];
    iovar8 = buffer3.values[8];
    iovar9 = buffer3.values[9];
    iovar10 = buffer3.values[10];
    iovar11 = buffer3.values[11];
    iovar12 = buffer3.values[12];
    iovar13 = buffer3.values[13];
    iovar14 = buffer3.values[14];
    iovar15 = buffer3.values[15];
    iovar16 = buffer3.values[16];
    iovar17 = buffer3.values[17];
    iovar18 = buffer3.values[18];
    iovar19 = buffer3.values[19];
}
