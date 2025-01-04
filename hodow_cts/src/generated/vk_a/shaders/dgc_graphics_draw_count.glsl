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
#version 460
layout (location=0) in flat int inInstanceIndex;
layout (location=0) out vec4 outColor;



void main (void) {
    const float red   = float(inInstanceIndex) / 255.0;
    const float green = 0.0;
    bool blueOK = true;
    const float blue  = (blueOK ? 1.0 : 0.0);
    outColor = vec4(red, green, blue, 1.0);
}
#version 460
layout (location=0) in vec4 inPos;
layout (location=1) in vec4 inExtraData;
layout (location=0) out flat int outInstanceIndex;
layout (location=1) out flat int drawIndex;

layout (location=2) out flat int baseVertex;

layout (location=3) out flat int baseInstance;



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
}
#version 460
layout (location=0) in flat int inInstanceIndex;
layout (location=1) in flat int drawIndex;
layout (location=2) in flat int baseVertex;
layout (location=3) in flat int baseInstance;
layout (location=0) out vec4 outColor;

layout (set=1, binding=0, std430) readonly buffer ExpectedDrawParams { ivec4 values[]; } edp;
layout (push_constant, std430) uniform PushConstantBlock { uvec2 dim; } pc;


void main (void) {
    const uint pixelIdx = uint(gl_FragCoord.y) * pc.dim.x + uint(gl_FragCoord.x);
    const float red   = float(inInstanceIndex) / 255.0;
    const float green = 0.0;
    bool blueOK = true;
    blueOK = (blueOK && (drawIndex == edp.values[pixelIdx].x));
    blueOK = (blueOK && (baseVertex == edp.values[pixelIdx].y));
    blueOK = (blueOK && (baseInstance == edp.values[pixelIdx].z));
    const float blue  = (blueOK ? 1.0 : 0.0);
    outColor = vec4(red, green, blue, 1.0);
}
#version 460
layout (location=0) in vec4 inPos;
layout (location=1) in vec4 inExtraData;
layout (location=0) out flat int outInstanceIndex;



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
    iovar0 = buffer0.values[0];
    iovar1 = buffer0.values[1];
    iovar2 = buffer0.values[2];
    iovar3 = buffer0.values[3];
    iovar4 = buffer0.values[4];
    iovar5 = buffer0.values[5];
    iovar6 = buffer0.values[6];
    iovar7 = buffer0.values[7];
}
#version 460
layout (location=0) in flat int inInstanceIndex;
layout (location=0) out vec4 outColor;

layout (set=1, binding=0, std430) readonly buffer ExpectedAccum { int values[]; } ea;
layout (push_constant, std430) uniform PushConstantBlock { uvec2 dim; } pc;

layout (location=5) in flat int iovar0;
layout (location=6) in flat int iovar1;
layout (location=7) in flat int iovar2;
layout (location=8) in flat int iovar3;
layout (location=9) in flat int iovar4;
layout (location=10) in flat int iovar5;
layout (location=11) in flat int iovar6;
layout (location=12) in flat int iovar7;

void main (void) {
    const uint pixelIdx = uint(gl_FragCoord.y) * pc.dim.x + uint(gl_FragCoord.x);
    int accum = 0;
    accum += iovar0;
    accum += iovar1;
    accum += iovar2;
    accum += iovar3;
    accum += iovar4;
    accum += iovar5;
    accum += iovar6;
    accum += iovar7;
    const float red   = float(inInstanceIndex) / 255.0;
    const float green = ((accum == ea.values[pixelIdx]) ? 0.0 : 1.0);
    bool blueOK = true;
    const float blue  = (blueOK ? 1.0 : 0.0);
    outColor = vec4(red, green, blue, 1.0);
}
#version 460
layout (location=0) in vec4 inPos;
layout (location=1) in vec4 inExtraData;
layout (location=0) out flat int outInstanceIndex;



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
    iovar0 = buffer1.values[0];
    iovar1 = buffer1.values[1];
    iovar2 = buffer1.values[2];
    iovar3 = buffer1.values[3];
    iovar4 = buffer1.values[4];
    iovar5 = buffer1.values[5];
    iovar6 = buffer1.values[6];
    iovar7 = buffer1.values[7];
    iovar8 = buffer1.values[8];
    iovar9 = buffer1.values[9];
    iovar10 = buffer1.values[10];
    iovar11 = buffer1.values[11];
}
#version 460
layout (location=0) in flat int inInstanceIndex;
layout (location=0) out vec4 outColor;

layout (set=1, binding=0, std430) readonly buffer ExpectedAccum { int values[]; } ea;
layout (push_constant, std430) uniform PushConstantBlock { uvec2 dim; } pc;

layout (location=5) in flat int iovar0;
layout (location=6) in flat int iovar1;
layout (location=7) in flat int iovar2;
layout (location=8) in flat int iovar3;
layout (location=9) in flat int iovar4;
layout (location=10) in flat int iovar5;
layout (location=11) in flat int iovar6;
layout (location=12) in flat int iovar7;
layout (location=13) in flat int iovar8;
layout (location=14) in flat int iovar9;
layout (location=15) in flat int iovar10;
layout (location=16) in flat int iovar11;

void main (void) {
    const uint pixelIdx = uint(gl_FragCoord.y) * pc.dim.x + uint(gl_FragCoord.x);
    int accum = 0;
    accum += iovar0;
    accum += iovar1;
    accum += iovar2;
    accum += iovar3;
    accum += iovar4;
    accum += iovar5;
    accum += iovar6;
    accum += iovar7;
    accum += iovar8;
    accum += iovar9;
    accum += iovar10;
    accum += iovar11;
    const float red   = float(inInstanceIndex) / 255.0;
    const float green = ((accum == ea.values[pixelIdx]) ? 0.0 : 1.0);
    bool blueOK = true;
    const float blue  = (blueOK ? 1.0 : 0.0);
    outColor = vec4(red, green, blue, 1.0);
}
#version 460
layout (location=0) in vec4 inPos;
layout (location=1) in vec4 inExtraData;
layout (location=0) out flat int outInstanceIndex;



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
    iovar0 = buffer2.values[0];
    iovar1 = buffer2.values[1];
    iovar2 = buffer2.values[2];
    iovar3 = buffer2.values[3];
    iovar4 = buffer2.values[4];
    iovar5 = buffer2.values[5];
    iovar6 = buffer2.values[6];
    iovar7 = buffer2.values[7];
    iovar8 = buffer2.values[8];
    iovar9 = buffer2.values[9];
    iovar10 = buffer2.values[10];
    iovar11 = buffer2.values[11];
    iovar12 = buffer2.values[12];
    iovar13 = buffer2.values[13];
    iovar14 = buffer2.values[14];
    iovar15 = buffer2.values[15];
}
#version 460
layout (location=0) in flat int inInstanceIndex;
layout (location=0) out vec4 outColor;

layout (set=1, binding=0, std430) readonly buffer ExpectedAccum { int values[]; } ea;
layout (push_constant, std430) uniform PushConstantBlock { uvec2 dim; } pc;

layout (location=5) in flat int iovar0;
layout (location=6) in flat int iovar1;
layout (location=7) in flat int iovar2;
layout (location=8) in flat int iovar3;
layout (location=9) in flat int iovar4;
layout (location=10) in flat int iovar5;
layout (location=11) in flat int iovar6;
layout (location=12) in flat int iovar7;
layout (location=13) in flat int iovar8;
layout (location=14) in flat int iovar9;
layout (location=15) in flat int iovar10;
layout (location=16) in flat int iovar11;
layout (location=17) in flat int iovar12;
layout (location=18) in flat int iovar13;
layout (location=19) in flat int iovar14;
layout (location=20) in flat int iovar15;

void main (void) {
    const uint pixelIdx = uint(gl_FragCoord.y) * pc.dim.x + uint(gl_FragCoord.x);
    int accum = 0;
    accum += iovar0;
    accum += iovar1;
    accum += iovar2;
    accum += iovar3;
    accum += iovar4;
    accum += iovar5;
    accum += iovar6;
    accum += iovar7;
    accum += iovar8;
    accum += iovar9;
    accum += iovar10;
    accum += iovar11;
    accum += iovar12;
    accum += iovar13;
    accum += iovar14;
    accum += iovar15;
    const float red   = float(inInstanceIndex) / 255.0;
    const float green = ((accum == ea.values[pixelIdx]) ? 0.0 : 1.0);
    bool blueOK = true;
    const float blue  = (blueOK ? 1.0 : 0.0);
    outColor = vec4(red, green, blue, 1.0);
}
#version 460
layout (location=0) in vec4 inPos;
layout (location=1) in vec4 inExtraData;
layout (location=0) out flat int outInstanceIndex;



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
#version 460
layout (location=0) in flat int inInstanceIndex;
layout (location=0) out vec4 outColor;

layout (set=1, binding=0, std430) readonly buffer ExpectedAccum { int values[]; } ea;
layout (push_constant, std430) uniform PushConstantBlock { uvec2 dim; } pc;

layout (location=5) in flat int iovar0;
layout (location=6) in flat int iovar1;
layout (location=7) in flat int iovar2;
layout (location=8) in flat int iovar3;
layout (location=9) in flat int iovar4;
layout (location=10) in flat int iovar5;
layout (location=11) in flat int iovar6;
layout (location=12) in flat int iovar7;
layout (location=13) in flat int iovar8;
layout (location=14) in flat int iovar9;
layout (location=15) in flat int iovar10;
layout (location=16) in flat int iovar11;
layout (location=17) in flat int iovar12;
layout (location=18) in flat int iovar13;
layout (location=19) in flat int iovar14;
layout (location=20) in flat int iovar15;
layout (location=21) in flat int iovar16;
layout (location=22) in flat int iovar17;
layout (location=23) in flat int iovar18;
layout (location=24) in flat int iovar19;

void main (void) {
    const uint pixelIdx = uint(gl_FragCoord.y) * pc.dim.x + uint(gl_FragCoord.x);
    int accum = 0;
    accum += iovar0;
    accum += iovar1;
    accum += iovar2;
    accum += iovar3;
    accum += iovar4;
    accum += iovar5;
    accum += iovar6;
    accum += iovar7;
    accum += iovar8;
    accum += iovar9;
    accum += iovar10;
    accum += iovar11;
    accum += iovar12;
    accum += iovar13;
    accum += iovar14;
    accum += iovar15;
    accum += iovar16;
    accum += iovar17;
    accum += iovar18;
    accum += iovar19;
    const float red   = float(inInstanceIndex) / 255.0;
    const float green = ((accum == ea.values[pixelIdx]) ? 0.0 : 1.0);
    bool blueOK = true;
    const float blue  = (blueOK ? 1.0 : 0.0);
    outColor = vec4(red, green, blue, 1.0);
}
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
    iovar0 = buffer0.values[0];
    iovar1 = buffer0.values[1];
    iovar2 = buffer0.values[2];
    iovar3 = buffer0.values[3];
    iovar4 = buffer0.values[4];
    iovar5 = buffer0.values[5];
    iovar6 = buffer0.values[6];
    iovar7 = buffer0.values[7];
}
#version 460
layout (location=0) in flat int inInstanceIndex;
layout (location=1) in flat int drawIndex;
layout (location=2) in flat int baseVertex;
layout (location=3) in flat int baseInstance;
layout (location=0) out vec4 outColor;

layout (set=1, binding=0, std430) readonly buffer ExpectedAccum { int values[]; } ea;
layout (set=1, binding=1, std430) readonly buffer ExpectedDrawParams { ivec4 values[]; } edp;
layout (push_constant, std430) uniform PushConstantBlock { uvec2 dim; } pc;

layout (location=5) in flat int iovar0;
layout (location=6) in flat int iovar1;
layout (location=7) in flat int iovar2;
layout (location=8) in flat int iovar3;
layout (location=9) in flat int iovar4;
layout (location=10) in flat int iovar5;
layout (location=11) in flat int iovar6;
layout (location=12) in flat int iovar7;

void main (void) {
    const uint pixelIdx = uint(gl_FragCoord.y) * pc.dim.x + uint(gl_FragCoord.x);
    int accum = 0;
    accum += iovar0;
    accum += iovar1;
    accum += iovar2;
    accum += iovar3;
    accum += iovar4;
    accum += iovar5;
    accum += iovar6;
    accum += iovar7;
    const float red   = float(inInstanceIndex) / 255.0;
    const float green = ((accum == ea.values[pixelIdx]) ? 0.0 : 1.0);
    bool blueOK = true;
    blueOK = (blueOK && (drawIndex == edp.values[pixelIdx].x));
    blueOK = (blueOK && (baseVertex == edp.values[pixelIdx].y));
    blueOK = (blueOK && (baseInstance == edp.values[pixelIdx].z));
    const float blue  = (blueOK ? 1.0 : 0.0);
    outColor = vec4(red, green, blue, 1.0);
}
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
    iovar0 = buffer1.values[0];
    iovar1 = buffer1.values[1];
    iovar2 = buffer1.values[2];
    iovar3 = buffer1.values[3];
    iovar4 = buffer1.values[4];
    iovar5 = buffer1.values[5];
    iovar6 = buffer1.values[6];
    iovar7 = buffer1.values[7];
    iovar8 = buffer1.values[8];
    iovar9 = buffer1.values[9];
    iovar10 = buffer1.values[10];
    iovar11 = buffer1.values[11];
}
#version 460
layout (location=0) in flat int inInstanceIndex;
layout (location=1) in flat int drawIndex;
layout (location=2) in flat int baseVertex;
layout (location=3) in flat int baseInstance;
layout (location=0) out vec4 outColor;

layout (set=1, binding=0, std430) readonly buffer ExpectedAccum { int values[]; } ea;
layout (set=1, binding=1, std430) readonly buffer ExpectedDrawParams { ivec4 values[]; } edp;
layout (push_constant, std430) uniform PushConstantBlock { uvec2 dim; } pc;

layout (location=5) in flat int iovar0;
layout (location=6) in flat int iovar1;
layout (location=7) in flat int iovar2;
layout (location=8) in flat int iovar3;
layout (location=9) in flat int iovar4;
layout (location=10) in flat int iovar5;
layout (location=11) in flat int iovar6;
layout (location=12) in flat int iovar7;
layout (location=13) in flat int iovar8;
layout (location=14) in flat int iovar9;
layout (location=15) in flat int iovar10;
layout (location=16) in flat int iovar11;

void main (void) {
    const uint pixelIdx = uint(gl_FragCoord.y) * pc.dim.x + uint(gl_FragCoord.x);
    int accum = 0;
    accum += iovar0;
    accum += iovar1;
    accum += iovar2;
    accum += iovar3;
    accum += iovar4;
    accum += iovar5;
    accum += iovar6;
    accum += iovar7;
    accum += iovar8;
    accum += iovar9;
    accum += iovar10;
    accum += iovar11;
    const float red   = float(inInstanceIndex) / 255.0;
    const float green = ((accum == ea.values[pixelIdx]) ? 0.0 : 1.0);
    bool blueOK = true;
    blueOK = (blueOK && (drawIndex == edp.values[pixelIdx].x));
    blueOK = (blueOK && (baseVertex == edp.values[pixelIdx].y));
    blueOK = (blueOK && (baseInstance == edp.values[pixelIdx].z));
    const float blue  = (blueOK ? 1.0 : 0.0);
    outColor = vec4(red, green, blue, 1.0);
}
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
    iovar0 = buffer2.values[0];
    iovar1 = buffer2.values[1];
    iovar2 = buffer2.values[2];
    iovar3 = buffer2.values[3];
    iovar4 = buffer2.values[4];
    iovar5 = buffer2.values[5];
    iovar6 = buffer2.values[6];
    iovar7 = buffer2.values[7];
    iovar8 = buffer2.values[8];
    iovar9 = buffer2.values[9];
    iovar10 = buffer2.values[10];
    iovar11 = buffer2.values[11];
    iovar12 = buffer2.values[12];
    iovar13 = buffer2.values[13];
    iovar14 = buffer2.values[14];
    iovar15 = buffer2.values[15];
}
#version 460
layout (location=0) in flat int inInstanceIndex;
layout (location=1) in flat int drawIndex;
layout (location=2) in flat int baseVertex;
layout (location=3) in flat int baseInstance;
layout (location=0) out vec4 outColor;

layout (set=1, binding=0, std430) readonly buffer ExpectedAccum { int values[]; } ea;
layout (set=1, binding=1, std430) readonly buffer ExpectedDrawParams { ivec4 values[]; } edp;
layout (push_constant, std430) uniform PushConstantBlock { uvec2 dim; } pc;

layout (location=5) in flat int iovar0;
layout (location=6) in flat int iovar1;
layout (location=7) in flat int iovar2;
layout (location=8) in flat int iovar3;
layout (location=9) in flat int iovar4;
layout (location=10) in flat int iovar5;
layout (location=11) in flat int iovar6;
layout (location=12) in flat int iovar7;
layout (location=13) in flat int iovar8;
layout (location=14) in flat int iovar9;
layout (location=15) in flat int iovar10;
layout (location=16) in flat int iovar11;
layout (location=17) in flat int iovar12;
layout (location=18) in flat int iovar13;
layout (location=19) in flat int iovar14;
layout (location=20) in flat int iovar15;

void main (void) {
    const uint pixelIdx = uint(gl_FragCoord.y) * pc.dim.x + uint(gl_FragCoord.x);
    int accum = 0;
    accum += iovar0;
    accum += iovar1;
    accum += iovar2;
    accum += iovar3;
    accum += iovar4;
    accum += iovar5;
    accum += iovar6;
    accum += iovar7;
    accum += iovar8;
    accum += iovar9;
    accum += iovar10;
    accum += iovar11;
    accum += iovar12;
    accum += iovar13;
    accum += iovar14;
    accum += iovar15;
    const float red   = float(inInstanceIndex) / 255.0;
    const float green = ((accum == ea.values[pixelIdx]) ? 0.0 : 1.0);
    bool blueOK = true;
    blueOK = (blueOK && (drawIndex == edp.values[pixelIdx].x));
    blueOK = (blueOK && (baseVertex == edp.values[pixelIdx].y));
    blueOK = (blueOK && (baseInstance == edp.values[pixelIdx].z));
    const float blue  = (blueOK ? 1.0 : 0.0);
    outColor = vec4(red, green, blue, 1.0);
}
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
#version 460
layout (location=0) in flat int inInstanceIndex;
layout (location=1) in flat int drawIndex;
layout (location=2) in flat int baseVertex;
layout (location=3) in flat int baseInstance;
layout (location=0) out vec4 outColor;

layout (set=1, binding=0, std430) readonly buffer ExpectedAccum { int values[]; } ea;
layout (set=1, binding=1, std430) readonly buffer ExpectedDrawParams { ivec4 values[]; } edp;
layout (push_constant, std430) uniform PushConstantBlock { uvec2 dim; } pc;

layout (location=5) in flat int iovar0;
layout (location=6) in flat int iovar1;
layout (location=7) in flat int iovar2;
layout (location=8) in flat int iovar3;
layout (location=9) in flat int iovar4;
layout (location=10) in flat int iovar5;
layout (location=11) in flat int iovar6;
layout (location=12) in flat int iovar7;
layout (location=13) in flat int iovar8;
layout (location=14) in flat int iovar9;
layout (location=15) in flat int iovar10;
layout (location=16) in flat int iovar11;
layout (location=17) in flat int iovar12;
layout (location=18) in flat int iovar13;
layout (location=19) in flat int iovar14;
layout (location=20) in flat int iovar15;
layout (location=21) in flat int iovar16;
layout (location=22) in flat int iovar17;
layout (location=23) in flat int iovar18;
layout (location=24) in flat int iovar19;

void main (void) {
    const uint pixelIdx = uint(gl_FragCoord.y) * pc.dim.x + uint(gl_FragCoord.x);
    int accum = 0;
    accum += iovar0;
    accum += iovar1;
    accum += iovar2;
    accum += iovar3;
    accum += iovar4;
    accum += iovar5;
    accum += iovar6;
    accum += iovar7;
    accum += iovar8;
    accum += iovar9;
    accum += iovar10;
    accum += iovar11;
    accum += iovar12;
    accum += iovar13;
    accum += iovar14;
    accum += iovar15;
    accum += iovar16;
    accum += iovar17;
    accum += iovar18;
    accum += iovar19;
    const float red   = float(inInstanceIndex) / 255.0;
    const float green = ((accum == ea.values[pixelIdx]) ? 0.0 : 1.0);
    bool blueOK = true;
    blueOK = (blueOK && (drawIndex == edp.values[pixelIdx].x));
    blueOK = (blueOK && (baseVertex == edp.values[pixelIdx].y));
    blueOK = (blueOK && (baseInstance == edp.values[pixelIdx].z));
    const float blue  = (blueOK ? 1.0 : 0.0);
    outColor = vec4(red, green, blue, 1.0);
}
