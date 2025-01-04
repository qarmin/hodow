#version 450
layout(location = 0) in highp vec4 position;
layout(location = 1) in highp vec4 inColor;
layout(location = 0) out highp vec4 vtxColor;
out gl_PerVertex
{
  vec4 gl_Position;
};
layout(push_constant) uniform Material {
    layout(offset = 16) vec4 color;
}matInst;
void main()
{
    gl_Position = position;
    vtxColor = vec4(inColor.x + matInst.color.x,
                    inColor.y - matInst.color.y,
                    inColor.z + matInst.color.z,
                    inColor.w + matInst.color.w);
}
