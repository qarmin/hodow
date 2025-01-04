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
