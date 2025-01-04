#version 460
layout (location=0) out vec4 outColor;
layout (rgba8, set=0, binding=0) uniform image2D img;
void main(){
    const vec4 geomColor = vec4(0.0, 0.0, 1.0, 1.0);
    const ivec2 iFragCoord = ivec2(gl_FragCoord.xy);
    const int yCoord = gl_SampleID;
    imageStore(img, ivec2(iFragCoord.x, yCoord), geomColor);
    outColor = geomColor;
}
