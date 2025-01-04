#version 450

#extension GL_ARB_sparse_texture2 : require
#extension GL_ARB_sparse_texture_clamp : require

uniform sampler2D tex;

layout (location = 0) out vec4 spCol;

void main()
{
    vec2 p = vec2(0.0);

    sparseTextureClampARB(tex, p, 0.5, spCol);
}
