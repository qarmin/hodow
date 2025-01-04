#version 450 core
layout(location = 0) in vec2 position;
out gl_PerVertex
{
   vec4 gl_Position;
};
void main()
{
  gl_Position = vec4(position, 0, 1);
}
#version 450 core
layout(push_constant) uniform PC {
    uvec2 shadingRate[2];
} pc;
layout(location = 0) out uvec2 col0;
void main()
{
  col0.x = (uint(gl_FragCoord.x) % pc.shadingRate[0].x) + ((uint(gl_FragCoord.y) % pc.shadingRate[0].y) * pc.shadingRate[0].x);
  col0.y = (uint(gl_FragCoord.x) % pc.shadingRate[1].x) + ((uint(gl_FragCoord.y) % pc.shadingRate[1].y) * pc.shadingRate[1].x);
}
#version 450 core
layout(input_attachment_index=0, set=0, binding=0) uniform usubpassInput inputAttachment;
layout(location = 0) out uvec2 col0;
void main()
{
  col0 = subpassLoad(inputAttachment).xy;
}
#version 450 core
layout(input_attachment_index=0, set=0, binding=0) uniform usubpassInputMS inputAttachment;
layout(location = 0) out uvec2 col0;
void main()
{
  col0 = subpassLoad(inputAttachment, 0).xy;
}
#version 450 core
layout(location = 0) in vec2 position;
out gl_PerVertex
{
   vec4 gl_Position;
};
void main()
{
  gl_Position = vec4(position, position);
}
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
