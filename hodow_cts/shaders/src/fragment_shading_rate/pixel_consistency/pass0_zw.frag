#version 450 core
layout(push_constant) uniform PC {
    uvec2 shadingRate[2];
} pc;
layout(location = 0) out uvec2 col0;
void main()
{
  col0.x = (uint(gl_FragCoord.z) % pc.shadingRate[0].x) + ((uint(gl_FragCoord.w) % pc.shadingRate[0].y) * pc.shadingRate[0].x);
  col0.y = (uint(gl_FragCoord.z) % pc.shadingRate[1].x) + ((uint(gl_FragCoord.w) % pc.shadingRate[1].y) * pc.shadingRate[1].x);
}
